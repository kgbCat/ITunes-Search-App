//
//  RegisterViewController.swift
//  ITunes Search App
//
//  Created by Anna Delova on 6/11/22.
//

import UIKit

class RegisterViewController: UIViewController {

    var coordinator: AppCoordinator?
    var viewModel = RegisterViewModel()
    private var isAgeValid = false


    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var telNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton! {
        didSet {
            signUpButton.isEnabled = false
        }
    }
    @IBOutlet weak var datePicker: UIDatePicker! {
        didSet {
            datePicker.preferredDatePickerStyle = .compact
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        if let navigationController = navigationController {
              coordinator = AppCoordinator(navigationController: navigationController)
          }
        configureTextFields()
    }


    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        guard
            let email = emailTextField.text,
            let name = firstNameTextField.text,
            let lastName = lastNameTextField.text,
            let phone = telNumberTextField.text,
            let confirmedPassword = confirmPasswordTextField.text
        else {
            signUpButton.isEnabled = false
            return
        }
        viewModel.createNewUser(name, lastName, confirmedPassword, email, phone, datePicker.date)
        // navigate to login
        coordinator?.onLoginScene()
    }

    @IBAction func signInButtonTapped(_ sender: UIButton) {
        // navigate to login
        coordinator?.onLoginScene()
    }

    @IBAction func checkAgeTapped(_ sender: UIButton) {
        if !viewModel.validateAge(birthDate: datePicker.date) {
            viewModel.showAlert(controller: self, title: "Invalid Age", message: "You must be between 18 and 100 years old to rgister")
            isAgeValid = false
            signUpButton.isEnabled = false
        } else {
            isAgeValid = true
            viewModel.showAlert(controller: self, title: "Valid Age", message: "Ok, you can go ahead")
        }
    }


    private func configureTextFields() {
        [firstNameTextField, lastNameTextField, emailTextField, passwordTextField, confirmPasswordTextField, telNumberTextField ].forEach { [weak self] textField in
            guard let self = self else { return }
            textField?.delegate = self
            textField?.returnKeyType = .done
            textField?.autocorrectionType = .no
        }
        firstNameTextField?.autocapitalizationType = .words
        firstNameTextField.becomeFirstResponder()
        lastNameTextField?.autocapitalizationType = .words
    }

    private func isFilled() -> Bool {
        var isChecked = true
        [
            emailTextField.text,
            passwordTextField.text,
            firstNameTextField.text,
            lastNameTextField.text,
            telNumberTextField.text,
            confirmPasswordTextField.text,
        ].forEach { text in
            if text == "" {
                isChecked = false
            }
        }
         return isChecked
    }
}
extension RegisterViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case firstNameTextField:
            textField.keyboardType = UIKeyboardType.alphabet
        case lastNameTextField:
            textField.keyboardType = UIKeyboardType.alphabet
        case telNumberTextField:
            textField.text = textField.text?.applyPatternOnNumbers()
        case emailTextField:
            if let email = emailTextField.text {
                if !email.isValidEmail {
                    viewModel.showAlert(controller: self, title: "Invalid Email", message: "Please check your email")
                    emailTextField.text = ""
                }
            }
        case passwordTextField:
            if let password =  passwordTextField.text {
                if !password.isValidPassword {
                    viewModel.showAlert(controller: self, title: "Invalid Password", message: "Password should contain at least 6 alphabetic and numeric characters, at least 1 uppercased leter")
                    passwordTextField.text = ""
                }
            }
        case confirmPasswordTextField:
            if passwordTextField.text != confirmPasswordTextField.text {
                viewModel.showAlert(controller: self, title: "Invalid Password", message: "Confirmed password should be equal to password")
                confirmPasswordTextField.text = ""
            }
        default:
            return
        }
        if isFilled() && isAgeValid {
            signUpButton.isEnabled = true
        }
    }
}




