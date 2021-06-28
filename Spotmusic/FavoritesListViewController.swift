//
//  FavoritesList.swift
//  Spotmusic
//
//  Created by Hojin Ryu on 18/06/21.
//

import Foundation
import UIKit

class FavoritesListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    //lalalalal
    //MARK: Variables and class setup
    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    var musicService: MusicService? = try? MusicService()
    var albums: [MusicCollection] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.searchController = searchController
        searchController
            .searchBar
            .setImage(UIImage(systemName: "mic.fill"), for: .bookmark, state: .normal)
        searchController.searchBar.showsBookmarkButton = true
        
        albums = musicService?.loadLibrary() ?? []
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    // MARK: TableView DataSource
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
    
    // MARK: TableView DataSource - Cell configuration
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let favMusics = musicService?.favoriteMusics[indexPath.row] else { fatalError() }
        let cell = tableView.dequeueReusableCell(withIdentifier: "favorites-songs", for: indexPath) as! FavoritesListCell
        
        let plusButton = likeButton()
        plusButton.tag = indexPath.row
        cell.contentView.superview?.tag = indexPath.section
        cell.accessoryView = plusButton
        
        cell.coverImage.image = musicService?.getCoverImage(forItemIded: favMusics.id)
        cell.titleLabel.text = favMusics.title
        cell.artistLabel.text = favMusics.artist
        
        return cell
    }
    
    @objc func whenTapped(_ sender: Any){
        let button = sender as! UIButton
        let row = button.tag
        
        if let excludeFav = musicService?.favoriteMusics[row] {
            if !favoriteSong(song: excludeFav){
                tableView.reloadData()
            }
        }
    }
    
    func isFavoriteSong(song: Music) -> Bool {
        return musicService?.favoriteMusics.contains(song) ?? false
    }
    
    func favoriteSong(song: Music) -> Bool {
        if isFavoriteSong(song: song) {
            musicService?.toggleFavorite(music: song, isFavorite: false)
            return false
        }
        else {
            musicService?.toggleFavorite(music: song, isFavorite: true)
            return true
        }
    }
    
    //MARK: - TableView Delegate - Cell Selection
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected \(indexPath)")
        
        performSegue(withIdentifier: "toPlaying", sender: indexPath)
    }
    
    //MARK: Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPlaying", let indexPath = sender as? IndexPath {
            let destination = segue.destination as? UINavigationController
            let dest2 = destination?.topViewController as? PlayingViewController
            
            dest2?.playingNow = musicService?.favoriteMusics[indexPath.row]
        }
    }
}
