//
//  AppCoordinator.swift
//  ITunes Search App
//
//  Created by Anna Delova on 6/11/22.
//

import UIKit

class AppCoordinator: Coordinator {

    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    let storyboard  = UIStoryboard(name: "Main", bundle: nil)

    func start() {
//        onAlbumSearchScene()
        onTracksScene()
    }

    func onAlbumSearchScene() {
        guard let searchAlbumViewController = storyboard.instantiateViewController(withIdentifier: "SearchAlbumViewController") as? SearchAlbumViewController else { return }
        let searchAlbumViewModel = SearchAlbumViewModel()
        searchAlbumViewModel.appCoordinator = self
        searchAlbumViewController.viewModel = searchAlbumViewModel
        navigationController.pushViewController(searchAlbumViewController, animated: true)

    }

    func onTracksScene() {
        guard let albumTracksViewController = storyboard.instantiateViewController(withIdentifier: "AlbumTracksViewController") as? AlbumTracksViewController else { return }
        let albumTracksViewModel = AlbumTracksViewModel()
        albumTracksViewModel.appCoordinator = self
        albumTracksViewController.viewModel = albumTracksViewModel
        navigationController.pushViewController(albumTracksViewController, animated: true)
    }
}
