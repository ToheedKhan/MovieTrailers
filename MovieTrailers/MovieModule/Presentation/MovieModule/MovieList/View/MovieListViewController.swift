//
//  MovieViewController.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 29/06/22.
//

import UIKit

class MovieListViewController: UIViewController, Alertable, ColorProvider {
    
    //MARK:- Layout:-
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- Variable & Constants:
    var viewModel: MoviesListViewModelProtocol?
    weak var movieListChildCoordinator: MovieListChildCoordinator?

    
    let refreshControl = UIRefreshControl()
    
    //MARK:- Life Cycle:-
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupViewModel()
        setupResponses()
        viewModel?.getMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
        self.navigationItem.title = viewModel?.screenTitle
    }
    
    //MARK:- Refresh Update
    @objc func refresh(){
        viewModel?.isRefresh(true)
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
        searchTextField.backgroundColor = pinkColor
        searchTextField.clearButtonMode = .whileEditing
        
        //Add action for clear button
        if let searchTextField = self.searchBar.value(forKey: "searchField") as? UITextField , let clearButton = searchTextField.value(forKey: "_clearButton")as? UIButton {
            
            clearButton.addTarget(self, action: #selector(searchBarClearButtonAction), for: .touchUpInside)
        }
        
        // Change Glass Icon Color
        let glassIconView = searchTextField.leftView as! UIImageView
        glassIconView.image = glassIconView.image?.withRenderingMode(.alwaysTemplate)
        glassIconView.tintColor = UIColor.white
        
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
    
    @objc func searchBarClearButtonAction(sender:UIButton){
        viewModel?.didCancelSearch()
    }
}

//MARK: - Setup View Model
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
    
    private func setupResponses() {
        viewModel?.successResponse = { [weak self] in
            DispatchQueue.main.async {
                self?.updateItems()
            }
        }
        
        viewModel?.errorResponse = { [weak self] error in
            DispatchQueue.main.async {
                self?.showError(error)
            }
        }
    }
    
    private func updateItems() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        guard let movieListViewModel = viewModel, !movieListViewModel.cellViewModels.isEmpty else {
            guard let movieListViewModel = viewModel, !movieListViewModel.isSearching else { return }
            showAlert(title: "Attention", message: "No Data Found")
            return
        }
    }
    
    private func showError(_ error: String) {
        guard !error.isEmpty else { return }
        showAlert(title: "Attention", message: "Something went wrong")
    }
    
//MARK: - Navigation
    private func navigateToMovieDetailView(index: Int) {
        guard let childCoordinator = movieListChildCoordinator,
            let selectedMovieCellVM = viewModel?.cellViewModels[index] else { return }
        childCoordinator.navigateToMovieDetailVC(viewModel: selectedMovieCellVM)
    }
}

//MARK: - UITableViewDataSource
extension MovieListViewController: UITableViewDataSource {
    
    private func setupTableView(){
        self.tableView.isHidden = false
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        tableView.addSubview(refreshControl)
        self.tableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.cellViewModels.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let cell = tableView.dequeue() as MovieTableCell
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableCell.reuseIdentifier) as! MovieTableCell
        cell.cellViewModel = viewModel?.cellViewModels[indexPath.row]
       
        return cell
    }
    
}

//MARK: - UITableViewDelegate

extension MovieListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ((viewModel?.cellViewModels.isEmpty) != nil)
                                          ? MovieTableCell.height
                                          : tableView.frame.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        //Navigate to detail page
        navigateToMovieDetailView(index: indexPath.row)
        // Remove highlight from the selected cell
        tableView.deselectRow(at: indexPath, animated: true)
        // Close keyboard when you select cell
        self.searchBar.searchTextField.endEditing(true)
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
