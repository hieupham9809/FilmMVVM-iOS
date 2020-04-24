//
//  GetCreatedPlaylistsResponse.swift
//  FilmMVVM
//
//  Created by CPU12130 on 4/24/20.
//  Copyright © 2020 HieuPM. All rights reserved.
//

import Foundation
import ObjectMapper

final class GetCreatedPlaylistsResponse : Mappable{
    var currentPage = 1
    var totalPages = 1
    var totalResults = 0
    var playlists = [Playlist]()
    
    required init(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        currentPage <- map["page"]
        totalPages <- map["total_pages"]
        totalResults <- map["total_results"]
        playlists <- map["results"]
    }
    
    
    
}
