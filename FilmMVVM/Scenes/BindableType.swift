//
//  BindableType.swift
//  FilmMVVM
//
//  Created by HieuPM on 4/13/20.
//  Copyright © 2020 HieuPM. All rights reserved.
//

import UIKit

public protocol BindableType : class {
    associatedtype ViewModelType
    
    var viewModel: ViewModelType! {get set}
    func bindViewModel()
}

extension BindableType where Self : UIViewController {
    public func bindViewModel(to model: Self.ViewModelType){
        viewModel = model
        loadViewIfNeeded()
        bindViewModel()
    }
}
