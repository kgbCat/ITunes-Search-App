//
//  LoginViewModel.swift
//  ITunes Search App
//
//  Created by Anna Delova on 6/13/22.
//

import UIKit

class LoginViewModel  {

    var appCoordinator = AppCoordinator()

    let coreData = CoreDataHelper()

    func validateUser(_ email:String, _ password: String) -> Bool {
        if coreData.getUser(email: email, password: password) != nil {
            return true
        }
        return false
    }

    func showAlert(controller: UIViewController, title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        controller.present(alertController, animated: true, completion: nil)
    }
}
