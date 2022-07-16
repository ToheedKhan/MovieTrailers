//
//  MovieViewController.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 29/06/22.
//

import UIKit

class MovieListViewController: UIViewController, Alertable {
    
    //MARK:- Layout:-
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- Variable & Constants:
    var viewModel: MoviesListViewModelProtocol?
    
    let refreshControl = UIRefreshControl()
    
    //MARK:- Life Cycle:-
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bind(to: viewModel)
        viewModel?.getMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
        self.navigationItem.title = viewModel?.screenTitle
    }
    private func bind(to viewModel: MoviesListViewModelProtocol?) {
        viewModel?.cellViewModels.observe(on: self) { [weak self] _ in self?.updateItems() }
        viewModel?.error.observe(on: self) { [weak self] in self?.showError($0) }
    }
    //MARK:- Refresh Update
    @objc func refresh(){
        viewModel?.isRefresh?(true)
        viewModel?.getMovies()
    }
    
    // MARK: - Private
    private func addAccessibilityIdentifier() {
        tableView.accessibilityIdentifier = MovieSceneAccessibilityIdentifier.movieTableView
        if #available(iOS 13.0, *) {
            searchBar.searchTextField.accessibilityIdentifier = MovieSceneAccessibilityIdentifier.searchField
        }
    }
    
    private func setupViews() {
//        title = viewModel.screenTitle
        setupTableView()
        setupSearchBar()
        addAccessibilityIdentifier()
    }
    
    private func setupSearchBar() {
        // Change the Tint Color
        self.searchBar.barTintColor = AppTheme.darkishPink
        self.searchBar.tintColor = UIColor.white
        // Show/Hide Cancel Button
        self.searchBar.showsCancelButton = true
        
        // Change TextField Colors
        let searchTextField = self.searchBar.searchTextField
        searchTextField.textColor = UIColor.white
        searchTextField.clearButtonMode = .never
        searchTextField.backgroundColor = DesignSystem.Colors.pinkColor.color
        
        // Change Glass Icon Color
        let glassIconView = searchTextField.leftView as! UIImageView
        glassIconView.image = glassIconView.image?.withRenderingMode(.alwaysTemplate)
        glassIconView.tintColor = AppTheme.darkishPink
        
        if let newPosition = searchTextField.position(from: searchTextField.beginningOfDocument, in: UITextLayoutDirection.down, offset: 50) {
            searchTextField.selectedTextRange = searchTextField.textRange(from: newPosition, to: newPosition)
        }
        self.searchBar.keyboardAppearance = .dark
    }
    
    private func setupNavigation() {
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor : AppTheme.darkishPink ?? UIColor.black]
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : AppTheme.darkishPink ?? UIColor.black]
        navigationController?.navigationBar.tintColor = AppTheme.darkishPink
    }
   
    private func updateItems() {
        guard let cellViewModels = viewModel?.cellViewModels.value,  !cellViewModels.isEmpty else {
            showAlert(title: "Attention", message: "No Data Found")
            return
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func showError(_ error: String) {
        guard !error.isEmpty else { return }
        showAlert(title: "Attention", message: "Something went wrong")
    }
    
}

//MARK:- Setup View Model
extension MovieListViewController {
    
    func setupViewModel() {
       
        viewModel?.loading = { isLoading in
            guard isLoading else{
                LoadingIndicator.shared.hide()
                return
            }
            LoadingIndicator.shared.show(for: self.view)
        }
        
        viewModel?.isRefresh = { [weak self] (isRefresh) in
            guard isRefresh else {
                DispatchQueue.main.async {
                    self?.refreshControl.endRefreshing()
                }
                return
            }
        }
      
    } 
}

//MARK:- Table View Data Source
extension MovieListViewController: UITableViewDataSource {
    
    fileprivate func setupTableView(){
        self.tableView.isHidden = false
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        tableView.addSubview(refreshControl)
//        self.tableView.register(cell: MovieTableCell.self)
        self.tableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.cellViewModels.value.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let cell = tableView.dequeue() as MovieTableCell
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableCell.reuseIdentifier) as! MovieTableCell
        cell.cellViewModel = viewModel?.cellViewModels.value[indexPath.row]
       
        return cell
    }
    
}

//MARK:- Table View Delegate

extension MovieListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ((viewModel?.cellViewModels.value.isEmpty) != nil)
                                          ? MovieTableCell.height
                                          : tableView.frame.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        // Remove highlight from the selected cell
        tableView.deselectRow(at: indexPath, animated: true)
        // Close keyboard when you select cell
        self.searchBar.searchTextField.endEditing(true)
    }
}

//MARK:- Navigation

extension MovieListViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowDetail" {
            
            if let destinationViewController = segue.destination as? MovieDetailViewController
            {
                let indexPath = self.tableView.indexPathForSelectedRow!
                destinationViewController.viewModel = MovieDetailViewModel(movie: viewModel?.cellViewModels.value[indexPath.row] ?? nil)
            }
        }
    }
}

//MARK: - UISearchBarDelegate

extension MovieListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.didSearch(searchText: searchText)
        }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        viewModel?.didCancelSearch()
        view.endEditing(true)
    }
}
