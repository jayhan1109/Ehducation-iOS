//
//  MyQuestionsViewController.swift
//  Ehducation
//
//  Created by Jeongho Han on 2021-06-03.
//

import UIKit

class MyQuestionsViewController: UIViewController {
    
    // MARK: - IBOutlet

    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FirebaseManager.shared.delegate = self
        FirebaseManager.shared.getMyQuestions()

        // Configure Table View
        tableView.register(UINib.init(nibName: K.CustomCell.MainTableViewCell, bundle: nil), forCellReuseIdentifier: K.Identifiers.MainPageCellIdentifier)
        
        tableView.backgroundColor = .clear
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource

extension MyQuestionsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FirebaseManager.shared.myQuestions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: K.Identifiers.MainPageCellIdentifier, for: indexPath) as? MainTableViewCell else {
            return UITableViewCell()
        }
        
        cell.titleLabel.text = FirebaseManager.shared.myQuestions[indexPath.row].title
        cell.contentLabel.text = FirebaseManager.shared.myQuestions[indexPath.row].text
        cell.countLabel.text = String(FirebaseManager.shared.myQuestions[indexPath.row].answerCount)
        
        return cell
    }
}

// MARK: - FirebaseManagerDelegate

extension MyQuestionsViewController: FirebaseManagerDelegate{
    func updateUI() {
        tableView.reloadData()
    }
}
