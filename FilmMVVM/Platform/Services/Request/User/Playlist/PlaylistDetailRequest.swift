//
//  PlaylistDetailRequest.swift
//  FilmMVVM
//
//  Created by HieuPM on 4/25/20.
//  Copyright © 2020 HieuPM. All rights reserved.
//

import Foundation

final class PlaylistDetailRequest : BaseRequest {
    required init(apiKey : String = Constants.api_key, listId : Int) {
        let body : [String : Any] = [
            "api_key" : apiKey
            
        ]
        super.init(url: URLs.getPlaylistDetail.replacingOccurrences(of: "{id}", with: String(listId)), requestType: .get, body: body)
    }
}
