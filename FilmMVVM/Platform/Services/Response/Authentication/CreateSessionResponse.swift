//
//  CreateSessionResponse.swift
//  FilmMVVM
//
//  Created by HieuPM on 4/18/20.
//  Copyright © 2020 HieuPM. All rights reserved.
//

import Foundation
import ObjectMapper

final class CreateSessionResponse : Mappable {
    var success : Bool = false
    var sessionId : String = ""
    required init(map : Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        sessionId <- map["session_id"]
    }
}
