//
//  ViewController.swift
//  Ehducation
//
//  Created by Jeongho Han on 2021-05-30.
//

import UIKit
import DropDown

class QuestionsController: UIViewController {
    @IBOutlet weak var newButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var subjectButton: UIButton!
    @IBOutlet weak var gradeButton: UIButton!
    
    
    let gradeDropdown = DropDown()
    let subjectDropdown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newButton.layer.cornerRadius = newButton.frame.height / 5
        subjectButton.layer.cornerRadius = subjectButton.frame.height / 5
        gradeButton.layer.cornerRadius = gradeButton.frame.height / 5
        
        
        
        subjectDropdown.anchorView = subjectButton
        subjectDropdown.dataSource = ["English", "Math", "Science"]
        
        gradeDropdown.anchorView = gradeButton
        gradeDropdown.dataSource = ["8", "9", "10"]
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
        print("search")
    }
    
    @IBAction func gradePressed(_ sender: UIButton) {
        gradeDropdown.show()
    }
    
    @IBAction func subjectPressed(_ sender: UIButton) {
        subjectDropdown.show()
    }
}

