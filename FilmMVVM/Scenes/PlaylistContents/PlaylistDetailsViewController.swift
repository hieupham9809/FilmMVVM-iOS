//
//  PlaylistDetailsViewController.swift
//  FilmMVVM
//
//  Created by HieuPM on 4/24/20.
//  Copyright © 2020 HieuPM. All rights reserved.
//

import UIKit

class PlaylistDetailsViewController: UserFavoriteListViewController {
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func bindViewModel() {
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
