//
//  Movie.swift
//  FilmMVVM
//
//  Created by HieuPM on 4/13/20.
//  Copyright © 2020 HieuPM. All rights reserved.
//

import Foundation
import ObjectMapper

struct Movie {
    var adult: Bool
    var backDropPath: String
    var belongToCollection: Any
    var budget : Int64
    var genreIds : [Int]
    var overview : String
    var status : String
    var tagLine : String
    var voteAverage : Float
    var id : Int
    var title : String
    var releaseDay : String
}

extension Movie {
    init() {
        self.init(
            adult : false,
            backDropPath : "",
            belongToCollection : "",
            budget : 0,
            genreIds : [],
            overview : "",
            status : "",
            tagLine : "",
            voteAverage : 0.0,
            id : 0,
            title : "",
            releaseDay : ""
            )
    }
}

extension Movie : BaseModel {
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        adult <- map["adult"]
        backDropPath <- map["backdrop_path"]
        voteAverage <- map["vote_average"]
        overview <- map["overview"]
        id <- map["id"]
        title <- map["title"]
        releaseDay <- map["release_day"]
        genreIds <- map["genre_ids"]
        budget <- map["budget"]
        status <- map["status"]
        belongToCollection <- map["belongs_to_collection"]
    }
}
