//
//  PlaylistTableViewCell.swift
//  FilmMVVM
//
//  Created by CPU12130 on 4/24/20.
//  Copyright © 2020 HieuPM. All rights reserved.
//

import UIKit
import Kingfisher

class PlaylistCollectionViewCell: UICollectionViewCell {
//    var playlistId : String?
    let margin : CGFloat = 10.0
    var playlistName : UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 1
        label.textColor = UIColor.black
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    var playlistDescription : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 2
        label.textColor = UIColor.black
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    var itemCount : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 1
        return label
    }()
    var thumbnail : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setContentForCell(playlist: Playlist){
        if let imagePath = playlist.posterPath {
            thumbnail.kf.setImage(with: URL(string: URLs.baseImageUrl + imagePath))
        } else {
            thumbnail.image = UIImage(named: "movie-placeholder")
        }
        
        playlistName.text = playlist.name
        playlistDescription.text = playlist.description
        itemCount.text = String("\(playlist.itemCount) \(playlist.itemCount > 1 ? "movies" : "movie")")
//        playlistId = playlist.id
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(thumbnail)
        self.addSubview(playlistName)
        self.addSubview(playlistDescription)
        self.addSubview(itemCount)
        
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override var frame: CGRect{
        didSet{
            // Update child's layout
//            guard frame.size != oldValue.size else {return}
            thumbnail.frame = CGRect(
                x: 0,
                y: 0,
                width: 80,
                height: 80
            )
            
            playlistName.frame = CGRect(
                x: thumbnail.frame.maxX + self.margin,
                y: 0,
                width: frame.width - thumbnail.frame.size.width - 2 * self.margin,
                height: 20
            )
            
            playlistDescription.frame = CGRect(
                x: playlistName.frame.minX,
                y: playlistName.frame.maxY,
                width: playlistName.frame.size.width,
                height: 40
            )
            
            itemCount.frame = CGRect(
                x: playlistDescription.frame.maxX - 80,
                y: playlistDescription.frame.maxY,
                width: 80,
                height: 10
            )

        }
    }
    

}
