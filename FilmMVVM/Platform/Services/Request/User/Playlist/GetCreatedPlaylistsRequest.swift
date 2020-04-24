//
//  GetCreatedPlaylists.swift
//  FilmMVVM
//
//  Created by CPU12130 on 4/24/20.
//  Copyright © 2020 HieuPM. All rights reserved.
//

import Foundation
import Alamofire

final class GetCreatedPlaylistsRequest : BaseRequest {
    required init(apiKey : String = Constants.api_key, sessionId : String, page : Int, accountId : Int) {
        
        let body : [String : Any] = [
            "api_key" : apiKey,
            "session_id": sessionId,
            "page" : page
        ]
        super.init(url: URLs.getCreatedList.replacingOccurrences(of: "{id}", with: String(accountId)), requestType: .get, body: body)
    }
}
