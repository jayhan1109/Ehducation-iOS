//
//  ViewController.swift
//  Ehducation
//
//  Created by Jeongho Han on 2021-05-30.
//

import UIKit
import DropDown
import Firebase

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
        subjectDropdown.dataSource = K.subjects
        
        subjectDropdown.selectionAction = { [unowned self] (index: Int, item: String) in
            subjectButton.setTitle(item, for: .normal)
        }
        subjectDropdown.backgroundColor = UIColor(named: K.Colors.pageBackgroundColor)
        subjectDropdown.textColor = UIColor(named: K.Colors.textPrimaryColor)!
        subjectDropdown.selectionBackgroundColor = UIColor(named: K.Colors.primaryColor)!
        
        
        gradeDropdown.anchorView = gradeButton
        gradeDropdown.dataSource = K.grades
        
        gradeDropdown.selectionAction = { [unowned self] (index: Int, item: String) in
            gradeButton.setTitle(item, for: .normal)
        }
        gradeDropdown.backgroundColor = UIColor(named: K.Colors.pageBackgroundColor)
        gradeDropdown.textColor = UIColor(named: K.Colors.textPrimaryColor)!
        gradeDropdown.selectionBackgroundColor = UIColor(named: K.Colors.primaryColor)!
        
        // Table View
        tableView.register(UINib.init(nibName: K.MainTableViewCell, bundle: nil), forCellReuseIdentifier: K.MainPageCellIdentifier)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchTextField.endEditing(true)
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
