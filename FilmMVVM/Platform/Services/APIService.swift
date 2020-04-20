//
//  APIService.swift
//  FilmMVVM
//
//  Created by HieuPM on 4/13/20.
//  Copyright © 2020 HieuPM. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import ObjectMapper

struct APIService {
    static let share = APIService()
    
    private var alamofireManager = Alamofire.Session.default
    
    init(){
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        alamofireManager = Alamofire.Session(configuration: configuration)
//        alamofireManager = Alamofire.Session(configuration: configuration, interceptor: CustomRequestAdapter())
//        alamofireManager.adapter = CustomRequestAdapter()
    }
    
    func request<T: Mappable>(input: BaseRequest) ->  Observable<T> {
        
        print("\n------------REQUEST INPUT")
        print("link: %@", input.url)
        print("body: %@", input.body ?? "No Body")
        print("------------ END REQUEST INPUT\n")
//        print(input.requestType)
//        print(input.encoding)
//        self.alamofireManager.request(input.url, method: input.requestType,parameters: input.body, encoding: input.encoding)
//        .validate(statusCode: 200..<500)
//        .responseJSON { response in
//            print("RESPONSE: ")
//            print(response)
//        }
        return Observable.create { observer in
            
            self.alamofireManager.request(input.url, method: input.requestType,parameters: input.body, encoding: input.encoding)
                .validate(statusCode: 200..<500)
                .responseJSON { response in
                    
                    switch response.result {
                    case .success(let value):
                        if let statusCode = response.response?.statusCode {
                            if statusCode == 200 {
                                if let object = Mapper<T>().map(JSONObject: value) {
//                                    print(value)
                                    observer.onNext(object)
                                }
                            } else {
                                if let object = Mapper<ErrorResponse>().map(JSONObject: value) {
                                    observer.onError(BaseError.apiFailure(error: object))
                                } else {
                                    observer.onError(BaseError.httpError(httpCode: statusCode))
                                }
                            }
                        } else {
                            observer.on(.error(BaseError.unexpectedError))
                        }
                        observer.onCompleted()
                        
                    case .failure:
                        
                        observer.onError(BaseError.networkError)
                        observer.onCompleted()
                    }
            }
            return Disposables.create()
        }
    }
}
