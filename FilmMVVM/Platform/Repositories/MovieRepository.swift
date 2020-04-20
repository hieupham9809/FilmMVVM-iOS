//
//  MovieRepository.swift
//  FilmMVVM
//
//  Created by HieuPM on 4/13/20.
//  Copyright © 2020 HieuPM. All rights reserved.
//

import Foundation
import ObjectMapper
import RxSwift

protocol MovieRepositoryType {
    func getMovies(input: MovieRequest)->Observable<MovieResponse>
    func getSearchMovies(input: MovieSearchRequest)->Observable<MovieResponse>
}

class MovieRepository : MovieRepositoryType {
    private let api = APIService.share
    
    func getMovies(input: MovieRequest) -> Observable<MovieResponse> {
        api.request(input: input)
            .map {(response: MovieResponse)->MovieResponse in
                
                return response
        }
    }
    func getSearchMovies(input: MovieSearchRequest) -> Observable<MovieResponse> {
        api.request(input: input)
            .map{(response: MovieResponse)->MovieResponse in
                return response
                
        }
    }
}
