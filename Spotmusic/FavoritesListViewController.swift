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
        
        let mock = musicService?.favoriteMusics[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "favorites-songs", for: indexPath) as! FavoritesListCell
        
        cell.coverImage.image = musicService?.getCoverImage(forItemIded: mock?.id ?? "")
        cell.titleLabel.text = mock?.title
        cell.artistLabel.text = mock?.artist
        cell.isFavoriteImage.image = UIImage(systemName: "heart.fill")
        
//        let music = musicService?.favoriteMusics[indexPath.row]
        
//        let albumArray = albums[indexPath.section].musics[indexPath.row]
//
//        musicService?.toggleFavorite(music: albumArray, isFavorite: false)

//
//
//        cell.textLabel?.text = mock?.title
//        cell.detailTextLabel?.text = mock?.artist
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected \(indexPath)")
        
        performSegue(withIdentifier: "toPlaying", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPlaying", let indexPath = sender as? IndexPath {
            let destination = segue.destination as? PlayingViewController
            
            destination?.playingNow = musicService?.favoriteMusics[indexPath.row]
            
        }
    }
}
