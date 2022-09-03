//
//  MovieViewController.swift
//  MovieTrailers
//
//  Created by Toheed Jahan Khan on 29/06/22.
//

import UIKit

class MovieListViewController: UIViewController, Alertable {
    
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
        viewModel.viewDidLoad()
        setupNavigation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        self.searchBar.customizeUISearchBarAppereance()
        self.searchBar.chageGlassIconView(tintColor: UIColor.white)
        self.searchBar.customizeSearchBarTextFieldPosition(offset: 50)
        self.searchBar.addClearButton(action: #selector(searchBarClearButtonAction), target: self)
    }
    
    private func setupNavigation() {
        self.navigationItem.title = viewModel.screenTitle

        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor : AppTheme.primaryTheme ?? UIColor.black]
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : AppTheme.primaryTheme ?? UIColor.black]
        navigationController?.navigationBar.tintColor = AppTheme.primaryTheme
    }
    
    @objc func searchBarClearButtonAction(sender:UIButton){
        viewModel.didCancelSearch()
    }
}
//MARK: - Setup View Model
extension MovieListViewController {
    private func updateMoviesList() {
        if viewModel.movieCellViewModels.isEmpty && viewModel.isSearching == false {
            showAlert(title: "Attention", message: "No Data Found")
        } else {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
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
//        tableView.estimatedRowHeight = 185.0
//        tableView.rowHeight = UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movieCellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableCell.reuseIdentifier) as! MovieTableCell
        cell.cellViewModel = viewModel.movieCellViewModels[indexPath.row]
        return cell
    }
}

//MARK: - UITableViewDelegate

extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ((viewModel.movieCellViewModels.isEmpty) == false)
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
        viewModel.didSearch(searchText: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        viewModel.didCancelSearch()
        view.endEditing(true)
    }
}

//MARK: - MovieListViewModelOutput
extension MovieListViewController: MovieListViewModelOutput {
    
    func handleSuccess() {
        DispatchQueue.main.async {
            self.updateMoviesList()
        }
    }
    
    func handleError(_ error: String) {
        DispatchQueue.main.async {
            self.showError(error)
        }
    }
}
