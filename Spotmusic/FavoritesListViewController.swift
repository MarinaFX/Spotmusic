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
        tableView.dataSource = self
        tableView.delegate = self
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    // MARK: Cell configuration
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favorites-songs", for: indexPath)
        
        return cell
    }
}
