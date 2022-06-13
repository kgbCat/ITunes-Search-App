//
//  SearchAlbumViewModel.swift
//  ITunes Search App
//
//  Created by Anna Delova on 6/11/22.
//

import UIKit

class SearchAlbumViewModel {
    
    let coreData = CoreDataHelper()
    var email = ""

    func getUsersInfo() -> User? {

        if let user = coreData.getCheckedUsersData(email: email) {
            return user
        } else {
            return nil
        }
    }

}
