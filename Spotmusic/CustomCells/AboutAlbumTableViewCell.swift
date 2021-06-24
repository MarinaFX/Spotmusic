//
//  AboutAlbumTableViewCell.swift
//  Spotmusic
//
//  Created by Marina De Pazzi on 22/06/21.
//

import UIKit

class AboutAlbumTableViewCell: UITableViewCell {

    @IBOutlet weak var imageCover: UIImageView!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var albumArtistLabel: UILabel!
    @IBOutlet weak var countAndDurationLabel: UILabel!
    @IBOutlet weak var relDateLabel: UILabel!
    @IBOutlet weak var aboutAlbumLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
