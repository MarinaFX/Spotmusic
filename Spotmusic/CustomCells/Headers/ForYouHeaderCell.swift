//
//  ForYouHeaderCell.swift
//  Spotmusic
//
//  Created by Marina De Pazzi on 25/06/21.
//

import UIKit

class ForYouHeaderCell: UITableViewCell {

    @IBOutlet weak var forYouLabel: UILabel!
    @IBOutlet weak var automaticPlaylistsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
