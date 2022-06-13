//
//  Album.swift
//  ITunes Search App
//
//  Created by Anna Delova on 6/11/22.
//

import Foundation

struct AlbumSearchResult: Codable {
    var results = [Album]()
}

struct Album: Codable, Comparable {
    static func < (lhs: Album, rhs: Album) -> Bool {
        return lhs.collectionName < rhs.collectionName
    }


    var artworkUrl100: String = ""
    var collectionName: String = ""
    var artistName: String = ""
    var trackCount: Int = 0
    var releaseDate: String = ""
    var collectionId: Int = 0
}


