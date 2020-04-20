//
//  ErrorResponse.swift
//  FilmMVVM
//
//  Created by HieuPM on 4/13/20.
//  Copyright © 2020 HieuPM. All rights reserved.
//

import Foundation
import ObjectMapper

class ErrorResponse: Mappable {
    var statusCode: Int?
    var message: String?
    var success : Bool?
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        statusCode <- map["status_code"]
        message <- map["status_message"]
        success <- map["success"]
    }
}
