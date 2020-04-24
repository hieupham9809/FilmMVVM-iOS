//
//  Playlist.swift
//  FilmMVVM
//
//  Created by CPU12130 on 4/24/20.
//  Copyright © 2020 HieuPM. All rights reserved.
//

import Foundation
import ObjectMapper

struct Playlist {
    var createdBy : String
    var name : String
    var description : String
    var favoriteCount : Int
    var itemCount : Int
    var id : String
    var items : [Movie]
    var posterPath : String?
}

extension Playlist {
    init(){
        self.init(createdBy: "", name: "", description: "", favoriteCount: 0, itemCount: 0, id: "", items: [])
    }
}

extension Playlist : BaseModel {
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        createdBy <- map["created_by"]
        description <- map["description"]
        favoriteCount <- map["favorite_count"]
        itemCount <- map["item_count"]
        id <- map["id"]
        items <- map["items"]
        name <- map["name"]
        posterPath <- map["poster_path"]
    }
}
