//
//  ViewController.swift
//  MobileFinancialApp
//
//  Created by Ahsen Bahtışen on 7.07.2023.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var rememberMeSwitch: UISwitch!
    
    private var viewModel: LoginViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = LoginViewModel()
        loadRememberMeState()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resetEmailTextIfNeeded()
    }
    
    func navigateToHomePage() {
        performSegue(withIdentifier: "toHome", sender: self)
        passwordText.text = nil
        
    }
    
    private func loadRememberMeState() {
            let rememberMe = UserDefaults.standard.bool(forKey: "RememberMe")
            rememberMeSwitch.isOn = rememberMe
            
            if rememberMe {
                if let savedEmail = UserDefaults.standard.string(forKey: "SavedEmail") {
                    emailText.text = savedEmail
                }
                if let savedPassword = UserDefaults.standard.string(forKey: "SavedPassword") {
                    passwordText.text = savedPassword
                }
            }
        }
    
    private func resetEmailTextIfNeeded() {
           guard !rememberMeSwitch.isOn else {
               return
           }
        emailText.text = nil
                UserDefaults.standard.removeObject(forKey: "SavedEmail")
            }

    
    @IBAction func loginButton(_ sender: Any) {
        
       
        guard let email = emailText.text, !email.isEmpty,
              let password = passwordText.text, !password.isEmpty else {
            print("Missing field data")
            return
        }
        
        let loginData = LoginModel(email: email, password: password)
        
        viewModel.loginUser(with: loginData) { [weak self] success, error in
            guard let strongSelf = self else {
                return
            }
            
            if let error = error {
                strongSelf.showCreateAccount(email: email, password: password)
                print("Error: \(error.localizedDescription)")
            } else {
                
                print("You have signed in")
                strongSelf.navigateToHomePage()
                strongSelf.rememberUserCredentials()
                
            }
        }
    }
    
    private func rememberUserCredentials() {
        if rememberMeSwitch.isOn {
            UserDefaults.standard.set(true, forKey: "RememberMe")
            UserDefaults.standard.set(emailText.text, forKey: "SavedEmail")
            UserDefaults.standard.set(passwordText.text, forKey: "SavedPassword")
        } else {
            UserDefaults.standard.set(false, forKey: "RememberMe")
            UserDefaults.standard.removeObject(forKey: "SavedEmail")
            UserDefaults.standard.removeObject(forKey: "SavedPassword")
        }
    }
   
    @IBAction func forgetMeButton(_ sender: Any) {
        rememberMeSwitch.isOn = false
        rememberUserCredentials()
        resetEmailTextIfNeeded()
    }
    func showCreateAccount(email: String, password: String) {
        let alert = UIAlertController(title: "Create Account", message: "Would you like to create an account?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { _ in
            let loginData = LoginModel(email: email, password: password)
            
            self.viewModel.createUser(with: loginData) { success, error in
                if let error = error {
                    print("Account creation failed: \(error.localizedDescription)")
                    
                } else {
                    self.rememberUserCredentials()
                    self.navigateToHomePage()
                    print("Your account has been created. You have signed in")
                    
                }
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true)
    }
    

}
