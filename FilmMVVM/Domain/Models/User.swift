//
//  User.swift
//  FilmMVVM
//
//  Created by HieuPM on 4/20/20.
//  Copyright © 2020 HieuPM. All rights reserved.
//

import Foundation
import ObjectMapper

struct User {
    var avatar : Any
    var id : Int
    var name : String
    var includeAdult : Bool
    var username : String
}

extension User {
    init() {
        self.init(avatar: NSObject(), id: 0, name: "", includeAdult: false, username: "")
    }
}

extension User : BaseModel {
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        avatar <- map["avatar"]
        id <- map["id"]
        name <- map["name"]
        includeAdult <- map["include_adult"]
        username <- map["username"]
    }
}
