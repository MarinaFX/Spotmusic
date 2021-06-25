//
//  ListenAgainCell.swift
//  Spotmusic
//
//  Created by Marina De Pazzi on 25/06/21.
//

import UIKit

class ListenAgainCell: UITableViewCell {

    @IBOutlet weak var firstAlbum: UIImageView!
    @IBOutlet weak var secondAlbum: UIImageView!
    @IBOutlet weak var firstAlbumNameLabel: UILabel!
    @IBOutlet weak var secondAlbumNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
