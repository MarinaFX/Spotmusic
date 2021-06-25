//
//  favoritesProtocol.swift
//  Spotmusic
//
//  Created by Hojin Ryu on 24/06/21.
//

import Foundation

protocol SongFromAlbumDelegate {
    func favoriteSong(song: Music) -> Bool;
}
