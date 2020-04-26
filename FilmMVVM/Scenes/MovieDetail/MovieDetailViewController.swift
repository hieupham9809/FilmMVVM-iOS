//
//  MovieDetailViewController.swift
//  FilmMVVM
//
//  Created by HieuPM on 4/13/20.
//  Copyright © 2020 HieuPM. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher
class MovieDetailViewController: UIViewController, BindableType {
    var topBarHeight : CGFloat {
        return (UIApplication.shared.statusBarFrame.height) + (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
    var margin = 10
    var viewModel: MovieDetailViewModel!
    var titleMovie : UILabel!
    var detailBackdrop : UIImageView!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleMovie = UILabel()
        detailBackdrop = UIImageView()
        
        
        
        self.view.addSubview(titleMovie)
        self.view.addSubview(detailBackdrop)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        detailBackdrop.frame = CGRect(x: margin, y: Int(self.topBarHeight) + margin, width: Int(self.view.frame.size.width) - 2 * margin, height: Int(self.view.frame.size.width) - 2 * margin)
        titleMovie.frame = CGRect(x: margin, y: Int(detailBackdrop.frame.maxY) + margin, width: Int(detailBackdrop.frame.size.width), height: 40)
       
        
    }
    func bindViewModel() {
        
        let movie = viewModel.getMovie()
        movie.asObservable().map{ movie -> String? in
            
            return Optional(movie.title)
        }.bind(to: self.titleMovie.rx.text)
        .disposed(by: disposeBag)
        
        movie.asObservable().map {movie -> String? in
            return Optional(movie.backDropPath)
        }.subscribe(onNext: {url in
            guard let url = url else {
                return
            }
            self.detailBackdrop.kf.setImage(with: URL(string: URLs.baseImageUrl + url))
            }).disposed(by: disposeBag)
        
        movie.asObservable().map {movie -> String? in
            return Optional(movie.title)
        }.subscribe(onNext: {
            self.navigationItem.title = $0
            }).disposed(by: disposeBag)
    }

   

}
