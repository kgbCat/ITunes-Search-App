//
//  ViewController.swift
//  ITunes Search App
//
//  Created by Anna Delova on 6/11/22.
//

import UIKit

final class SearchAlbumViewController: UIViewController {
    var coordinator: AppCoordinator?
    var viewModel = SearchAlbumViewModel()

    private let networkService = NetworkService()
    private var albums = [Album]()
    private let cellId = String(describing: AlbumTableViewCell.self)

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.becomeFirstResponder()
            searchBar.delegate = self
            searchBar.backgroundColor = .clear
            searchBar.placeholder = "Search"
        }
    }
    @IBOutlet weak var tableView: UITableView! {
        didSet  {
            tableView.delegate = self
            tableView.dataSource = self

            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 200

            let nib = UINib(nibName: cellId, bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: cellId)
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        if let navigationController = navigationController {
              coordinator = AppCoordinator(navigationController: navigationController)
          }
        displayUsersData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndexPath, animated: animated)
        }
    }


    private func displayUsersData() {
        if let user = viewModel.getUsersInfo() {
            DispatchQueue.main.async {
                self.nameLabel.text = "\(user.name) \(user.lastName)"
                self.ageLabel.text = "age: \(user.age)"
                self.contactLabel.text = user.cellphone
                self.emailLabel.text = user.email
            }
        }
    }

    private func albumSearch(_ searchText: String) {
        networkService.searchMusicAlbums(search: searchText ) { [weak self] albums in
            guard self != nil,
                  albums != nil
            else { return }
            self?.albums = albums!

            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}
extension SearchAlbumViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        albums.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId,
                                                       for: indexPath) as? AlbumTableViewCell
        else { return UITableViewCell() }

        let album = albums[indexPath.row]

        cell.configure(imageURL: album.artworkUrl100, albumTitle: album.collectionName, artistTitle: album.artistName, tracksCount: album.trackCount)

        return cell
    }
}

extension SearchAlbumViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let album = albums[indexPath.row]

        coordinator?.onTracksScene(with: album.collectionId, album.collectionName, album.artistName, album.releaseDate, album.artworkUrl100)

        tableView.deselectRow(at: indexPath, animated: false)
    }
}
extension SearchAlbumViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        if searchText.isEmpty {
            albums.removeAll()
            tableView.reloadData()
        } else {
           albumSearch(searchText)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

}

