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
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var newButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var subjectButton: UIButton!
    @IBOutlet weak var gradeButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    let gradeDropdown = DropDown()
    let subjectDropdown = DropDown()
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FirebaseManager.shared.delegate = self
        FirebaseManager.shared.getAllQuestions()
        
        newButton.layer.cornerRadius = newButton.frame.height / 5
        
        configureDropdown()
        
        // Configure Table View
        tableView.register(UINib.init(nibName: K.CustomCell.MainTableViewCell, bundle: nil), forCellReuseIdentifier: K.Identifiers.MainPageCellIdentifier)
        
        tableView.backgroundColor = .clear
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    // Dismiss keyboard when touch outside of textView and textField
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchTextField.endEditing(true)
    }
    
    // MARK: - Helpers
    
    // Configure subject and grade dropdown
    func configureDropdown(){
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
    }
    
    // MARK: - IBAction
    
    // TODO: Parse data with keyword, grade and subject
    @IBAction func searchPressed(_ sender: UIButton) {
        print("search")
    }
    
    // Show grade dropdown
    @IBAction func gradePressed(_ sender: UIButton) {
        gradeDropdown.show()
    }
    
    // Show subject dropdown
    @IBAction func subjectPressed(_ sender: UIButton) {
        subjectDropdown.show()
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource

extension QuestionsController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FirebaseManager.shared.allQuestion.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: K.Identifiers.MainPageCellIdentifier, for: indexPath) as? MainTableViewCell else {
            return UITableViewCell()
        }
        
        cell.titleLabel.text = FirebaseManager.shared.allQuestion[indexPath.row].title
        cell.contentLabel.text = FirebaseManager.shared.allQuestion[indexPath.row].text
        cell.countLabel.text = String(FirebaseManager.shared.allQuestion[indexPath.row].answerCount)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: K.Identifiers.homeToPostIdentifier, sender: indexPath)
    }
}

// MARK: - FirebaseManagerDelegate

extension QuestionsController: FirebaseManagerDelegate{
    func updateUI() {
        tableView.reloadData()
    }
}
