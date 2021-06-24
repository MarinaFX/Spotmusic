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
        //this lambda function was transformed into this:
        
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
            
            let albumMin = String(format: "%.0f", (albumDuration!/60).truncatingRemainder(dividingBy: 60).rounded(FloatingPointRoundingRule.towardZero))
            let albumSec = String(format: "%.0f", albumDuration!.truncatingRemainder(dividingBy: 60).rounded())
            
            let formater = DateFormatter()
            formater.dateFormat = "MMM dd yyyy"
            var formattedDate = formater.string(from: unwrappedAlbum.referenceDate)
            let i = formattedDate.index(formattedDate.startIndex, offsetBy: 6)
            formattedDate.insert(",", at: i)
            formattedDate.insert("h", at: i)
            formattedDate.insert("t", at: i)

            
            cell.imageCover.image = musicService?.getCoverImage(forItemIded: unwrappedAlbum.id)
            cell.albumNameLabel.text = unwrappedAlbum.title
            cell.albumArtistLabel.text = "\(unwrappedAlbum.type) by \(unwrappedAlbum.mainPerson)"
            cell.countAndDurationLabel.text = "\(unwrappedAlbum.musics.count) songs, \(albumMin)min \(albumSec)s"
            cell.relDateLabel.text = "Released \(formattedDate)"
            
            
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
