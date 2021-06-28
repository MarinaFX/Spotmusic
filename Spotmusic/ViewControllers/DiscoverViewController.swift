//
//  DiscoverViewController.swift
//  Spotmusic
//
//  Created by Marina De Pazzi on 25/06/21.
//

import UIKit

/**
 Cell IDs
 1st : discoverMyPlaylists
 2nd: recentlyReleased
 3rd : recommendedForYou
 4th : listenAgain
 
 Headers:
 1st : headerWithImage
 2nd: forYouHeader
 */

class DiscoverViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Variables and class setup
    @IBOutlet weak var tableView: UITableView!
    
    var musicService: MusicService? = try? MusicService()
    var albumPlaylistCollection: [MusicCollection] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        albumPlaylistCollection = musicService?.loadLibrary() ?? []
        
//      tableView.rowHeight = UITableView.automaticDimension
//      tableView.estimatedRowHeight = 300
        
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    // MARK: TableView DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    //MARK: TableView DataSource - Header Configuration
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let cell = tableView.dequeueReusableCell(withIdentifier: "headerWithImage") as! HeaderWithImageCell

        return cell.bounds.height
    }
    //trabalhar com array de enums ao inves de ifs hard coded
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "headerWithImage") as! HeaderWithImageCell
            
            cell.imageCover.image = musicService?.getCoverImage(forItemIded: albumPlaylistCollection[section].id)
            cell.recentlyReleasedLabel.text = "RECENTLY RELEASED"
            cell.artistNameLabel.text = albumPlaylistCollection[section].mainPerson
            
            return cell
        }
        else {
            if section == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "forYouHeader") as! ForYouHeaderCell
                
                cell.forYouLabel.text = "For You"
                cell.automaticPlaylistsLabel.text = "AUTOMATIC PLAYLISTS"
                
                return cell
            }
        }
        
        return UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    
    // MARK: TableView DataSource - Cell configuration
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "discoverMyPlaylists", for: indexPath) as! DiscoverPlaylistsCell
            
            cell.miniPlaylist.imageCover.image = musicService?.getCoverImage(forItemIded: albumPlaylistCollection[indexPath.row].id)
            cell.miniPlaylist.playlistNameLabel.text = albumPlaylistCollection[indexPath.row].title
            
            cell.miniPlaylist2.imageCover.image = musicService?.getCoverImage(forItemIded: albumPlaylistCollection[indexPath.row].id)
            cell.miniPlaylist2.playlistNameLabel.text = albumPlaylistCollection[indexPath.row].title
            
            cell.miniPlaylist3.imageCover.image = musicService?.getCoverImage(forItemIded: albumPlaylistCollection[indexPath.row].id)
            cell.miniPlaylist3.playlistNameLabel.text = albumPlaylistCollection[indexPath.row].title
            
            cell.miniPlaylist4.imageCover.image = musicService?.getCoverImage(forItemIded: albumPlaylistCollection[indexPath.row].id)
            cell.miniPlaylist4.playlistNameLabel.text = albumPlaylistCollection[indexPath.row].title
            
            return cell
        }
        else {
            if indexPath.section == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "recentlyReleased", for: indexPath) as! RecentlyReleasedCell
                
                cell.recentlyReleased.imageCover.image = musicService?.getCoverImage(forItemIded: albumPlaylistCollection[indexPath.row].id)
                cell.recentlyReleased.albumNameLabel.text = albumPlaylistCollection[indexPath.row].title
                cell.recentlyReleased.artistNameLabel.text = albumPlaylistCollection[indexPath.row].mainPerson
                
                return cell
            }
            else {
                if indexPath.section == 2 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "recommendedForYou", for: indexPath) as! RecommendedForYouCell
                    
                    cell.recommendedForYou.imageCover.image = musicService?.getCoverImage(forItemIded: albumPlaylistCollection[indexPath.row].id)
                    cell.recommendedForYou.albumNameLabel.text = albumPlaylistCollection[indexPath.row].title
                    cell.recommendedForYou.artistNameLabel.text = albumPlaylistCollection[indexPath.row].mainPerson
                    
                    return cell
                }
                else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "listenAgain", for: indexPath) as! ListenAgainCell
                    
                    cell.firstAlbum.image = musicService?.getCoverImage(forItemIded: albumPlaylistCollection[indexPath.row].id)
                    cell.secondAlbum.image = musicService?.getCoverImage(forItemIded: albumPlaylistCollection[indexPath.row].id)
                    cell.firstAlbumNameLabel.text = albumPlaylistCollection[indexPath.row].title
                    cell.secondAlbumNameLabel.text = albumPlaylistCollection[indexPath.row].title

                    return cell
                }
            }
        }
    }
}
