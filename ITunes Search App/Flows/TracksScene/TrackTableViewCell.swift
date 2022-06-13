//
//  TrackTableViewCell.swift
//  ITunes Search App
//
//  Created by Anna Delova on 6/11/22.
//

import UIKit

class TrackTableViewCell: UITableViewCell {

    @IBOutlet weak var trackTitleLabel: UILabel!

    func configure(title: String) {
        trackTitleLabel.text = title
    }
}
