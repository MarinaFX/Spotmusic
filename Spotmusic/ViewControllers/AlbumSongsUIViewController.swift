//
//  AlbumSongsUIViewController.swift
//  Spotmusic
//
//  Created by Marina De Pazzi on 18/06/21.
//

import UIKit

//first cell id AlbumPresentation
//second cell id insideAlbumSongsCell

//MARK: To-dos
/*
    Tuesday:
    - make album description + detail screen
    - finish remaining required screen
    - Start extra features
    
 */

class AlbumSongsUIViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    private var musicService: MusicService?
    var album: MusicCollection?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        self.navigationItem.title = album?.title ?? "Album name"
    }
    
    // MARK: Question
    //revisar se tem como desencapsular o album antes p n lidar com optional em todo lugar (olhar videos do rafa e renan primeiro)
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let unwrappedAlbum = album else { return 0 }
        return unwrappedAlbum.musics.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumPresentation", for: indexPath) as! AlbumPresentationCell
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
            
            guard let unwrappedAlbum = album else
            { fatalError() }
            
            cell.imageCover.image = musicService?.getCoverImage(forItemIded: unwrappedAlbum.id)
            cell.albumNameLabel.text = unwrappedAlbum.title
            cell.albumArtist.text = "\(unwrappedAlbum.type) by \(unwrappedAlbum.mainPerson)"
            cell.albumSongCount.text = "\(unwrappedAlbum.musics.count) songs "
            cell.albumRelDate.text = "Released \(DateFormatter.localizedString(from: unwrappedAlbum.referenceDate, dateStyle: DateFormatter.Style.medium, timeStyle: DateFormatter.Style.none))"
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "insideAlbumSongsCell", for: indexPath) as! SongFromAlbumCell
            
            guard let unwrappedAlbum = album else
            { fatalError() }
            let song = unwrappedAlbum.musics[indexPath.row - 1]
            
            cell.imageCover.image = musicService?.getCoverImage(forItemIded: unwrappedAlbum.musics[indexPath.row - 1].id)
            cell.songNameLabel.text = song.title
            cell.artistLabel.text = song.artist
            
            return cell
        }
    }
}

//MARK: Question
/*
 Devo criar uma funcao para passar a mesma ref do MusicService adiante (devo manter um singleton) ou posso criar novas instancias?
 */

extension AlbumSongsUIViewController {
    
    func getMusicService(service: MusicService) -> Void {
        self.musicService = service
    }
}
