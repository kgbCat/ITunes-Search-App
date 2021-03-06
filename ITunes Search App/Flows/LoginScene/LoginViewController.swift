//
//  LoginViewController.swift
//  ITunes Search App
//
//  Created by Anna Delova on 6/13/22.
//

import UIKit

class LoginViewController: UIViewController {


    var viewModel = LoginViewModel()
    var coordinator: AppCoordinator?

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let navigationController = navigationController {
              coordinator = AppCoordinator(navigationController: navigationController)
          }
        configureTextFields()
    }

    @IBAction func signUpTapped(_ sender: Any) {
        // navigate to  register  scene
        coordinator?.onRegisterScene()
    }

    @IBAction func signInTapped(_ sender: Any) {
        guard let email = emailTextField.text,
              let password =  passwordTextField.text
        else { return }
        if viewModel.validateUser(email, password) {
            // navigate further
            coordinator?.onAlbumSearchScene(with: email)
        } else {
            viewModel.showAlert(controller: self, title: "Wrong credentials", message: "Please try again")
        }
    }

    private func configureTextFields() {
        [emailTextField, passwordTextField ].forEach { [weak self] textField in
            guard let self = self else { return }
            textField?.delegate = self
            textField?.returnKeyType = .done
            textField?.autocorrectionType = .no
        }
    }
}
extension LoginViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
