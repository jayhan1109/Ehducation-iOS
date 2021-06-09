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
    @IBOutlet weak var tableView: UITableView!
    
    
    
    let gradeDropdown = DropDown()
    let subjectDropdown = DropDown()
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newButton.layer.cornerRadius = newButton.frame.height / 5
        subjectButton.layer.cornerRadius = subjectButton.frame.height / 5
        gradeButton.layer.cornerRadius = gradeButton.frame.height / 5
        
        
        
        subjectDropdown.anchorView = subjectButton
        subjectDropdown.dataSource = ["English", "Math", "Science"]
        
        gradeDropdown.anchorView = gradeButton
        gradeDropdown.dataSource = ["8", "9", "10"]
        
        // Table View
        tableView.register(UINib.init(nibName: K.MainTableViewCell, bundle: nil), forCellReuseIdentifier: K.MainPageCellIdentifier)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
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


extension QuestionsController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return K.titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: K.MainPageCellIdentifier, for: indexPath) as? MainTableViewCell else {
            return UITableViewCell()
        }
        
        cell.titleLabel.text = K.titles[indexPath.row]
        cell.contentLabel.text = K.contents[indexPath.row]
        
        return cell
    }
}
