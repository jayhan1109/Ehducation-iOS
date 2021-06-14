//
//  MyPageViewController.swift
//  Ehducation
//
//  Created by Jeongho Han on 2021-06-03.
//

import UIKit
import FirebaseUI

class MyPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func logoutPressed(_ sender: UIButton) {
        
        let authUI = FUIAuth.defaultAuthUI()
        
        do {
            try authUI?.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch {
            print(error)
        }
    }
    
}
