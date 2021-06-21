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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
