//
//  LoginViewModel.swift
//  MobileFinancialApp
//
//  Created by Ahsen Bahtışen on 7.07.2023.
//

import Foundation
import FirebaseAuth

class LoginViewModel {
    
    func loginUser(with loginData: LoginModel, completion: @escaping (Bool, Error?) -> Void) {
        FirebaseAuth.Auth.auth().signIn(withEmail: loginData.email, password: loginData.password) { (result, error) in
            if let error = error {
                completion(false, error)
            } else {
                completion(true, nil)
            }
        }
    }
    
    func createUser(with loginData: LoginModel, completion: @escaping (Bool, Error?) -> Void) {
        FirebaseAuth.Auth.auth().createUser(withEmail: loginData.email, password: loginData.password) { (result, error) in
            if let error = error {
                completion(false, error)
            } else {
                completion(true, nil)
            }
        }
    }
}
