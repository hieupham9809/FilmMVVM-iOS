//
//  UserFavoriteListViewController.swift
//  FilmMVVM
//
//  Created by HieuPM on 4/20/20.
//  Copyright © 2020 HieuPM. All rights reserved.
//

import UIKit
import Foundation
import RxSwift
import RxCocoa



class UserFavoriteListViewController: BaseViewController, BindableType, UITableViewDelegate {
    var tableView = UITableView()
//    let searchController = UISearchController()
    
    var viewModel : UserFavoriteListViewModel!
    let rowIndexToLoadMore = 1
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "My Favorite"
        
        
//        searchController.hidesNavigationBarDuringPresentation = false
        let currentFrame = self.view.frame
        self.tableView.frame = CGRect(x: 0, y: 0, width: currentFrame.width, height: currentFrame.height)
        self.tableView.register(MovieCell.self
            , forCellReuseIdentifier: "MovieCell")
        self.tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        
//        refreshControl.addTarget(self, action: #selector(self.refreshData(sender:)), for: .valueChanged)
        
        self.view.addSubview(tableView)
        // Do any additional setup after loading the view.
    }
    override func addRefreshControlToView() {
        if #available(iOS 10.0, *){
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
    }
    @objc override func refreshData(sender: Any){
        guard let viewModel = self.viewModel else {return}
        viewModel.resetState()
        viewModel.getMovieList()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func relogin(){
        self.navigationController?.popViewController(animated: true)
    }
    override func markItemAsFavorite(isAdd : Bool, id : Int, onCompleted: @escaping (Bool)->Void){
        guard let viewModel = self.viewModel else {
            return
        }
        
        viewModel.requestMarkFavoriteForItem(isAdd: isAdd, id: id).subscribe(
            onNext:{(markFavoriteResponse : MarkFavoriteResponse) in
                print("success: \(markFavoriteResponse.statusMessage)")
                let message = isAdd ? "Add to favorite " : "Remove from favorite"
                self.showToast(message: "\(message) success!", font: UIFont.systemFont(ofSize: 18))
                onCompleted(true)
        },
            onError: { error in
                print("error: \((error as? BaseError)?.errorMessage ?? "cannot unwrap message")")
                self.showToast(message: "error: \((error as? BaseError)?.errorMessage ?? "cannot unwrap message")", font: UIFont.systemFont(ofSize: 18))
                onCompleted(false)
                switch error {
                case BaseError.apiFailure(let apiError):
                    if apiError?.statusCode == ErrorStatusCode.not_authen.rawValue {
                        self.relogin()
                    }
                default:
                    break
                }
                
        }).disposed(by: self.disposeBag)
    }
    
    
    func bindViewModel() {
        // bind data get from  to View (TableView, ... )
        guard let viewModel = self.viewModel else {return}
        
        viewModel.getMovieList()
        viewModel.movieList.bind(to: tableView.rx.items(cellIdentifier: "MovieCell", cellType: MovieCell.self)){row, movie, cell in
            cell.parentVC = self
            cell.setContentForCell(movie: movie)
            
        }
        .disposed(by: disposeBag)
        
        
        tableView.rx.modelSelected(Movie.self).map{
            $0.id
        }.subscribe(onNext: { [weak self] id in
            let detailVC =  self?.storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! MovieDetailViewController
            let movieDetailModel = MovieDetailViewModel(id: id)
            
            detailVC.bindViewModel(to: movieDetailModel)
            
            self?.navigationController?.pushViewController(detailVC, animated: true)
            
            // TODO : create DetailViewController and pass it an id
            
        }).disposed(by: disposeBag)
        
        tableView.rx.willDisplayCell
        .subscribe(onNext: {
            guard self.viewModel.movieList.value.count - $0.indexPath.row == self.rowIndexToLoadMore else {return}
            self.viewModel.getMovieList()
            
            print("movies count: \(self.viewModel.movieList.value.count)")
            print("current index: \($0.indexPath.row)")
            }).disposed(by: disposeBag)
        
        
        // MARK: Loading indicator
        viewModel.isLoading.asObservable().subscribe(
            onNext: {
                if ($0){
                    
                } else {
                    self.refreshControl.endRefreshing()
                }
                
        },
            onError: {error in
                print("Error from isLoading observable")
                
            }).disposed(by: disposeBag)
    }
    
    
    
}
