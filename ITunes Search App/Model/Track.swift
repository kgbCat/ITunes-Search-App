//
//  Track.swift
//  ITunes Search App
//
//  Created by Anna Delova on 6/11/22.
//

import Foundation

struct TracksSearchResult: Codable {
    var results = [Track]()
}
struct Track: Codable {
    var trackName: String? = ""
}
