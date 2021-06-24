//
//  PlayingViewController.swift
//  Spotmusic
//
//  Created by Hojin Ryu on 21/06/21.
//

import UIKit

class PlayingViewController: UIViewController {
    
    var musicService: MusicService? = try? MusicService()
 
    @IBOutlet weak var playingCoverImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var artistLabel: UILabel!
    
    @IBOutlet weak var likedImage: UIImageView!
    
    
    var playingNow: Music?
    
    override func viewDidLoad() {
        super.viewDidLoad()

     
        playingCoverImage.image = musicService?.getCoverImage(forItemIded: playingNow?.id ?? "")
        
        titleLabel.text = playingNow?.title
        artistLabel.text = playingNow?.artist
        

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"), style: .plain, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.green
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tappedMe))
        likedImage.addGestureRecognizer(tap)
        likedImage.isUserInteractionEnabled = true
        
        
    }
    @objc func tappedMe()
    {
        print("Tapped on Image")
        likedImage.image = UIImage(systemName: "heart")
    }
    
    @objc func addTapped(){
        print("tapped")
        
        performSegue(withIdentifier: "toQueueList", sender: playingNow)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toQueueList", let music = sender as? Music {
            let destination = segue.destination as? UINavigationController
            let dest2 = destination?.topViewController as? QueueListViewController
            
            dest2?.nowPlayingMusic = music
            
        }
    }
    

}

