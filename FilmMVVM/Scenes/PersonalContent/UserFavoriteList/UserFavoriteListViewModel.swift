//
//  UserFavoriteListViewModel.swift
//  FilmMVVM
//
//  Created by HieuPM on 4/20/20.
//  Copyright © 2020 HieuPM. All rights reserved.
//


import Foundation
import RxSwift
import RxCocoa
import SwiftKeychainWrapper

class UserFavoriteListViewModel {
    let id : Int!
    
    let isLoading : BehaviorRelay<Bool> = BehaviorRelay(value: false)
    let movieList : BehaviorRelay<[Movie]> = BehaviorRelay(value: [])
    let userRepository = UserRepository()
    let movieRepository = MovieRepository()
    var currentPage = 0
    var totalPages = 1
    var totalResults = 0
    let disposeBag = DisposeBag()
    
    init(id : Int) {
        self.id = id
        
    }
    
    func resetState(){
        self.movieList.accept([])
        self.currentPage = 0
        self.totalPages = 1
        self.totalResults = 0
    }
    
    // get Observable from MovieRepository and send to MainViewController
    func getMovieList(){
        self.isLoading.accept(true)
        if self.currentPage == self.totalPages {
            return
        }
        guard let sessionId = KeychainWrapper.standard.string(forKey: Constants.keyAccessSession) else {
            print("error: sessionId not exist")
            return
            
        }
        
        self.currentPage += 1
        
        let request = UserFavoriteMovieListRequest(accountId: self.id, sessionId: sessionId, page: self.currentPage)
        
        
        movieRepository.getFavoriteMovies(input: request).subscribe(
            onNext: { movieResponse in
                self.movieList.accept(self.movieList.value + movieResponse.movies)
    //            print(self.movieList.value)
                self.totalPages = movieResponse.totalPages
                self.currentPage = movieResponse.currentPage
                self.totalResults = movieResponse.totalResults
                self.isLoading.accept(false)
            
        }, onError: {error in
            self.isLoading.accept(false)
        }).disposed(by: self.disposeBag)
        
       
    }
}

extension UserFavoriteListViewModel {
    
    
    
    func logout()->Observable<LogoutResponse>{
        let userRepository = UserRepository()
        return userRepository.logout()
        
    }
    func requestMarkFavoriteForItem(isAdd : Bool, id : Int)->Observable<MarkFavoriteResponse>{
        
        return userRepository.requestMarkFavorite(isAdd: isAdd, id: id)
    }
    
    
}
