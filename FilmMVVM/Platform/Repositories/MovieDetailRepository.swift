//
//  MovieDetailRepository.swift
//  FilmMVVM
//
//  Created by HieuPM on 4/15/20.
//  Copyright © 2020 HieuPM. All rights reserved.
//

import Foundation
import RxSwift


protocol MovieDetailRepositoryType {
    func getMovieDetail(input: MovieDetailRequest)->Observable<Movie>
}

class MovieDetailRepository : MovieDetailRepositoryType {
    let api = APIService.share
    func getMovieDetail(input: MovieDetailRequest) -> Observable<Movie> {
        api.request(input: input).map {(response: Movie)->Movie in
            return response
        }
    }
    
    
}
