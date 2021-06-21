//
//  AlbumWithImageCell.swift
//  Spotmusic
//
//  Created by Marina De Pazzi on 18/06/21.
//

import UIKit

class AlbumWithImageCell: UITableViewCell {

    @IBOutlet weak var imageCover: UIImageView!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var albumTypeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
