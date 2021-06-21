//
//  AlbumPresentationCell.swift
//  Spotmusic
//
//  Created by Marina De Pazzi on 21/06/21.
//

import UIKit

class AlbumPresentationCell: UITableViewCell {
    
    @IBOutlet weak var imageCover: UIImageView!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var albumArtist: UILabel!
    @IBOutlet weak var albumSongCount: UILabel!
    @IBOutlet weak var albumRelDate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
