//
//  CustomRequestAdapter.swift
//  FilmMVVM
//
//  Created by HieuPM on 4/13/20.
//  Copyright © 2020 HieuPM. All rights reserved.
//

import Foundation
import Alamofire

final class CustomRequestAdapter: RequestInterceptor {
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
//        if let accessToken = userDefault.string(forKey: Constants.keyAccessToken) {
//            urlRequest.setValue(accessToken, forHTTPHeaderField: "X-AccessToken")
//        }
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
    }
    
    private let userDefault = UserDefaults()
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        if let accessToken = userDefault.string(forKey: Constants.keyAccessToken) {
            urlRequest.setValue(accessToken, forHTTPHeaderField: "X-AccessToken")
        }
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return urlRequest
    }
}
