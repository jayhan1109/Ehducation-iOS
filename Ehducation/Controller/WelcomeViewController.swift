//
//  AuthViewController.swift
//  Ehducation
//
//  Created by Jeongho Han on 2021-06-13.
//

import UIKit
import FirebaseUI

class WelcomeViewController: UIViewController, FUIAuthDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signInwithEmail(_ sender: UIButton) {
        
        let authUI = FUIAuth.defaultAuthUI()

        guard authUI != nil else {
            return
        }

        authUI?.delegate = self
        
        let providers: [FUIAuthProvider] = [FUIEmailAuth()]
        authUI!.providers = providers
        let authViewController = authUI!.authViewController()

        present(authViewController, animated: true, completion: nil)
    }
    
}
