//
//  AlbumTracksViewModel.swift
//  ITunes Search App
//
//  Created by Anna Delova on 6/11/22.
//

import UIKit

class AlbumTracksViewModel {

    var albumTitle = ""
    var groupTitle = ""
    var date =  ""
    var image = ""
    var id = 0

    func getAlbumsData(albumTitle:String, groupTitle:String, date: String, imageUrl: String) {
        self.albumTitle = albumTitle
        self.groupTitle = groupTitle
        self.date = date
        self.image = imageUrl
    }

}
