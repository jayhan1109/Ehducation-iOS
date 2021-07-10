//
//  AuthViewController.swift
//  Ehducation
//
//  Created by Jeongho Han on 2021-06-13.
//

import UIKit
import FirebaseUI

class WelcomeViewController: UIViewController{
    
    // MARK: - IBOutlet
    @IBOutlet weak var welcomeButton: UIButton!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide navigation bar
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        welcomeButton.layer.cornerRadius = welcomeButton.frame.height / 5
        
        // If the user already logged in, go to main page
        if let email = Auth.auth().currentUser?.email {
            FirebaseManager.shared.loadUser(email: email)
            performSegue(withIdentifier: K.Identifiers.welcomeToHomeIdentifier, sender: self)
        }
    }
    
    // MARK: - IBAction
    
    // Use FirebaseUI to authenticate user
    @IBAction func welcomePressed(_ sender: UIButton) {
        
        let authUI = FUIAuth.defaultAuthUI()

        guard authUI != nil else {
            return
        }

        authUI?.delegate = self
        
        let providers: [FUIAuthProvider] = [FUIEmailAuth()]
        authUI!.providers = providers
        let authViewController = authUI!.authViewController()
        authViewController.modalPresentationStyle = .fullScreen
        present(authViewController, animated: true, completion: nil)
    }

}

// MARK: - FUIAuthDelegate

extension WelcomeViewController: FUIAuthDelegate{
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        if error != nil {
            return
        }
        
        // Check if the user is new
        // new user -> Create User instance and save into DB
        // old user -> Load user info with email
        if let isNewUser = authDataResult?.additionalUserInfo?.isNewUser, let user = authDataResult?.user{
            
            if isNewUser{
                // Create User
                let user = User(id: user.uid, email: user.email!, exp: 0, answered: 0, starred: 0)
                
                // Save into Firebase and set it to FirebaseManager user variable
                FirebaseManager.shared.createUser(with: user)
                
            } else{
                // Load user from Firebase and set it to FirebaseManager user variable
                FirebaseManager.shared.loadUser(email: user.email!)
            }
        }
        
        performSegue(withIdentifier: K.Identifiers.welcomeToHomeIdentifier, sender: self)
    }
}
