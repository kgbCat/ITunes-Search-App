//
//  AppCoordinator.swift
//  ITunes Search App
//
//  Created by Anna Delova on 6/11/22.
//

import UIKit

class AppCoordinator {

    private let navigationController = UINavigationController()

    var rootViewController: UIViewController {
         return navigationController
     }

    let storyboard  = UIStoryboard(name: "Main", bundle: nil)

    func start() {
        onLoginScene()
    }
    func onLoginScene() {
        guard let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else { fatalError("Unable to Instantiate Login View Controller")
        }
        let loginViewModel = LoginViewModel()
        loginViewModel.appCoordinator = self
        loginViewController.viewModel = loginViewModel
        navigationController.pushViewController(loginViewController, animated: true)
    }

    func onRegisterScene() {
        guard let registerViewController = storyboard.instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController else { return }
        let registerViewModel = RegisterViewModel()
        registerViewModel.appCoordinator = self
        registerViewController.viewModel = registerViewModel
        navigationController.pushViewController(registerViewController, animated: true)
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
