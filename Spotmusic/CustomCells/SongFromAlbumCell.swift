//
//  SongFromAlbumCell.swift
//  Spotmusic
//
//  Created by Marina De Pazzi on 21/06/21.
//

import UIKit

class SongFromAlbumCell: UITableViewCell {
    @IBOutlet weak var imageCover: UIImageView!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var isFavoriteLabel: UIImageView!
    
    var delegate: SongFromAlbumDelegate?
    var song: Music?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleFavorite))
        isFavoriteLabel.addGestureRecognizer(tapGesture)
        isFavoriteLabel.isUserInteractionEnabled = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func toggleFavorite(){
        guard let isFavorite = delegate?.favoriteSong(song: song!) else { return }
        
        if isFavorite {
            isFavoriteLabel.image = UIImage(systemName: "heart.fill")
            isFavoriteLabel.tintColor = UIColor.red
        }
        else {
            isFavoriteLabel.image = UIImage(systemName: "heart")
            isFavoriteLabel.tintColor = UIColor.gray
        }
    }

}


protocol SongFromAlbumDelegate {
    func favoriteSong(song: Music) -> Bool;
}
