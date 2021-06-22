//
//  LibraryListViewController.swift
//  Spotmusic
//
//  Created by Marina De Pazzi on 18/06/21.
//

import UIKit

//cell id song-album-detail

class LibraryListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var musicService: MusicService? = try? MusicService()
    private var albumPlaylistCollection: [MusicCollection] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        albumPlaylistCollection = musicService?.loadLibrary() ?? []
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumPlaylistCollection.count
    }
    
    // MARK: Cell configuration
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let album = albumPlaylistCollection[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "song-album-detail", for: indexPath) as! AlbumWithImageCell
        
        cell.imageCover.image = musicService?.getCoverImage(forItemIded: album.id)
        cell.albumNameLabel.text = album.title
        cell.albumTypeLabel.text = "\(album.type) · \(album.mainPerson)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "toAlbumSongs", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAlbumSongs", let indexPath = sender as? IndexPath {
            let destination = segue.destination as! AlbumSongsUIViewController
            
            let album = albumPlaylistCollection[indexPath.row]
            destination.album = album
            destination.getMusicService(service: musicService!)
        }
    }
}
