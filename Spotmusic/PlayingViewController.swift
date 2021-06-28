//
//  PlayingViewController.swift
//  Spotmusic
//
//  Created by Hojin Ryu on 21/06/21.
//

import UIKit

class PlayingViewController: UIViewController, SongFromAlbumDelegate {
    //MARK: Variables and class setup
    @IBOutlet weak var playingCoverImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var likedImage: UIImageView!
    
    private var musicService: MusicService? = try? MusicService()
    
    var delegate: SongFromAlbumDelegate?
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
        guard let isFavorite = delegate?.favoriteSong(song: playingNow!) else { return }
        
        if isFavorite {
            likedImage.image = UIImage(systemName: "heart.fill")
            likedImage.tintColor = UIColor.red
        }
        else {
            likedImage.image = UIImage(systemName: "heart")
            likedImage.tintColor = UIColor.black

        }
    }
    
    @objc func addTapped(){
        print("tapped")
        
        performSegue(withIdentifier: "toQueueList", sender: playingNow)
    }
    
    func favoriteSong(song: Music) -> Bool {
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toQueueList", let music = sender as? Music {
            let dest1 = segue.destination as! UINavigationController
            let finalDest = dest1.topViewController as! QueueListViewController

            finalDest.nowPlayingMusic = music

        }
    }
}

