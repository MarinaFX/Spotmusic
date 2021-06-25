//
//  DiscoverPlaylistsCell.swift
//  Spotmusic
//
//  Created by Marina De Pazzi on 25/06/21.
//

import UIKit

class DiscoverPlaylistsCell: UITableViewCell {
    
    @IBOutlet weak var miniPlaylist: MiniPlaylist!
    @IBOutlet weak var miniPlaylist2: MiniPlaylist!
    @IBOutlet weak var miniPlaylist3: MiniPlaylist!
    @IBOutlet weak var miniPlaylist4: MiniPlaylist!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
