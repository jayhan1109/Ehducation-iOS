//
//  AuthViewController.swift
//  Ehducation
//
//  Created by Jeongho Han on 2021-06-13.
//

import UIKit
import FirebaseUI

class WelcomeViewController: UIViewController{
    @IBOutlet weak var welcomeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        welcomeButton.layer.cornerRadius = welcomeButton.frame.height / 5
    }
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

extension WelcomeViewController: FUIAuthDelegate{
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        if error != nil {
            return
        }
        
        // Check if the user is new
        if let user = authDataResult?.user{
            
            // Create User data and save into firebase
            print(user.email)
            print(user.uid)
            print(authDataResult?.additionalUserInfo?.isNewUser)
        } else{
            // load user data
        }
        
        performSegue(withIdentifier: "goToHome", sender: self)
    }
}
