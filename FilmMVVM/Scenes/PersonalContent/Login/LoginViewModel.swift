//
//  LoginViewModel.swift
//  FilmMVVM
//
//  Created by HieuPM on 4/17/20.
//  Copyright © 2020 HieuPM. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import SwiftKeychainWrapper

struct LoginViewModel {
    let disposeBag = DisposeBag()
    let userInfo : BehaviorRelay<User?> = BehaviorRelay(value: nil)
    let userRepository = UserRepository()
    let loading : BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    func getOldSession(){
        guard let oldSessionId = KeychainWrapper.standard.string(forKey: Constants.keyAccessSession) else {
            print("old session key is not exist, wait for loginning")
            return
        }
        self.getUserInfo(sessionId: oldSessionId)
        
    }
    
    func login(username : String, password : String){
        print("start loginning")
        self.loading.accept(true)
        self.userRepository.createSessionKey(username: username, password: password)
            .subscribe(
                onNext: { (sessionResponse : CreateSessionResponse)->Void in
                    print("success: sessionKey is \(sessionResponse.sessionId)")
                    let isSuccess = KeychainWrapper.standard.set(sessionResponse.sessionId, forKey: Constants.keyAccessSession)
                    print("save session success: \(isSuccess)")
                    self.getUserInfo(sessionId: sessionResponse.sessionId)
                
                },
               onError: { error in
                    print("error: ")
                    print((error as? BaseError)?.errorMessage ?? "cannot unwrap error message")
                        
            }).disposed(by: disposeBag)
    }
    
    func getUserInfo(sessionId : String){
        self.loading.accept(true)
        self.userRepository.getUserInfo(sessionKey: sessionId)
            .subscribe(
                onNext: {
                    self.loading.accept(false)
                    self.userInfo.accept($0)
                    let isSuccess = KeychainWrapper.standard.set($0.id, forKey: Constants.keyAccessUserId)
                    print("save user account id \(isSuccess)")
                
            },
                onError: {
                    self.loading.accept(false)
                    print(($0 as? BaseError)?.errorMessage ?? "cannot unwrap error message")
                    
            }
        ).disposed(by: disposeBag)
    }
}
