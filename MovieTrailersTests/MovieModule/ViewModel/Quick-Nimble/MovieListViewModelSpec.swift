//
//  MovieListViewModelSpec.swift
//  MovieTrailersTests
//
//  Created by Toheed Jahan Khan on 16/07/22.
//

import Quick
import Nimble
@testable import MovieTrailers

class MovieListViewModelSpecs: QuickSpec {
    override func spec() {
        var movieListViewModel: MovieListViewModel?
        let movieUseCase = MockFetchMovieUseCase()
        
        afterEach {
            
        }
        beforeEach {
            movieListViewModel = MovieListViewModel(useCase: movieUseCase)
            movieUseCase.movies = StubGenerator().stubMovies()
            movieListViewModel?.getMovies()
        }
        
        describe("The 'Movie List View Model'") {
            
            context("When movie data fetched from server successfully, Validate table view cell count") {
                
                it("Will set 'cellViewModels' array of MovieListViewModel to display data and cell count will be 3") {
                            waitUntil(timeout: DispatchTimeInterval.seconds(1)) { done in
                                // do some stuff that takes a while...
                                Thread.sleep(forTimeInterval: 1)
                                movieListViewModel?.successResponse = {
                                    expect(movieListViewModel?.cellViewModels.count).toEventually(equal(3))
                                                                                                  }
                                done()
                            }
                        
                    
                }
            }
            
            context("When user search movie by typing 'D'") {
                
                it("Will display only one table cell") {
                    waitUntil(timeout: DispatchTimeInterval.seconds(1)) { done in
                        // do some stuff that takes a while...
                        Thread.sleep(forTimeInterval: 1)
                        movieListViewModel?.successResponse = {
                            movieListViewModel?.didSearch(searchText: "D")
                            expect(movieListViewModel?.cellViewModels.count).toEventually(equal(1))
                        }
                        done()
                    }
                    
                    
                }
            }
            
            context("When user press cancel search ") {
                
                it("Will display total fetched movie from server in table view") {
                    waitUntil(timeout: DispatchTimeInterval.seconds(1)) { done in
                        // do some stuff that takes a while...
                        Thread.sleep(forTimeInterval: 1)
                        movieListViewModel?.successResponse = {
                            movieListViewModel?.didSearch(searchText: "D")
                            movieListViewModel?.didCancelSearch()

                            expect(movieListViewModel?.cellViewModels.count).toEventually(equal(3))
                        }
                        done()
                    }
                }
            }
        }
    }
}


