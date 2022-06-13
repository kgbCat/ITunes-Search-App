//
//  RegisterViewModel.swift
//  ITunes Search App
//
//  Created by Anna Delova on 6/11/22.
//

import UIKit

class RegisterViewModel {
    
    private let coreData = CoreDataHelper()

    func createNewUser(_ name: String, _ lastName: String, _ password: String,
                       _ email: String, _ phone:  String, _ birthDate: Date ) {

        let age = Calendar.current.dateComponents([.year], from: birthDate, to: Date()).year!

        coreData.createUser(name: name, lastName: lastName, email: email, password: password, cellphone: phone, age: String(age))
    }

    func validateAge(birthDate: Date) -> Bool {
        // Age of 18.
        let minAge: Date = Calendar.current.date(byAdding: .year, value: -18, to: Date())!
        // Age of 100.
        let maxAge: Date = Calendar.current.date(byAdding: .year, value: -100, to: Date())!

        var isValid: Bool = true

        if birthDate < maxAge || birthDate > minAge{
            isValid = false
        }
        return isValid;
    }

    func showAlert(controller: UIViewController, title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        controller.present(alertController, animated: true, completion: nil)
    }
    
}
