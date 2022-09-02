//
//  MovieViewController.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 29/06/22.
//

import UIKit

class MovieListViewController: UIViewController, Alertable, ColorProvider {
    
    //MARK: - Layout:-
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Variable & Constants:
    var viewModel: IMovieListViewModel!
    weak var movieListCoordinator: MovieListCoordinator?

        
    //MARK: - Life Cycle:-
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        viewModel?.fetchMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
        //Focus search bar when navigate back to List screen if isSearching is true
        guard let movieListViewModel = viewModel, movieListViewModel.isSearching == true else { return }
        searchBar.searchTextField.becomeFirstResponder()
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
        self.navigationItem.title = viewModel?.screenTitle

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
    private func updateItems() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        guard let movieListViewModel = viewModel, !movieListViewModel.movieCellViewModels.isEmpty else {
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
        guard let coordinator = movieListCoordinator else { return }
        coordinator.navigateToMovieDetailVC(viewModel: viewModel.movieCellViewModels[index])
    }
}

//MARK: - UITableViewDataSource
extension MovieListViewController: UITableViewDataSource {
    
    private func setupTableView(){
        self.tableView.isHidden = false
        self.tableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.movieCellViewModels.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let cell = tableView.dequeue() as MovieTableCell
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableCell.reuseIdentifier) as! MovieTableCell
        cell.cellViewModel = viewModel?.movieCellViewModels[indexPath.row]
       
        return cell
    }
    
}

//MARK: - UITableViewDelegate

extension MovieListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ((viewModel?.movieCellViewModels.isEmpty) != nil)
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

//MARK: - MovieListViewModelOutput
extension MovieListViewController: MovieListViewModelOutput {
    
    func handleSuccess() {
        DispatchQueue.main.async {
            self.updateItems()
        }
    }
    
    func handleError(_ error: String) {
        DispatchQueue.main.async {
            self.showError(error)
        }
    }
}
