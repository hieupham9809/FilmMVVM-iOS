//
//  UserPlaylistsViewController.swift
//  FilmMVVM
//
//  Created by CPU12130 on 4/24/20.
//  Copyright © 2020 HieuPM. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class UserPlaylistsViewController: BaseViewController, BindableType {
    var playlistCollectionView : UICollectionView!
    var viewModel: UserPlaylistsViewModel! = nil
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.createPlaylistHandle(sender:)))
        self.layoutItems()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        guard let viewModel = self.viewModel else {return}
        viewModel.getCreatedPlaylists()
    }
    func layoutItems(){
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.view.frame.size.width, height: 80)
        self.playlistCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height), collectionViewLayout: layout)
        
        self.playlistCollectionView.register(PlaylistCollectionViewCell.self, forCellWithReuseIdentifier: "Playlist")
        self.playlistCollectionView.backgroundColor = UIColor.white
        self.view.addSubview(playlistCollectionView)
    }
    func bindViewModel() {
        guard let viewModel = self.viewModel else {return}
        viewModel.moviePlaylists.bind(to: playlistCollectionView.rx.items(cellIdentifier: "Playlist", cellType: PlaylistCollectionViewCell.self)){ row, playlist, cell in
            
            cell.setContentForCell(playlist: playlist)
            
        }.disposed(by: disposeBag)
        
        viewModel.isCreatePlaylistSuccess.asObservable().subscribe(
            onNext: { isSuccess in
                guard let isSuccess = isSuccess else {return}
                let message = isSuccess ? "successed" : "failed"
                self.showToast(message: "create playlist \(message)", font: UIFont.systemFont(ofSize: 16))
                viewModel.resetState()
                viewModel.getCreatedPlaylists()
                
            }
        ).disposed(by: disposeBag)
    }
    @objc func createPlaylistHandle(sender: UIButton){
        let alert = UIAlertController(title: "Create New Playlist", message: "", preferredStyle: .alert)
        alert.addTextField{ textField in
            textField.placeholder = "playlist 0"
        }
        alert.addTextField{ textField in
            textField.placeholder = "description..."
        }
        
        alert.addAction(UIAlertAction(title: "Create", style: .default, handler: {[weak alert] _ in
            guard let viewModel = self.viewModel else {return}
            let name = alert?.textFields?[0].text ?? ""
            let description = alert?.textFields?[1].text ?? ""
            viewModel.createNewPlaylist(name: name, description: description)
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
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
