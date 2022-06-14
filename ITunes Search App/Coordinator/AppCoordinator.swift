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

    let storyboard  = Constants.main

    func start() {
        onLoginScene()
    }
    
    func onLoginScene() {
        guard let loginViewController = storyboard.instantiateViewController(withIdentifier: Constants.loginViewController) as? LoginViewController else { fatalError(AppCoordinatorError.loginSceneError.rawValue)
        }
        navigationController.pushViewController(loginViewController, animated: true)
    }

    func onRegisterScene() {
        guard let registerViewController = storyboard.instantiateViewController(withIdentifier: Constants.registerViewController) as? RegisterViewController else {  fatalError(AppCoordinatorError.registerSceneError.rawValue) }

        navigationController.pushViewController(registerViewController, animated: true)
    }

    func onAlbumSearchScene(with email: String) {
        guard let searchAlbumViewController = storyboard.instantiateViewController(withIdentifier: Constants.searchAlbumViewController) as? SearchAlbumViewController else {  fatalError(AppCoordinatorError.albumSearchSceneError.rawValue) }
        searchAlbumViewController.viewModel.email = email
        navigationController.pushViewController(searchAlbumViewController, animated: true)
    }

    func onTracksScene(with id: Int,
                       _ albumTitle: String,
                       _ groupTitle: String,
                       _ date: String,
                       _ imageUrl: String ) {
        guard let albumTracksViewController = storyboard.instantiateViewController(withIdentifier: Constants.albumTracksViewController) as? AlbumTracksViewController else {  fatalError(AppCoordinatorError.trackSceneError.rawValue) }
        
        albumTracksViewController.viewModel.id = id
        albumTracksViewController.viewModel.getAlbumsData(albumTitle: albumTitle, groupTitle: groupTitle, date: date, imageUrl: imageUrl)
        
        navigationController.pushViewController(albumTracksViewController, animated: true)
    }
}
