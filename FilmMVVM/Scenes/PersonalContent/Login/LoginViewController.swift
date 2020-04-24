//
//  LoginViewController.swift
//  FilmMVVM
//
//  Created by HieuPM on 4/17/20.
//  Copyright © 2020 HieuPM. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController, BindableType {
    var viewModel: LoginViewModel!
    let disposeBag = DisposeBag()
    let spinner = SpinnerViewController()
    var usernameLabel : UILabel = {
       let label = UILabel()
        label.text = "Username:"
        
        return label
    }()
    var usernameTextField : UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()
    var passwordLabel : UILabel = {
        let label = UILabel()
        label.text = "Password:"
        return label
    }()
    var passwordTextField : UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        return textField
    }()
    
    var margin : CGFloat = 10.0
    
    var loginBtn : UIButton = UIButton()
    var topBarHeight : CGFloat {
        return (UIApplication.shared.statusBarFrame.height) + (navigationController?.navigationBar.frame.height ?? 0.0)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginBtn.addTarget(self, action: #selector(self.login(sender:)), for: .touchUpInside)
        
        self.view.addSubview(usernameLabel)
        self.view.addSubview(usernameTextField)
        
        self.view.addSubview(passwordLabel)
        self.view.addSubview(passwordTextField)
        
        self.view.addSubview(loginBtn)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // MARK: LAYOUT VIEWS
        usernameLabel.frame = CGRect(
            x: self.margin,
            y: self.topBarHeight + self.margin,
            width: 100,
            height: 50)
        usernameTextField.frame = CGRect(
            x: usernameLabel.frame.maxX + self.margin,
            y: usernameLabel.frame.minY,
            width: self.view.frame.size.width - usernameLabel.frame.width - 3 * self.margin,
            height: usernameLabel.frame.height)
        
        passwordLabel.frame = CGRect(
            x: usernameLabel.frame.minX,
            y: usernameLabel.frame.maxY + self.margin,
            width: usernameLabel.frame.size.width,
            height: usernameLabel.frame.size.height)
        passwordTextField.frame = CGRect(
            x: usernameTextField.frame.minX,
            y: usernameTextField.frame.maxY + self.margin,
            width: usernameTextField.frame.size.width,
            height: usernameTextField.frame.size.height)
        
        loginBtn.setTitleColor(UIColor.blue, for: .normal)
        loginBtn.setTitle("Login", for: .normal)
        loginBtn.frame = CGRect(x: self.view.frame.width / 2.0 - 60 / 2, y: passwordLabel.frame.maxY + self.margin, width: 60, height: 30)
        
        
        
        // MARK: CALL API
        guard let viewModel = self.viewModel else {return}
        viewModel.getOldSession()
        
        
        
    }
    @objc func login(sender: UIButton) {
        print("clicked")
        guard let viewModel = self.viewModel else {return}
        viewModel.login(username: "hieupham9809@gmail.com", password: "MinhHieu")
    }
    func bindViewModel() {
        // MARK: SET LISTENER
        guard let viewModel = self.viewModel else {return}
        viewModel.userInfo.asObservable().subscribe(onNext: {(user : User?)->Void in
            guard let userInfo = user else {
                print("user return nil")
                return
                
            }
            print("gonna show user view controller")
//            let userFavoriteVC = self.storyboard?.instantiateViewController(withIdentifier: "UserFavorite") as! UserFavoriteListViewController
//            let userFavoriteViewModel = UserFavoriteListViewModel(id: userInfo.id)
//
//            userFavoriteVC.bindViewModel(to: userFavoriteViewModel)
            let userPlaylistVC = self.storyboard?.instantiateViewController(withIdentifier: "PlaylistVC") as! UserPlaylistsViewController
            let userPlaylistViewModel = UserPlaylistsViewModel(userId : userInfo.id)
            userPlaylistVC.bindViewModel(to: userPlaylistViewModel)
            self.navigationController?.pushViewController(userPlaylistVC, animated: true)
//            self.present(userFavoriteVC, animated: true, completion: nil)
            }).disposed(by: disposeBag)
        
        viewModel.loading.asObservable().subscribe(onNext: {(isLoading : Bool)->Void in
            print("show loading indicator : \(isLoading)")
            if (isLoading){
                self.addChild(self.spinner)
                self.spinner.view.frame = self.view.frame
                self.view.addSubview(self.spinner.view)
                self.spinner.didMove(toParent: self)
                
            } else {
                self.spinner.willMove(toParent: nil)
                self.spinner.view.removeFromSuperview()
                self.spinner.removeFromParent()
            }
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
