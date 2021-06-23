//
//  AlbumSongsUIViewController.swift
//  Spotmusic
//
//  Created by Marina De Pazzi on 18/06/21.
//

import UIKit

/** Cell IDs
 1st Cell:  AlbumPresentation
 2nd Cell: insideAlbumSongsCell
 */

class AlbumSongsUIViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: Variables and class setup
    @IBOutlet weak var tableView: UITableView!
    
    var musicService: MusicService?
    var album: MusicCollection?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        self.navigationItem.title = album?.title ?? "Album name"
    }
    
    //MARK: Outlet actions
    
    @IBAction func infoButtonAction(_ sender: Any) {
        performSegue(withIdentifier: "toAlbumDetails", sender: nil)
    }
    
    //MARK: DataSource delegation
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let unwrappedAlbum = album else { return 0 }
        return unwrappedAlbum.musics.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let unwrappedAlbum = album else
        { fatalError() }
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumPresentation", for: indexPath) as! AlbumPresentationCell
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
            
            
            cell.imageCover.image = musicService?.getCoverImage(forItemIded: unwrappedAlbum.id)
            cell.albumNameLabel.text = unwrappedAlbum.title
            cell.albumArtist.text = "\(unwrappedAlbum.type) by \(unwrappedAlbum.mainPerson)"
            cell.albumSongCount.text = "\(unwrappedAlbum.musics.count) songs "
            cell.albumRelDate.text = "Released \(DateFormatter.localizedString(from: unwrappedAlbum.referenceDate, dateStyle: DateFormatter.Style.medium, timeStyle: DateFormatter.Style.none))"
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "insideAlbumSongsCell", for: indexPath) as! SongFromAlbumCell
            
           
            let song = unwrappedAlbum.musics[indexPath.row - 1]
            
            cell.imageCover.image = musicService?.getCoverImage(forItemIded: unwrappedAlbum.musics[indexPath.row - 1].id)
            cell.songNameLabel.text = song.title
            cell.artistLabel.text = song.artist
            
            return cell
        }
    }
    
    //MARK: Segues
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //performar segue para playing futuramente
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAlbumDetails" {
            let rootDest = segue.destination as! UINavigationController
            
            let finalDest = rootDest.topViewController as! AlbumDetailsViewController
            
            finalDest.album = self.album
            finalDest.musicService = musicService
            
        }
    }
    
}
