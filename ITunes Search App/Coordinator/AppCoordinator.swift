//
//  AppCoordinator.swift
//  ITunes Search App
//
//  Created by Anna Delova on 6/11/22.
//

import UIKit

class AppCoordinator {

    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    let storyboard  = UIStoryboard(name: "Main", bundle: nil)

    func start() {
        onLoginScene()
    }
    
    func onLoginScene() {
        guard let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else { fatalError("Unable to Instantiate Login View Controller")
        }
        navigationController.pushViewController(loginViewController, animated: true)
    }

    func onRegisterScene() {
        guard let registerViewController = storyboard.instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController else { return }

        navigationController.pushViewController(registerViewController, animated: true)
    }

    func onAlbumSearchScene(with email: String) {
        guard let searchAlbumViewController = storyboard.instantiateViewController(withIdentifier: "SearchAlbumViewController") as? SearchAlbumViewController else { return }
        searchAlbumViewController.viewModel.email = email
        navigationController.pushViewController(searchAlbumViewController, animated: true)
    }

    func onTracksScene(with id: Int,
                       _ albumTitle: String,
                       _ groupTitle: String,
                       _ date: String,
                       _ imageUrl: String ) {
        guard let albumTracksViewController = storyboard.instantiateViewController(withIdentifier: "AlbumTracksViewController") as? AlbumTracksViewController else { return }
        albumTracksViewController.albumId = id
        albumTracksViewController.albumTitle = albumTitle
        albumTracksViewController.groupTitle = groupTitle
        albumTracksViewController.date = date
        albumTracksViewController.image = imageUrl
        navigationController.pushViewController(albumTracksViewController, animated: true)
    }
}
