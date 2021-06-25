//
//  AlbumSongsUIViewController.swift
//  Spotmusic
//
//  Created by Marina De Pazzi on 18/06/21.
//

import UIKit

/**
 Cell IDs
 1st Cell:  AlbumPresentation
 2nd Cell: insideAlbumSongsCell
 */

class AlbumSongsUIViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SongFromAlbumDelegate {
    
    //MARK: Variables and class setup
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var miniPlayerView: MiniPlayerView!
    
    var musicService: MusicService?
    var album: MusicCollection?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsMultipleSelectionDuringEditing = false
        
        self.navigationItem.title = album?.title ?? "Album name"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
        tableView.reloadData()
    }
    
    func loadData(){
        guard let unwrappedAlbum = album else { return }
        let updatedAlbum = musicService?.getCollection(id: unwrappedAlbum.id)
        self.album = updatedAlbum
    }
    
    //MARK: Outlet actions
    @IBAction func infoButtonAction(_ sender: Any) {
        performSegue(withIdentifier: "toAlbumDetails", sender: nil)
    }
    
    // MARK: TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let unwrappedAlbum = album else { return 0 }
        return unwrappedAlbum.musics.count + 1
    }
    
    // MARK: TableView DataSource - Cell configuration
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let unwrappedAlbum = album else
        { fatalError() }
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumPresentation", for: indexPath) as! AlbumPresentationCell
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
            
            let formater = DateFormatter()
            formater.dateFormat = "MMM dd yyyy"
            var formattedDate = formater.string(from: unwrappedAlbum.referenceDate)
            let i = formattedDate.index(formattedDate.startIndex, offsetBy: 6)
            formattedDate.insert(",", at: i)
            formattedDate.insert("h", at: i)
            formattedDate.insert("t", at: i)
            
            cell.imageCover.image = musicService?.getCoverImage(forItemIded: unwrappedAlbum.id)
            cell.albumNameLabel.text = unwrappedAlbum.title
            cell.albumArtist.text = "\(unwrappedAlbum.type) by \(unwrappedAlbum.mainPerson)"
            cell.albumSongCount.text = "\(unwrappedAlbum.musics.count) songs "
            cell.albumRelDate.text = "Released \(formattedDate)"
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "insideAlbumSongsCell", for: indexPath) as! SongFromAlbumCell
            
            
            let song = unwrappedAlbum.musics[indexPath.row - 1]
            
            cell.imageCover.image = musicService?.getCoverImage(forItemIded: song.id)
            cell.songNameLabel.text = song.title
            cell.artistLabel.text = song.artist
            cell.delegate = self
            cell.song = song
            
            if isFavoriteSong(song: song) {
                cell.isFavoriteLabel.image = UIImage(systemName: "heart.fill")
                cell.isFavoriteLabel.tintColor = UIColor.red
            }
            else {
                cell.isFavoriteLabel.image = UIImage(systemName: "heart")
                cell.isFavoriteLabel.tintColor = UIColor.black
            }
            return cell
        }
    }
    
    //MARK: TableView Delegate
    
    //verificar pq n esta deletando no music service
    //ao deletar e ir para tab dos favoritos e voltar para mesma tela, musica ainda permanece
    
    //MARK: TableView Delegate - Cell Editing
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete && album!.supportsEdition == true {
            album?.musics.remove(at: indexPath.row - 1)
            musicService?.removeMusic(album!.musics[indexPath.row - 1], from: album!)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    //MARK: TableView Delegate - Cell Selection
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if !(indexPath.row == 0) {
            return indexPath
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let unwrappedAlbum = album else { return }
        
        miniPlayerView.imageCover.image = musicService?.getCoverImage(forItemIded: unwrappedAlbum.musics[indexPath.row - 1].id)
        miniPlayerView.songNameLabel.text = unwrappedAlbum.musics[indexPath.row - 1].title
        miniPlayerView.artistNameLabel.text = unwrappedAlbum.musics[indexPath.row - 1].artist
        
        performSegue(withIdentifier: "toPlayingMusic", sender: indexPath)
    }
    
    //MARK: Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAlbumDetails" {
            let rootDest = segue.destination as! UINavigationController
            let finalDest = rootDest.topViewController as! AlbumDetailsViewController
            
            finalDest.album = self.album
            finalDest.musicService = musicService
        }
        else {
            if segue.identifier == "toPlayingMusic", let unwrappedIndexPath = sender as? IndexPath {
                let rootDest = segue.destination as! UINavigationController
                let finalDest = rootDest.topViewController as! PlayingViewController
                finalDest.playingNow = album?.musics[unwrappedIndexPath.row - 1]
            }
        }
    }
    
    //MARK: Heart selection function
    func isFavoriteSong(song: Music) -> Bool {
        return musicService?.favoriteMusics.contains(song) ?? false
    }
    
    //MARK: Favorite Protocol
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
    
}
