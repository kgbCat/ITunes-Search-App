//
//  AlbumTracksViewModel.swift
//  ITunes Search App
//
//  Created by Anna Delova on 6/11/22.
//

import UIKit

class AlbumTracksViewModel {

    private let networkService = NetworkService()

    var albumTitle = ""
    var groupTitle = ""
    var date =  ""
    var image = ""
    var id = 0

    var filteredTracks = [Track]()

//    func getTracks(with id:  Int) {
//        networkService.getAlbumTracks(albumId: id) { [weak self] tracks in
//            guard self != nil,
//                  tracks != nil
//            else { return }
//            self?.filteredTracks = tracks!
////            tracks!.forEach({ track in
////                if track.trackName != nil {
////                    filteredTracks.append(track)
////                }
////            })
//        }
//    }

    func getAlbumsData(albumTitle:String, groupTitle:String, date: String, imageUrl: String) {
        self.albumTitle = albumTitle
        self.groupTitle = groupTitle
        self.date = date
        self.image = imageUrl
    }

}
