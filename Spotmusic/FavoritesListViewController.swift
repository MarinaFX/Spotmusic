//
//  FavoritesList.swift
//  Spotmusic
//
//  Created by Hojin Ryu on 18/06/21.
//

import Foundation
import UIKit

class FavoritesListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    @IBOutlet weak var tableView: UITableView!
    
    private var musicService: MusicService? = try? MusicService()
    private var albums: [MusicCollection] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        albums = musicService?.loadLibrary() ?? []
        
//Mock Data
        let albumArray = albums[0].musics[1]
        let albumArray2 = albums[0].musics[2]
        print(albumArray)
        musicService?.toggleFavorite(music: albumArray, isFavorite: true)
        musicService?.toggleFavorite(music: albumArray2, isFavorite: true)
        tableView.dataSource = self
        tableView.delegate = self

        
        
        
    }
    
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicService?.favoriteMusics.count ?? 0
    }
    
    // MARK: Cell configuration
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let plusButton = UIButton(type: .system)
//        plusButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
//        plusButton.contentMode = .scaleAspectFit
//        plusButton.sizeToFit()
//        plusButton.addTarget(self, action: #selector(self.whenTapped), for: .touchUpInside)
//        plusButton.tintColor = UIColor.red
//        plusButton.tag = indexPath.row
        
        
        
        let favMusics = musicService?.favoriteMusics[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "favorites-songs", for: indexPath) as! FavoritesListCell
        
//        cell.contentView.superview?.tag = indexPath.section
        cell.coverImage.image = musicService?.getCoverImage(forItemIded: favMusics?.id ?? "")
        cell.titleLabel.text = favMusics?.title
        cell.artistLabel.text = favMusics?.artist
//        cell.isFavoriteImage.image = UIImage(systemName: "heart.fill")
        
//        cell.accessoryView = plusButton
        
        
        return cell
    }
    
//    @objc func whenTapped(_ sender: Any){
//        let button = sender as! UIButton
//        let row = button.tag
//        let sec = button.superview?.tag
//
//        if let excludeFav = musicService?.favoriteMusics[row] {
//            musicService?.toggleFavorite(music: excludeFav, isFavorite: false)
//        }
//
//        print("button row: \(row ),, section: \(sec ?? 0)")
//
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected \(indexPath)")
        
        performSegue(withIdentifier: "toPlaying", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPlaying", let indexPath = sender as? IndexPath {
            let destination = segue.destination as? UINavigationController
            let dest2 = destination?.topViewController as? PlayingViewController
            print("dest: \(segue.destination)")
            dest2?.playingNow = musicService?.favoriteMusics[indexPath.row]
            
        }
    }
}
