//
//  BaseTabBarViewController.swift
//  FilmMVVM
//
//  Created by HieuPM on 4/17/20.
//  Copyright © 2020 HieuPM. All rights reserved.
//

import UIKit

class BaseTabBarViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.isTranslucent = true
        tabBar.tintColor = UIColor.blue
        tabBar.barTintColor = UIColor.white
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let mainVC = storyBoard.instantiateViewController(withIdentifier: "mainVC") as! MainViewController
        let mainViewModel = MainViewModel()
        mainVC.bindViewModel(to: mainViewModel)
        
        let loginVC = storyBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginViewController
        let loginViewModel = LoginViewModel()
        loginVC.bindViewModel(to: loginViewModel)
        
        
        let mainNavigationController = UINavigationController(rootViewController: mainVC)
        let loginNavigationController = UINavigationController(rootViewController: loginVC)
        
        viewControllers = [mainNavigationController, loginNavigationController]
        
        configNavAndTabBar(viewController: mainVC, navTitle: "Discovery", tabBarTitle: "Show Feeds", image: "Home", selectedImage: "Selected-Home")
        configNavAndTabBar(viewController: loginVC, navTitle: "Login", tabBarTitle: "Personalize", image: "Profile", selectedImage: "Selected-Profile")
    }

    func configNavAndTabBar(viewController: UIViewController, navTitle: String, tabBarTitle : String, image: String, selectedImage : String){
        viewController.navigationItem.title = navTitle
        let tabBar = UITabBarItem(title: tabBarTitle, image: UIImage(named: image), selectedImage: UIImage(named: selectedImage))
        
        viewController.tabBarItem = tabBar
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
