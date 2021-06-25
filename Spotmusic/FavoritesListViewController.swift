//
//  FavoritesList.swift
//  Spotmusic
//
//  Created by Hojin Ryu on 18/06/21.
//

import Foundation
import UIKit

class FavoritesListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let searchController = UISearchController(searchResultsController: nil)
    @IBOutlet weak var tableView: UITableView!
    
    private var musicService: MusicService? = try? MusicService()
    private var albums: [MusicCollection] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Favorites"
        navigationItem.searchController = searchController
        searchController.searchBar.setImage(UIImage(systemName: "mic.fill"), for: .bookmark, state: .normal)
        searchController.searchBar.showsBookmarkButton = true
        
        albums = musicService?.loadLibrary() ?? []
    
        tableView.dataSource = self
        tableView.delegate = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicService?.favoriteMusics.count ?? 0
    }
    
    // MARK: Cell configuration
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let plusButton = UIButton(type: .system)
        plusButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        plusButton.contentMode = .scaleAspectFit
        plusButton.sizeToFit()
        plusButton.addTarget(self, action: #selector(self.whenTapped), for: .touchUpInside)
        plusButton.tintColor = UIColor.red
        plusButton.tag = indexPath.row
        
        
        
        let favMusics = musicService?.favoriteMusics[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "favorites-songs", for: indexPath) as! FavoritesListCell
        
        cell.contentView.superview?.tag = indexPath.section
        cell.coverImage.image = musicService?.getCoverImage(forItemIded: favMusics?.id ?? "")
        cell.titleLabel.text = favMusics?.title
        cell.artistLabel.text = favMusics?.artist
//        cell.isFavoriteImage.image = UIImage(systemName: "heart.fill")
        
        cell.accessoryView = plusButton
        
        
        return cell
    }
    
    @objc func whenTapped(_ sender: Any){
        let button = sender as! UIButton
        let row = button.tag
        let sec = button.superview?.tag

//        if let excludeFav = musicService?.favoriteMusics[row] {
//            musicService?.toggleFavorite(music: excludeFav, isFavorite: false)
//        }
        
        //quando pegar 1 musica e exclui, favorites[] fica com 1 musica soh, ent row 1 n existe mais, tem q ser 0.
        
        //- the weekend :0
        //- maroon 5 :1
        
        
        //depois de tirar the weekend
        // e quero tirar maroon 5
        // mas n eh mais maroon 5: 1 eh maroon 5 :0 agr
        
        

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
