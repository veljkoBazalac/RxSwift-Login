//
//  LoginViewController.swift
//  RxSwift
//
//  Created by VELJKO on 2.11.22..
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {

    private let loginViewModel = LoginViewModel()
    private let bag = DisposeBag()
    
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 8
        userNameTF.becomeFirstResponder()
        
        userNameTF.rx.text.map { $0 ?? ""}.bind(to: loginViewModel.usernameText).disposed(by: bag)
        passwordTF.rx.text.map { $0 ?? ""}.bind(to: loginViewModel.passwordText).disposed(by: bag)
        
        loginViewModel.isValid().bind(to: loginButton.rx.isEnabled).disposed(by: bag)
        loginViewModel.isValid().map { $0 ? 1 : 0.5 }.bind(to: loginButton.rx.alpha).disposed(by: bag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loginButton.layer.cornerRadius = 10
    }

    @IBAction func loginButtonPressed(_ sender: UIButton) {
        view.endEditing(true)
        performSegue(withIdentifier: "loginSegue", sender: self)
    }
}
