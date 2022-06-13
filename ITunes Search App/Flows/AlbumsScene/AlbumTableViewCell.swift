//
//  AlbumTableViewCell.swift
//  ITunes Search App
//
//  Created by Anna Delova on 6/11/22.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {


    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var albumTitleLable: UILabel!
    @IBOutlet weak var artistTitleLable: UILabel!
    @IBOutlet weak var tracksNumberLable: UILabel!

    func configure(imageURL: String, albumTitle: String, artistTitle: String, tracksCount: Int) {
        if let url = URL(string: imageURL){
            albumImageView.load(url: url)
        }
        albumTitleLable.text = albumTitle
        artistTitleLable.text = artistTitle
        tracksNumberLable.text  = "Tracks: \(String(tracksCount)) "
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
