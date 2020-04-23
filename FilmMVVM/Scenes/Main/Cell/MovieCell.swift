//
//  MovieCell.swift
//  FilmMVVM
//
//  Created by HieuPM on 4/15/20.
//  Copyright © 2020 HieuPM. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
  func setImageColor(color: UIColor) {
    let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
    self.image = templateImage
    self.tintColor = color
  }
}

class MovieCell: UITableViewCell {
    var id : Int?
    var likeIconActive = UIImage(named: "like-icon")
    var likeIconInActive = UIImage(named: "like-icon-inactive")
    var isLike : Bool = false {
        didSet {
            
            if isLike {
                likeButton.setImage(likeIconActive, for: .normal)
            } else {
                likeButton.setImage(likeIconInActive, for: .normal)
            }
        }
    }
    weak var parentVC : BaseViewController! = nil
    let margin : CGFloat = 10.0
    var thumbnail : UIImageView = {
        var thumb = UIImageView()
        thumb.contentMode = .scaleToFill
        
        return thumb
    }()
    var title : UILabel = {
        var label = UILabel()
        
       
        
        return label
    }()
    var descrpt : UILabel = {
        var label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    var likeButton : UIButton = {
        var btn = UIButton()
        
        btn.setImage(UIImage(named: "like-icon-inactive"), for: .normal)
        
        return btn
    }()
    
    override var frame: CGRect{
        didSet {
            guard frame.size != oldValue.size else {
                return
            }
            self.thumbnail.frame = CGRect(
                x: 0,
                y: 0,
                width: 80.0,
                height: 80.0)
            self.title.frame = CGRect(
                x: self.thumbnail.frame.maxX + self.margin,
                y: 0,
                width: frame.width - self.thumbnail.frame.size.width - 5 * self.margin,
                height: 30.0)
            
            self.descrpt.frame = CGRect(
                x: self.title.frame.minX,
                y: self.title.frame.maxY,
                width: self.title.frame.size.width,
                height: 40.0 )
            self.likeButton.frame = CGRect(
                x: self.title.frame.maxX,
                y: self.descrpt.frame.minY,
                width: 20,
                height: 20
            )
        }
    }
    @objc func toggleLikeState(sender: UIButton){
        print("like \(self.id ?? 0)")
        self.isLike = !self.isLike
        self.favoriteListHandleForItem(isAdd: self.isLike)
    }
    func favoriteListHandleForItem(isAdd : Bool){
        // MARK: create request
//        print("item \(self.id) isAdd: \(isAdd)")
        guard let id = self.id, let parent = self.parentVC else {return}
        
        parent.markItemAsFavorite(isAdd: isAdd, id: id){ isSuccess in
            self.isLike = isSuccess ? self.isLike : !self.isLike
        }
        
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        self.contentView.addSubview(thumbnail)
        self.contentView.addSubview(title)
        self.contentView.addSubview(descrpt)
        self.contentView.addSubview(likeButton)
        likeButton.addTarget(self, action: #selector(self.toggleLikeState(sender:)), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setContentForCell(movie: Movie){
        self.thumbnail.kf.setImage(with: URL(string: URLs.baseImageUrl +  movie.backDropPath))
        self.title.text = movie.title
        self.descrpt.text = movie.overview
        self.id = movie.id
        
        if (self.parentVC is UserFavoriteListViewController){
            self.isLike = true
        } else {
            self.isLike = false
        }
        
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
