//
//  UserRepository.swift
//  FilmMVVM
//
//  Created by HieuPM on 4/18/20.
//  Copyright © 2020 HieuPM. All rights reserved.
//

import Foundation
import RxSwift
import SwiftKeychainWrapper

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
    
    func logout()->Observable<LogoutResponse>{
        if let oldSessionKey = KeychainWrapper.standard.string(forKey: Constants.keyAccessSession){
            let logoutRequest = LogoutRequest(sessionId: oldSessionKey)
            return api.request(input: logoutRequest).map{(logoutResponse : LogoutResponse) in
                return logoutResponse
            }
        }
        return Observable.of(LogoutResponse())
        
    }
    
    func requestMarkFavorite(isAdd : Bool, id : Int)->Observable<MarkFavoriteResponse>{
//        let markFavorite = MarkFavorite
        return Observable<MarkFavoriteResponse>.create{observer in
            if let oldSessionKey = KeychainWrapper.standard.string(forKey: Constants.keyAccessSession), let userId = KeychainWrapper.standard.integer(forKey: Constants.keyAccessUserId) {
                    
                let markFavoriteRequest = MarkFavorite(accountId: userId, sessionId: oldSessionKey, mediaId: id, favorite: isAdd)
                self.api.request(input: markFavoriteRequest).subscribe(
                    onNext: {(markResponse : MarkFavoriteResponse)->Void in
                        print("onNext from user repository")
                        observer.onNext(markResponse)
                        
                        
                }, onError: {
                    print("onError from user repository")
                    observer.onError($0)
                },
                   onCompleted: {
                    print("onCompleted from user repository")
                }).disposed(by: self.disposeBag)
            } else {
                observer.onError(BaseError.apiFailure(error: ErrorResponse()))
            }
            
            return Disposables.create()
            
        }
        
    }
}
