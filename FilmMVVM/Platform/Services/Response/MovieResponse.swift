//
//  MovieResponse.swift
//  FilmMVVM
//
//  Created by HieuPM on 4/13/20.
//  Copyright © 2020 HieuPM. All rights reserved.
//

import Foundation
import ObjectMapper

final class MovieResponse : Mappable {
    var movies = [Movie]()
    var currentPage = 1
    var totalPages = 1
    var totalResults = 0
    
    required init(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        // TODO:
        print("mapping movie response called")
        movies <- map["results"]
        currentPage <- map["page"]
        totalPages <- map["total_pages"]
        totalResults <- map["total_results"]
    }
    
    
    
    
}
