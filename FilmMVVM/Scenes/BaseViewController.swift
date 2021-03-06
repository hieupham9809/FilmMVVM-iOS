//
//  BaseViewController.swift
//  FilmMVVM
//
//  Created by HieuPM on 4/22/20.
//  Copyright © 2020 HieuPM. All rights reserved.
//

import UIKit
import RxSwift
protocol MovieItemProtocol {
    func markItemAsFavorite(isAdd: Bool, id : Int, onCompleted: @escaping (Bool)->Void)
}

class BaseViewController: UIViewController, MovieItemProtocol{
    let refreshControl = UIRefreshControl()
    let disposeBag = DisposeBag()
    
    func markItemAsFavorite(isAdd: Bool, id: Int, onCompleted: @escaping (Bool)->Void) {
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
//        addRefreshControlToView()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        addRefreshControlToView()
        refreshControl.addTarget(self, action: #selector(self.refreshData(sender:)), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Loading data...")
        
        
    }
    @objc func refreshData(sender: Any){
        
    }
    func addRefreshControlToView(){
        
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
extension BaseViewController {
    func showToast(message : String, font : UIFont){
        let toastLabel = UILabel(frame: CGRect(
            x: self.view.frame.size.width / 2 - 120,
            y: self.view.frame.size.height - 100,
            width: 240,
            height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4,delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
        
    }
}
