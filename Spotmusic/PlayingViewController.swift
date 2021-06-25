//
//  PlayingViewController.swift
//  Spotmusic
//
//  Created by Hojin Ryu on 21/06/21.
//

import UIKit

class PlayingViewController: UIViewController {
    @IBOutlet weak var playingCoverImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    
    private var musicService: MusicService? = try? MusicService()
    var playingNow: Music?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playingCoverImage.image = musicService?.getCoverImage(forItemIded: playingNow?.id ?? "")
        
        titleLabel.text = playingNow?.title
        artistLabel.text = playingNow?.artist
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"), style: .plain, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.green
        
    }
    
    @objc func addTapped(){
        print("tapped")
    }
}

