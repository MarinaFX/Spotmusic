//
//  AlbumSongsUIViewController.swift
//  Spotmusic
//
//  Created by Marina De Pazzi on 18/06/21.
//

import UIKit

//first cell id AlbumPresentation
//second cell id insideAlbumSongsCell

// MARK: Questions
/*
    -pq as contraints de titulo nao estao funcionando? Ao entrar em um album/playlist com nome grande o titulo da navegacao fica ... e na first cell sai da tela
    
    -pq estou comendo a primeira cell? Ex: How to Be a Human Being tem 11 musicas e sao renderizadas apenas 10 celulas
 
    -pq ao fazer o scroll p baixo na tela do album, a navigationbar fica com uma mascara cinza?
 */

class AlbumSongsUIViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    /*
     depois que terminar a tela criar as 4 outlets (capa, artista, album e release date)
     depois de criar os outlets, criar as variaveis bridge para armezenar os valores que os outlets irao receber
     */
    
    private var musicService: MusicService?
    var album: MusicCollection?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        self.navigationItem.title = album?.title ?? "Album name"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return album?.musics.count ?? 0
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
            let song = unwrappedAlbum.musics[indexPath.row]
            
            cell.imageCover.image = musicService?.getCoverImage(forItemIded: unwrappedAlbum.musics[indexPath.row].id)
            cell.songNameLabel.text = song.title
            cell.artistLabel.text = song.artist
            
            return cell
        }
    }
}

extension AlbumSongsUIViewController {
    
    func getMusicService(service: MusicService) -> Void {
        self.musicService = service
    }
}
