//
//  AlbumDetailsViewController.swift
//  Spotmusic
//
//  Created by Marina De Pazzi on 22/06/21.
//

import UIKit

/** Cell IDs
 1st Cell:  about-album
 2nd Cell: about-artist
 */

class AlbumDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: Variables and class setup
    @IBOutlet weak var tableView: UITableView!
    
    var musicService: MusicService?
    var album: MusicCollection?
    var albumDuration: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 900
        
        guard let unwrappedAlbum = album else { fatalError("Unable to unwrap album") }
        
        //let totalSongsDuration = unwrappedAlbum.musics.compactMap { music -> TimeInterval in return music.length }
        //let albumDuration = totalSongsDuration.reduce(0, +)
        
        albumDuration = unwrappedAlbum.musics
            .compactMap { $0.length }
            .reduce(0, +)
    }
    
    //MARK: Outlet actions
    
    @IBAction func dismissAction(_ sender: Any) {
        self.navigationController?.dismiss(animated: true)
    }
    
    //MARK: DataSource delegation
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "about-album", for: indexPath) as! AboutAlbumTableViewCell
            
            guard let unwrappedAlbum = album else { fatalError() }
            
            cell.imageCover.image = musicService?.getCoverImage(forItemIded: unwrappedAlbum.id)
            cell.albumNameLabel.text = unwrappedAlbum.title
            cell.albumArtistLabel.text = "\(unwrappedAlbum.type) by \(unwrappedAlbum.mainPerson)"
            cell.countAndDurationLabel.text = "\(unwrappedAlbum.musics.count) songs, \((albumDuration?.rounded() ?? 0)/60)min \(albumDuration?.rounded() ?? 0)s"
            cell.relDateLabel.text = "\(DateFormatter.localizedString(from: unwrappedAlbum.referenceDate, dateStyle: DateFormatter.Style.long, timeStyle: DateFormatter.Style.none))"
            
            cell.aboutAlbumLabel.text = unwrappedAlbum.albumDescription
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "about-artist", for: indexPath) as! AboutArtistViewCell
            
            guard let unwrappedAlbum = album else { fatalError() }
            
            cell.artistNameLabel.text = unwrappedAlbum.mainPerson
            cell.aboutAristLabel.text = unwrappedAlbum.albumArtistDescription
            
            return cell
        }
    }
}

extension AlbumDetailsViewController {
    
    func getMusicService(service: MusicService) -> Void {
        self.musicService = service
    }
}
