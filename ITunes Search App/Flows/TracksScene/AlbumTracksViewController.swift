//
//  AlbumTracksViewController.swift
//  ITunes Search App
//
//  Created by Anna Delova on 6/11/22.
//

import UIKit

final class AlbumTracksViewController: UIViewController {

    var viewModel = AlbumTracksViewModel()
    var coordinator: AppCoordinator?
    private let cellId = String(describing: TrackTableViewCell.self)


    let networkService = NetworkService()
    var albumId = 0
    var albumTitle = ""
    var groupTitle = ""
    var date =  ""
    var image = ""

    var tracks = [Track]()


    @IBOutlet weak var albumImageView: UIImageView!

    @IBOutlet weak var albumTitleLabel: UILabel!
    @IBOutlet weak var GroupTitleLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!

    @IBOutlet weak var tableView: UITableView! {
        didSet  {
            tableView.dataSource = self

            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 40

            let nib = UINib(nibName: cellId, bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: cellId)
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        if let navigationController = navigationController {
              coordinator = AppCoordinator(navigationController: navigationController)
          }
        displayAlbumInfo()
        getTracks()

    }

    fileprivate func getTracks() {
        networkService.getAlbumTracks(albumId: albumId) { [weak self] tracks in
            guard self != nil,
                tracks != nil
            else { return }
            tracks?.forEach({ track in
                if track.trackName != nil {
                    self?.tracks.append(track)
                }
            })
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    func displayAlbumInfo() {
        DispatchQueue.main.async {
            self.albumTitleLabel.text = self.albumTitle
            self.GroupTitleLabel.text = self.groupTitle
            self.releaseLabel.text = self.date
            if let url = URL(string: self.image){
                self.albumImageView.load(url: url)
            }
        }
    }
}
extension AlbumTracksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tracks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId,
                                                       for: indexPath) as? TrackTableViewCell
        else { return UITableViewCell() }

        if let trackTitle = tracks[indexPath.row].trackName {
            cell.configure(title: trackTitle)
        }
        return cell
    }
}

