//
//  MainViewModel.swift
//  FilmMVVM
//
//  Created by HieuPM on 4/13/20.
//  Copyright © 2020 HieuPM. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import SwiftKeychainWrapper

enum Mode {
    case normal
    case search(String)
}
extension Array {
    public subscript(safeIndex index: Int)->Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }
        return self[index]
    }
}
class MainViewModel {
    
    let isLoading : BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    let movieList : BehaviorRelay<[Movie]> = BehaviorRelay(value: [])
    var currentPage = 0
    var totalPages = 1
    var totalResults = 0
    
    let userRepository = UserRepository()
    let disposeBag = DisposeBag()
    var current_mode = Mode.normal
    
    func resetState(){
        self.movieList.accept([])
        self.currentPage = 0
        self.totalPages = 1
        self.totalResults = 0
    }
}

extension MainViewModel {
    
    // get Observable from MovieRepository and send to MainViewController
    func getMovieList(){
        self.isLoading.accept(true)
        // if current mode is not .normal, then reset all state
        switch self.current_mode {
        case .search( _):
            self.resetState()
            self.current_mode = .normal
        default:
            break
        }
//        if (self.current_mode == .search(let keywords)){
//            self.resetState()
//            self.current_mode = .normal
//        }
        if self.currentPage == self.totalPages {
            return
        }
        
        self.currentPage += 1
        
        let request = MovieRequest(page: self.currentPage)
        let repository = MovieRepository()
        repository.getMovies(input: request).subscribe(
            onNext: { movieResponse in
            self.movieList.accept(self.movieList.value + movieResponse.movies)
            print("return \(movieResponse.movies.count) items")
            self.totalPages = movieResponse.totalPages
            self.currentPage = movieResponse.currentPage
            self.totalResults = movieResponse.totalResults
//                self.isLoading.accept(false)
            
        }, onError:  {error in
//            self.isLoading.accept(false)
        }, onCompleted: {
            self.isLoading.accept(false)
        }).disposed(by: self.disposeBag)
        
       
    }
    func requestMarkFavoriteForItem(isAdd : Bool, id : Int)->Observable<MarkFavoriteResponse>{
        
        return userRepository.requestMarkFavorite(isAdd: isAdd, id: id)
    }
    func getMovieSearchList(keywords : String){
        // if current mode is .normal, then reset all state
        switch self.current_mode {
        case .normal:
            self.resetState()
            self.current_mode = .search(keywords)
        default:
            self.current_mode = .search(keywords)
        }
//        if (self.current_mode == .normal){
//            self.resetState()
//            self.current_mode = .search
//        }
        
        if self.currentPage == self.totalPages {
            return
        }
        
        self.currentPage += 1
        print("request search more: ")
        let request = MovieSearchRequest(keyword: keywords, page: self.currentPage)
        let repository = MovieRepository()
        repository.getMovies(input: request).subscribe(onNext: {
            movieResponse in
            self.movieList.accept(self.movieList.value + movieResponse.movies)
            self.totalPages = movieResponse.totalPages
            self.currentPage = movieResponse.currentPage
            self.totalResults = movieResponse.totalResults
            }).disposed(by: disposeBag)
        
        
    }
    
    func addMovieToPlaylist(listId : Int, movieId : Int)->Observable<AddMovieToPlaylistResponse>{
        return userRepository.addMovieToPlaylist(listId: listId, movieId: movieId)
    }
}
