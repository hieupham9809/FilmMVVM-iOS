//
//  MovieDetailViewModel.swift
//  FilmMVVM
//
//  Created by HieuPM on 4/13/20.
//  Copyright © 2020 HieuPM. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct MovieDetailViewModel {
    let id : Int
    let movie : BehaviorRelay<Movie> = BehaviorRelay(value: Movie())
    let disposeBag = DisposeBag()
    init(id: Int) {
        self.id = id
    }
}

extension MovieDetailViewModel {
    func getMovie()->BehaviorRelay<Movie>{
        let request = MovieDetailRequest(id: self.id)
        let movieDetailRepository = MovieDetailRepository()
        movieDetailRepository.getMovieDetail(input: request).subscribe(onNext: {movie in
                self.movie.accept(movie)
            
            }).disposed(by: disposeBag)
        
        return self.movie
    }
}
