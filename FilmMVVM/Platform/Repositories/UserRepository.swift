//
//  UserRepository.swift
//  FilmMVVM
//
//  Created by HieuPM on 4/18/20.
//  Copyright © 2020 HieuPM. All rights reserved.
//

import Foundation
import RxSwift

final class UserRepository {
    let api = APIService.share
    let disposeBag = DisposeBag()
    func createToken()->Observable<CreateAndValidateTokenResponse> {
        return Observable.create { observer in
            let createTokenRequest = CreateTokenRequest()
            self.api.request(input: createTokenRequest)
                .subscribe(
                    onNext: {(tokenResponse : CreateAndValidateTokenResponse)->Void in
                        observer.onNext(tokenResponse)
                    
                },
                   onError: {error in
                    
                        observer.onError(error)
                }).disposed(by: self.disposeBag)
                
            return Disposables.create()
        }
    }
        
    func validateToken(tokenResponse : CreateAndValidateTokenResponse, username : String, password: String)->Observable<CreateAndValidateTokenResponse>{
        return Observable.create { observer in
            let validateTokenRequest = ValidateTokenRequest(requestToken: tokenResponse.requestToken, username: username, password: password)
            self.api.request(input: validateTokenRequest).subscribe(
                onNext: {(validateResponse : CreateAndValidateTokenResponse)->Void in
                        observer.onNext(validateResponse)
            },
                onError: {error in
                    
                    observer.onError(error)
            }).disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
    
    func createSessionKey(username : String, password : String)->Observable<CreateSessionResponse>{
        return createToken().flatMap { (tokenResponse : CreateAndValidateTokenResponse)->Observable<CreateAndValidateTokenResponse> in
            self.validateToken(tokenResponse: tokenResponse, username: username, password: password)
            
        }.flatMap {(validateResponse : CreateAndValidateTokenResponse)->Observable<CreateSessionResponse> in
            
            let createSessionRequest = CreateSessionRequest(requestToken: validateResponse.requestToken)
            return self.api.request(input: createSessionRequest).map {(sessionResponse: CreateSessionResponse)-> CreateSessionResponse in
                return sessionResponse
            }
        }
    }
    
    func getUserInfo(sessionKey : String)->Observable<User>{
        let userInfoRequest = UserInfoRequest(sessionId: sessionKey)
        return api.request(input: userInfoRequest).map {(userInfo : User)->User in
             userInfo
        }
    }
}
