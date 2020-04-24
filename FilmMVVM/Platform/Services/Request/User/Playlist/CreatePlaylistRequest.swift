//
//  CreatePlaylistRequest.swift
//  FilmMVVM
//
//  Created by CPU12130 on 4/24/20.
//  Copyright © 2020 HieuPM. All rights reserved.
//

import Foundation

final class CreatePlaylistRequest : BaseRequest {
    required init(apiKey : String = Constants.api_key, sessionId : String, name : String, description : String) {
        let header = "?api_key=\(apiKey)&session_id=\(sessionId)"
        let body : [String : Any] = [
            "name" : name,
            "description" : description
        ]
        super.init(url: URLs.createList + header, requestType: .post, body: body)
        
    }
}
