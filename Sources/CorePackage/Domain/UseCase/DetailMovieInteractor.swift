//
//  File.swift
//  
//
//  Created by Sholi on 15/04/23.
//

import Foundation
import Combine

public protocol DetailMovieUseCase {
    associatedtype DetailMovieModel
    
    func getDetailMovie(id: Int) -> AnyPublisher<DetailMovieModel, Error>
}

public struct DetailMovieInteractor<MovieModel, DetailMovieModel, MR: MovieRepository, FR: FavoriteRepository>: MovieUseCase
where
MR.MoviesResponse == MovieModel,
MR.DetailResponse == DetailMovieModel,
FR.MovieModel == MovieModel {
    
    private let _movieRepository: MR
    private let _favoriteRepository: FR
    
    public init(movieRepository: MR, favoriteRepository: FR) {
        _movieRepository = movieRepository
        _favoriteRepository = favoriteRepository
    }
    
    public func getMovies(type: MovieType.RawValue) -> AnyPublisher<[MovieModel], Error> {
        _movieRepository.getMovies(type: type)
    }
    
    public func getDetailMovie(id: Int) -> AnyPublisher<DetailMovieModel, Error> {
        _movieRepository.getDetailMovie(id: id)
    }
    
    public func getFavoriteMovie(id: Int) -> AnyPublisher<[MovieModel], Error> {
        _favoriteRepository.getFavoriteMovie(id: id)
    }
    
    public func addFavoriteMovie(movie: MovieModel) -> AnyPublisher<Bool, Error> {
        _favoriteRepository.addFavoriteMovie(movie: movie)
    }
    
    public func deleteFavoriteMovie(movie: MovieModel) -> AnyPublisher<Bool, Error> {
        _favoriteRepository.deleteFavoriteMovie(movie: movie)
    }
}
