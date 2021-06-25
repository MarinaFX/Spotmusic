//
//  QueueListViewController.swift
//  Spotmusic
//
//  Created by Hojin Ryu on 23/06/21.
//

import UIKit
//identifier : queue-songs
class QueueListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //merging to master
    
    @IBOutlet weak var tableView: UITableView!
    
    var musicService: MusicService? = try? MusicService()
    var musicCollections: MusicCollection?
    var nowPlayingMusicCollectionId: String = ""
    var nowPlayingMusic: Music?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        musicCollections = musicService?.getCollection(id: nowPlayingMusicCollectionId) ?? nil
        //How do i get id of collections. Maybe in the library needs to hold and keep passing collection ID. Library -> playlist -> playing -> then here.
        
        
        
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }
    
    func likeButton() -> UIButton{
        let favButton = UIButton(type: .system)
        favButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        favButton.contentMode = .scaleAspectFit
        favButton.sizeToFit()
        favButton.addTarget(self, action: #selector(self.whenTapped), for: .touchUpInside)
        favButton.tintColor = UIColor.red
        
        return favButton
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

//        let favMusics = musicService?.favoriteMusics[indexPath.row]
        //how to put differnt list of musics for each sections.
        //every sections has their own different list of musics.
        //so this code above won't work
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "queue-songs", for: indexPath) as! QueueListCell
        
        
        let plusButton = likeButton()
        plusButton.tag = indexPath.row
        cell.contentView.superview?.tag = indexPath.section
        cell.accessoryView = plusButton
        
        cell.coverImage.image = musicService?.getCoverImage(forItemIded: nowPlayingMusic?.id ?? "")
        cell.titleLabel.text = nowPlayingMusic?.title
        cell.artistLabel.text = nowPlayingMusic?.artist
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "nowplaying"
    }

    @objc func whenTapped(_ sender: Any){
        let button = sender as! UIButton
        let row = button.tag
        let sec = button.superview?.tag
        
        print("button row: \(row ),, section: \(sec ?? 0)")

    }
    
    
    
    

    
}
