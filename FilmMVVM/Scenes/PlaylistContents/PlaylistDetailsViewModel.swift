//
//  PlaylistDetailsViewModel.swift
//  FilmMVVM
//
//  Created by HieuPM on 4/24/20.
//  Copyright © 2020 HieuPM. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

class PlaylistDetailsViewModel : UserFavoriteListViewModel {
    
    var listId : Int!
    
    override init(id: Int) {
        super.init(id: 0)
        listId = id
    }
    
    override func getMovieList(){
        self.isLoading.accept(true)
        
        // MARK: TODO: create new request for playlist detail
        let request = PlaylistDetailRequest(listId: listId)
        
        
        movieRepository.getPlaylistDetail(input: request).subscribe(
            onNext: { playlistResponse in
                self.movieList.accept(self.movieList.value + playlistResponse.items)
          
                self.totalResults = playlistResponse.itemCount
                
            
        }, onError: {error in
            print("error: \((error as? BaseError)?.errorMessage ?? "cannot unwrap message error")")
        }, onCompleted: {
            self.isLoading.accept(false)
        }).disposed(by: self.disposeBag)
        
       
    }
}
