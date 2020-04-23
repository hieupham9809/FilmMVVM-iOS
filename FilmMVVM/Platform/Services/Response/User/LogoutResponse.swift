//
//  LogoutResponse.swift
//  FilmMVVM
//
//  Created by HieuPM on 4/22/20.
//  Copyright © 2020 HieuPM. All rights reserved.
//

import Foundation
import ObjectMapper

final class LogoutResponse : Mappable {
    var success : Bool = false
    required init?(map : Map) {
        mapping(map: map)
    }
    init(){
        
    }
    func mapping(map: Map) {
        success <- map["success"]
    }
}
