//
//  NetworkService.swift
//  ITunes Search App
//
//  Created by Anna Delova on 6/11/22.
//

import Foundation

final class NetworkService {

    private var urlComponents: URLComponents = {
        var url = URLComponents()
        url.scheme = "https"
        url.host = "itunes.apple.com"
        return url
    }()

    func searchMusicAlbums(search term: String, completion: @escaping ([Album]?) -> Void) {
        let searchString = term.replacingOccurrences(of: " ", with: "+")
        urlComponents.path = "/ru/search"
        let queryParams: [String: String] = [
            "term": searchString,
            "country": "RU",
            "media": "music",
            "entity": "album",
            "attribute": "albumTerm",
        ]
        urlComponents.setQueryItems(with: queryParams)
//        print(urlComponents.url?.absoluteString)

        guard let url = urlComponents.url else {
            print(NetworkError.invalidUrl)
            return
        }
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { data, response, error in
            if error == nil &&  data != nil {
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(AlbumSearchResult.self, from: data!)
                    let albums = result.results
                    let sortedAlbums = albums.sorted { $0.collectionName < $1.collectionName }
                    completion(sortedAlbums)
                }
                catch {
                    print(NetworkError.parsingError)
                }
            }
        }
        dataTask.resume()
    }

    func getAlbumTracks(albumId: Int, completion: @escaping ([Track]?) -> Void) {
        urlComponents.path = "/lookup"

        let queryParams: [String: String] = [
            "id": String(albumId),
            "entity": "song",
        ]
        urlComponents.setQueryItems(with: queryParams)

        guard let url = urlComponents.url else {
            print(NetworkError.invalidUrl)
            return
        }
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { data, response, error in
            if error == nil &&  data != nil {
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(TracksSearchResult.self, from: data!)
                    let tracks = result.results
                    completion(tracks)
                }
                catch {
                    print(NetworkError.parsingError)
                }
            }
        }
        dataTask.resume()
    }
}
