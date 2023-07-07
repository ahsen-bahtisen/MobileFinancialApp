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
    
    private var viewModel: LoginViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = LoginViewModel()
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
                        strongSelf.navigateToHomePage()
                        print("You have signed in")
                     
                    }
                }
            }
            
            func showCreateAccount(email: String, password: String) {
                let alert = UIAlertController(title: "Create Account", message: "Would you like to create an account?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { _ in
                    let loginData = LoginModel(email: email, password: password)
                    
                    self.viewModel.createUser(with: loginData) { success, error in
                        if let error = error {
                            print("Account creation failed: \(error.localizedDescription)")
                            
                        } else {
                            self.navigateToHomePage()
                            print("Your account has been created. You have signed in")
  
                        }
                    }
                }))
                
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                
                present(alert, animated: true)
            }
            
            func navigateToHomePage() {
                // Ana sayfaya yönlendirme işlemleri
            }
        }
