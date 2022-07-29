//
//  MovieViewControllerSpec.swift
//  MovieTrailersTests
//
//  Created by Toheed Jahan Khan on 16/07/22.
//

import Quick
import Nimble
@testable import MovieTrailers

class MovieListViewControllerSpecs: QuickSpec {
    override func spec() {
        var sut: MovieListViewController!
        var movieListViewModel: MovieListViewModel?
        let movieUseCase = MockFetchMovieUseCase()
        var movieCell: MovieTableCell?
        describe("The 'Movie List View Controller'") {
            context("When movie data fetched from server") {
                afterEach {
                    sut = nil
                }
                beforeEach {
                    let storyboard = UIStoryboard(name: "Movie", bundle: Bundle.main)
                    sut = storyboard.instantiateViewController(withIdentifier: "MovieListViewController") as? MovieListViewController
                    _ = sut.view

                    movieListViewModel = MovieListViewModel(useCase: movieUseCase)
                    sut.viewModel = movieListViewModel
                    movieUseCase.movies = StubGenerator().stubMovies()
                    movieListViewModel?.getMovies()
                    movieListViewModel?.successResponse = {
                        sut.tableView.reloadData()
                        movieCell = sut.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? MovieTableCell
                        
                    }
                }
                it("can show the Movie title correctly in Table View") {
                    
                    expect(movieCell?.movieTitle.text).toEventually(equal("Doctor Strange in the Multiverse of Madness"))
                }
            }
        }
    }
}
