//
//  MarkFavoriteResponse.swift
//  FilmMVVM
//
//  Created by HieuPM on 4/21/20.
//  Copyright © 2020 HieuPM. All rights reserved.
//

import Foundation
import ObjectMapper

enum MarkResponse : Int {
    case success = 12
}

final class MarkFavoriteResponse : Mappable {
    var statusCode : Int = 0
    var statusMessage : String = ""
    required init(map : Map) {
        mapping(map : map)
    }
    
    func mapping(map: Map) {
        statusCode <- map["status_code"]
        statusMessage <- map["status_message"]
    }
}
