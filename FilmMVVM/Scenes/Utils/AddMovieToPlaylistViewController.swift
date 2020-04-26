//
//  AddMovieToPlaylistViewController.swift
//  FilmMVVM
//
//  Created by HieuPM on 4/25/20.
//  Copyright © 2020 HieuPM. All rights reserved.
//

import UIKit
import RxSwift
import SwiftKeychainWrapper

class AddMovieToPlaylistViewController: UIViewController {
    let margin : CGFloat = 10.0
    let popupView = UIView()
    let addButton : UIButton = {
        let button = UIButton()
        
        button.setTitle("Add", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        return button
    }()
    let cancelButton : UIButton = {
        let button = UIButton()
        
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    let tableButton : UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 1.0
        button.setTitle("Select Playlist", for: .normal)
        return button
    }()
    var playlistViewModel : UserPlaylistsViewModel?
    let playlistTableView = UITableView()
    let disposeBag = DisposeBag()
    var selectedIdPlaylist : Int?
    var didSendBackPlaylistId : ((Int)->Void)?
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(white: 0, alpha: 0.4)
        
        setLayout()
        setEvent()
        bindData()
        // Do any additional setup after loading the view.
        view.addSubview(popupView)
        view.addSubview(cancelButton)
        view.addSubview(addButton)
        view.addSubview(tableButton)
        view.addSubview(playlistTableView)
    }
    func setLayout(){
        popupView.frame = CGRect(x: view.frame.size.width / 2 - 160, y: view.frame.size.height / 2 - 80, width: 320, height: 160)
        popupView.backgroundColor = UIColor.darkGray
        
        cancelButton.frame = CGRect(
            x: view.frame.size.width / 2 - self.margin - 80, y: popupView.frame.maxY - self.margin - 30, width: 80, height: 30)
        addButton.frame = CGRect(x: view.frame.size.width / 2 + self.margin, y: cancelButton.frame.minY, width: 80, height: 30)
        
        tableButton.frame = CGRect(x: cancelButton.frame.minX, y: view.frame.size.height / 2 - 30, width: cancelButton.frame.size.width + addButton.frame.size.width + 2 * self.margin, height: 30)
        
        playlistTableView.frame = CGRect(x: tableButton.frame.minX
            , y: tableButton.frame.maxY, width: tableButton.frame.size.width, height: 200)
    }
    
    func setEvent(){
        tableButton.addTarget(self, action: #selector(self.togglePlaylistTableView), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(self.dismissPopup), for: .touchUpInside)
        playlistTableView.isHidden = true
        playlistTableView.rx.modelSelected(Playlist.self).subscribe(
            onNext:{ playlist in
                self.selectedIdPlaylist = playlist.id
                self.tableButton.setTitle(playlist.name, for: .normal)
                self.playlistTableView.isHidden = true
            },
            onError: {error in
                print("error \((error as? BaseError)?.errorMessage ?? "cannot unwrap message error") ")
                self.playlistTableView.isHidden = true
            },
            onCompleted: {
                self.playlistTableView.isHidden = true
        }).disposed(by: disposeBag)
        
        addButton.addTarget(self, action: #selector(self.addToPlaylist), for: .touchUpInside)
        
    }
    func bindData(){
        if let userId = KeychainWrapper.standard.integer(forKey: Constants.keyAccessUserId) {
            playlistViewModel = UserPlaylistsViewModel(userId: userId)
            playlistViewModel?.getCreatedPlaylists()
            playlistViewModel?.moviePlaylists.asObservable().bind(to: playlistTableView.rx.items){(tableView : UITableView, index : Int, element : Playlist) in
                let cell = UITableViewCell(style: .default, reuseIdentifier: "defaultCell")
                cell.textLabel?.text = element.name
                
                return cell
                
                
            }.disposed(by: disposeBag)
            
        }
    }
    @objc func togglePlaylistTableView(){
        playlistTableView.isHidden = !playlistTableView.isHidden
    }
    @objc func dismissPopup(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func addToPlaylist(){
        if let playlistId = selectedIdPlaylist {
            didSendBackPlaylistId?(playlistId)
            dismissPopup()
        }
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

