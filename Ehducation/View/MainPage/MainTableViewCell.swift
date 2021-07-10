//
//  MainTableViewCell.swift
//  Ehducation
//
//  Created by Jeongho Han on 2021-06-03.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    // Give some padding inside the view
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
    
}
