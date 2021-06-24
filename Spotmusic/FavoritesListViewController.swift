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
    
    let searchController = UISearchController(searchResultsController: nil)
    var musicService: MusicService? = try? MusicService()
    
    var albums: [MusicCollection] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.searchController = searchController
        searchController.searchBar.setImage(UIImage(systemName: "mic.fill"), for: .bookmark, state: .normal)
        searchController.searchBar.showsBookmarkButton = true
        
        albums = musicService?.loadLibrary() ?? []
        
//Mock Data
//        let albumArray = albums[0].musics[1]
//        let albumArray2 = albums[0].musics[2]
//        musicService?.toggleFavorite(music: albumArray, isFavorite: true)
//        musicService?.toggleFavorite(music: albumArray2, isFavorite: true)
//        let albumArray3 = albums[0].musics[3]
//        let albumArray4 = albums[0].musics[4]
//        let albumArray5 = albums[0].musics[5]
//        musicService?.toggleFavorite(music: albumArray3, isFavorite: true)
//        musicService?.toggleFavorite(music: albumArray4, isFavorite: true)
//        musicService?.toggleFavorite(music: albumArray5, isFavorite: true)
        
        
        tableView.dataSource = self
        tableView.delegate = self

        
    }
    
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return musicService?.favoriteMusics.count ?? 0
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
    
    // MARK: Cell configuration
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let favMusics = musicService?.favoriteMusics[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "favorites-songs", for: indexPath) as! FavoritesListCell
        
        
        let plusButton = likeButton()
        plusButton.tag = indexPath.row
        cell.contentView.superview?.tag = indexPath.section
        cell.accessoryView = plusButton
        
        cell.coverImage.image = musicService?.getCoverImage(forItemIded: favMusics?.id ?? "")
        cell.titleLabel.text = favMusics?.title
        cell.artistLabel.text = favMusics?.artist
        
        
        return cell
    }
    
    @objc func whenTapped(_ sender: Any){
        let button = sender as! UIButton
        let row = button.tag
        let sec = button.superview?.tag

        if let excludeFav = musicService?.favoriteMusics[row] {
            musicService?.toggleFavorite(music: excludeFav, isFavorite: false)
        }
        
        //quando pegar 1 musica e exclui, favorites[] fica com 1 musica soh, ent row 1 n existe mais, tem q ser 0.
        
        //- the weekend :0
        //- maroon 5 :1
        
        
        //depois de tirar the weekend
        // e quero tirar maroon 5
        // mas n eh mais maroon 5: 1 eh maroon 5 :0 agr
        
        
        tableView.reloadData()
        print("button row: \(row ),, section: \(sec ?? 0)")

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected \(indexPath)")
        
        performSegue(withIdentifier: "toPlaying", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPlaying", let indexPath = sender as? IndexPath {
            let destination = segue.destination as? UINavigationController
            let dest2 = destination?.topViewController as? PlayingViewController
            
            dest2?.playingNow = musicService?.favoriteMusics[indexPath.row]
            
        }
    }
}
