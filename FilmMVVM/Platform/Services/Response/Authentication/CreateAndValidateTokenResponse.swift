//
//  CreateAndValidateTokenResponse.swift
//  FilmMVVM
//
//  Created by HieuPM on 4/18/20.
//  Copyright © 2020 HieuPM. All rights reserved.
//

import Foundation
import ObjectMapper

final class CreateAndValidateTokenResponse : Mappable {
    var success : Bool = false
    var expiresAt : String = ""
    var requestToken : String = ""
    required init(map : Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        expiresAt <- map["expires_at"]
        requestToken <- map["request_token"]
    }
}
