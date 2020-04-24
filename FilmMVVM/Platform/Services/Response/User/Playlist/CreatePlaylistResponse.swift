//
//  CreatePlaylistResponse.swift
//  FilmMVVM
//
//  Created by CPU12130 on 4/24/20.
//  Copyright © 2020 HieuPM. All rights reserved.
//

import Foundation
import ObjectMapper

final class CreatePlaylistResponse : Mappable {
    var listId : Int = 0
    var success : Bool = false
    var statusCode : Int = 0
    var statusMessage : String = ""
    
    required init (map: Map) {
        mapping(map : map)
    }
    
    func mapping(map: Map) {
        listId <- map["list_id"]
        success <- map["success"]
        statusCode <- map["status_code"]
        statusMessage <- map["status_message"]
    }
    
    
}
