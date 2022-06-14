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
    private let networkService = NetworkService()

    private let cellId = String(describing: TrackTableViewCell.self)
    private var tracks = [Track]()


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
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getTracks(with: viewModel.id)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        displayAlbumInfo()
    }

    func getTracks(with id: Int) {
        networkService.getAlbumTracks(albumId: id) { [weak self] tracks in
            guard self != nil,
                  tracks != nil
            else { return }
            self?.tracks = tracks!
//            tracks!.forEach({ track in
//                if track.trackName != nil {
//                    filteredTracks.append(track)
//                }
//            })
        }
    }

//    private func getTracks() {
//        if let loadedTracks = viewModel.getTracks() {
//            print(loadedTracks)
//            self.tracks = loadedTracks
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
//    }

    private func displayAlbumInfo() {
        DispatchQueue.main.async {
            self.albumTitleLabel.text = self.viewModel.albumTitle
            self.GroupTitleLabel.text = self.viewModel.groupTitle
            self.releaseLabel.text = "release date: \(self.viewModel.date)"
            if let url = URL(string: self.viewModel.image){
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

