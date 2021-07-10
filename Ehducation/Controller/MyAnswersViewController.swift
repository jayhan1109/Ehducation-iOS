//
//  MyAnswersViewController.swift
//  Ehducation
//
//  Created by Jeongho Han on 2021-06-03.
//

import UIKit

class MyAnswersViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Table View
        tableView.register(UINib.init(nibName: K.CustomCell.MainTableViewCell, bundle: nil), forCellReuseIdentifier: K.Identifiers.MainPageCellIdentifier)
        
        tableView.backgroundColor = .clear
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource

extension MyAnswersViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return K.titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: K.Identifiers.MainPageCellIdentifier, for: indexPath) as? MainTableViewCell else {
            return UITableViewCell()
        }
        
        cell.titleLabel.text = K.titles[indexPath.row]
        cell.contentLabel.text = K.contents[indexPath.row]
        
        return cell
    }
}
