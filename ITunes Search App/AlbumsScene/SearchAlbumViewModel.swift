//
//  SearchAlbumViewModel.swift
//  ITunes Search App
//
//  Created by Anna Delova on 6/11/22.
//

import UIKit

class SearchAlbumViewModel {
    weak var appCoordinator: AppCoordinator?
    let coreData = CoreDataHelper()

//    func onTracksList() {
//        appCoordinator?.onTracksScene()
//    }

    func getUsersInfo() -> User? {
        if let user = coreData.getUser(email: "delova.anna@mail.ru", password: "Qwertyt1") {
            return user
        } else {
            return nil
        }
    }

}
