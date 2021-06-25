//
//  HeaderWithImageCell.swift
//  Spotmusic
//
//  Created by Marina De Pazzi on 25/06/21.
//

import UIKit

class HeaderWithImageCell: UITableViewCell {
    
    @IBOutlet weak var imageCover: UIImageView!
    @IBOutlet weak var recentlyReleasedLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageCover.layer.cornerRadius = 21
    }

}
