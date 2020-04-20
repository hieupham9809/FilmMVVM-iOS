//
//  MovieCell.swift
//  FilmMVVM
//
//  Created by HieuPM on 4/15/20.
//  Copyright © 2020 HieuPM. All rights reserved.
//

import UIKit
import Kingfisher

class MovieCell: UITableViewCell {
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
                width: frame.width - self.thumbnail.frame.size.width - 2 * self.margin,
                height: 30.0)
            self.descrpt.frame = CGRect(
                x: self.title.frame.minX,
                y: self.title.frame.maxY,
                width: self.title.frame.size.width,
                height: 40.0 )
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        self.contentView.addSubview(thumbnail)
        self.contentView.addSubview(title)
        self.contentView.addSubview(descrpt)
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
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
