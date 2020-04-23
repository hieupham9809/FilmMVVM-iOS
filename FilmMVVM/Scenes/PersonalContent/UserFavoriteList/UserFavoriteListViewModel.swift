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
    let sessionId : String?
    let isLoading : BehaviorRelay<Bool> = BehaviorRelay(value: false)
    let movieList : BehaviorRelay<[Movie]> = BehaviorRelay(value: [])
    var currentPage = 0
    var totalPages = 1
    var totalResults = 0
    let disposeBag = DisposeBag()
    
    required init(id : Int) {
        self.id = id
        self.sessionId = KeychainWrapper.standard.string(forKey: Constants.keyAccessSession)
    }
    func resetState(){
        self.movieList.accept([])
        self.currentPage = 0
        self.totalPages = 1
        self.totalResults = 0
    }
}

extension UserFavoriteListViewModel {
    
    // get Observable from MovieRepository and send to MainViewController
    func getMovieList(){
        self.isLoading.accept(true)
        if self.currentPage == self.totalPages {
            return
        }
        guard let sessionId = self.sessionId else {
            print("error: sessionId not exist")
            return
            
        }
        
        self.currentPage += 1
        print("request more: ")
        let request = UserFavoriteMovieListRequest(accountId: self.id, sessionId: sessionId, page: self.currentPage)
        let repository = MovieRepository()
        
        repository.getFavoriteMovies(input: request).subscribe(onNext: { movieResponse in
            self.movieList.accept(self.movieList.value + movieResponse.movies)
//            print(self.movieList.value)
            self.totalPages = movieResponse.totalPages
            self.currentPage = movieResponse.currentPage
            self.totalResults = movieResponse.totalResults
            self.isLoading.accept(false)
            
        }).disposed(by: self.disposeBag)
        
       
    }
    
    func logout()->Observable<LogoutResponse>{
        let userRepository = UserRepository()
        return userRepository.logout()
        
    }
    func requestMarkFavoriteForItem(isAdd : Bool, id : Int)->Observable<MarkFavoriteResponse>{
        let userRepository = UserRepository()
        return userRepository.requestMarkFavorite(isAdd: isAdd, id: id)
    }
    
    
}
