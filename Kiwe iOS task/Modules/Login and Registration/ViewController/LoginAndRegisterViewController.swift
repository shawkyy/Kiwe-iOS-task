//
//  LoginAndRegisterViewController.swift
//  Kiwe iOS task
//
//  Created by Abdalla Shawky on 10/6/20.
//  Copyright © 2020 Abdalla Shawky. All rights reserved.
//

import UIKit
import RxSwift
import PKHUD

private enum ScreenSelection {
    case Login
    case Register
}

class LoginAndRegisterViewController: UIViewController {
    
    //MARK:- login phase
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginSeparator: UIView!
    @IBOutlet weak var registerSeparator: UIView!
    @IBOutlet weak var registerParentView: UIView!
    @IBOutlet weak var loginButtonOutlet: UIButton!
    
    //MARK:- register phase
    @IBOutlet weak var registerButtonOutlet: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UILabel!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var registerEmailTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    
    
    private let viewModel = LoginViewModel()
    private let disposeBag = DisposeBag()
    private var screenSelection: ScreenSelection = .Login {
        didSet {
            handleScreenSelection()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButtonOutlet.layer.cornerRadius = loginButtonOutlet.bounds.height / 2
        registerButtonOutlet.layer.cornerRadius = registerButtonOutlet.bounds.height / 2
        ageTextField.delegate = self
        handleScreenSelection()
    }
    
    private func setSubscribers(){
        viewModel.loginBehaviorSubject.subscribe(onNext: { screenState in
            self.handleLoginScreenState(state: screenState)
        }).disposed(by: disposeBag)
    }
    
    private func handleLoginScreenState(state: LoginScreenState){
        switch state {
        case .Failure:
            let alert = UIAlertController(title: "", message: "invalid user credentials", preferredStyle: .alert)
            alert.addAction(.init(title: "Ok", style: .cancel, handler: nil ))
            HUD.hide()
            present(alert, animated: true, completion: nil)
        case .Loading:
            HUD.show(.progress)
        case .Success(email: let email):
            viewModel.saveUserEmail(email: email)
            navigateToHome()
        }
    }
    
    private func navigateToHome(){
        let homeViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MainNavigationController")
        UIApplication.shared.keyWindow?.rootViewController = homeViewController
    }
    private func handleScreenSelection(){
        switch screenSelection {
        case .Login:
            registerParentView.isHidden = true
            registerSeparator.backgroundColor = .clear
            loginSeparator.backgroundColor = .darkGray
        case .Register:
            registerParentView.isHidden = false
            registerSeparator.backgroundColor = .darkGray
            loginSeparator.backgroundColor = .clear
        }
    }
    
    @IBAction func loginButtonDidTap(_ sender: Any) {
        screenSelection = .Login
    }
    
    @IBAction func registerNewAccountButtonDidTap(_ sender: Any) {
        screenSelection = .Register
    }
    
    @IBAction func signInButtonDidTap(_ sender: Any) {
        guard let email = self.emailTextField.text, let password = self.passwordTextField.text else {return}
        setSubscribers()
        viewModel.login(email:email , password: password)
    }
    
    @IBAction func registerButtonDidTap(_ sender: Any) {
        guard let name = nameTextField.text,
            let password = newPasswordTextField.text, !password.isEmpty,
            let age = ageTextField.text, !age.isEmpty,
            let email = registerEmailTextField.text, !email.isEmpty
            else {return}
        viewModel.registerUser(userName: name, password: password, age: age, email: email)
        viewModel.saveUserEmail(email:email)
        navigateToHome()
    }
}

extension LoginAndRegisterViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        let age = Int(textField.text ?? "") ?? 0
        if textField == ageTextField{
            if age < 18 {
                let alert = UIAlertController(title: "Sorry", message: "age should be above 18", preferredStyle: .alert)
                alert.addAction(.init(title: "Ok", style: .cancel, handler: nil ))
                present(alert, animated: true, completion: nil)
            }
        }
    }
}
