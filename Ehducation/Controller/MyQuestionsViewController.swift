//
//  MyQuestionsViewController.swift
//  Ehducation
//
//  Created by Jeongho Han on 2021-06-03.
//

import UIKit

class MyQuestionsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FirebaseManager.shared.delegate = self

        // Table View
        tableView.register(UINib.init(nibName: K.MainTableViewCell, bundle: nil), forCellReuseIdentifier: K.MainPageCellIdentifier)
        
        tableView.backgroundColor = .clear
        
        FirebaseManager.shared.getMyQuestions()
    }
}

extension MyQuestionsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FirebaseManager.shared.myQuestions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: K.MainPageCellIdentifier, for: indexPath) as? MainTableViewCell else {
            return UITableViewCell()
        }
        
        cell.titleLabel.text = FirebaseManager.shared.myQuestions[indexPath.row].title
        cell.contentLabel.text = FirebaseManager.shared.myQuestions[indexPath.row].text
        cell.countLabel.text = String(FirebaseManager.shared.myQuestions[indexPath.row].answerCount)
        
        return cell
    }
}

extension MyQuestionsViewController: FirebaseManagerDelegate{
    func updateUI() {
        tableView.reloadData()
    }
}
