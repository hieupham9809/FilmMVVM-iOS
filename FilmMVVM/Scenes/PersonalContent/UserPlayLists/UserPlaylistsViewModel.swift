//
//  UserPlaylistsViewModel.swift
//  FilmMVVM
//
//  Created by CPU12130 on 4/24/20.
//  Copyright © 2020 HieuPM. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import SwiftKeychainWrapper

class UserPlaylistsViewModel {
    let isLoading : BehaviorRelay<Bool> = BehaviorRelay(value: false)
    let isCreatePlaylistSuccess : BehaviorRelay<Bool?> = BehaviorRelay(value: nil)
    
    let userId : Int!
    
    let moviePlaylists : BehaviorRelay<[Playlist]> = BehaviorRelay(value : [])
    var currentPage = 0
    var totalPages = 1
    var totalResults = 0
    
    let userRepository = UserRepository()
    let disposeBag = DisposeBag()
    
    func resetState(){
        self.currentPage = 0
        self.totalResults = 0
        self.totalPages = 1
        self.moviePlaylists.accept([])
    }
    
    required init(userId : Int) {
        self.userId = userId
    }
    
    func getCreatedPlaylists(){
        self.isLoading.accept(true)
        
        guard self.currentPage < self.totalPages else {return}
        
        self.currentPage += 1
        
        userRepository.getCreatedPlaylist(page: self.currentPage).subscribe(
            onNext: {playlistResponse in
                self.currentPage = playlistResponse.currentPage
                self.totalPages = playlistResponse.totalPages
                self.totalResults = playlistResponse.totalResults
                self.moviePlaylists.accept(self.moviePlaylists.value + playlistResponse.playlists)
            
        },
            onError: {
                print("error: \(($0 as? BaseError)?.errorMessage ?? "cannot unwrap error")")
        
        },
            onCompleted: {
                self.isLoading.accept(false)
        }).disposed(by: self.disposeBag)
        
    }
    
    func createNewPlaylist(name : String, description: String){
        self.isLoading.accept(true)
        
        userRepository.createPlaylist(name: name, description: description).subscribe(
            onNext: { createPlaylistResponse in
                print(createPlaylistResponse.statusMessage)
                
                self.isCreatePlaylistSuccess.accept(true)
                
        },
            onError: { error in
                print("error: \((error as? BaseError)?.errorMessage ?? "cannot unwrap error")")
                self.isCreatePlaylistSuccess.accept(false)
                
        },
            onCompleted: {
                self.isLoading.accept(false)
        }).disposed(by: self.disposeBag)
    }
}
