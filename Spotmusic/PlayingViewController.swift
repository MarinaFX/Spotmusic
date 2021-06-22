//
//  PlayingViewController.swift
//  Spotmusic
//
//  Created by Hojin Ryu on 21/06/21.
//

import UIKit

class PlayingViewController: UIViewController {
    
    private var musicService: MusicService? = try? MusicService()
 
    @IBOutlet weak var playingCoverImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var artistLabel: UILabel!
    

    
    var playingNow: Music?
    
    override func viewDidLoad() {
        super.viewDidLoad()

     
        
        titleLabel.text = playingNow?.title
        playingCoverImage.image = musicService?.getCoverImage(forItemIded: playingNow?.id ?? "")
        

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"), style: .plain, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.green
        
        
    }
    
    @objc func addTapped(){
        print("tapped")
    }
    

}

