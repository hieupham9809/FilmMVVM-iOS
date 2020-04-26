//
//  AddMovieToPlaylistRequest.swift
//  FilmMVVM
//
//  Created by HieuPM on 4/26/20.
//  Copyright © 2020 HieuPM. All rights reserved.
//

import Foundation
class AddMovieToPlaylistRequest : BaseRequest{
    required init(apiKey : String = Constants.api_key, sessionId : String, movideId : Int, listId : Int) {
        let headerParam = "?api_key=\(apiKey)&session_id=\(sessionId)"
        let body : [String : Any] = [
            "media_id" : movideId
        ]
        super.init(url: URLs.addMovieToPlaylist.replacingOccurrences(of: "{id}", with: String(listId)) + headerParam, requestType: .post, body: body)
    }
}
