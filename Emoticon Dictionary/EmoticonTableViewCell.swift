//
//  EmoticonTableViewCell.swift
//  Emoticon Dictionary
//
//  Created by Juliana Nielson on 3/9/23.
//

import UIKit

class EmoticonTableViewCell: UITableViewCell {

    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    private func updateView() {
        guard let emoticon else { return }
        
        symbolLabel.text = emoticon.symbol
        nameLabel.text = emoticon.name
        descriptionLabel.text = emoticon.description
        
        
    }
    
    var emoticon: Emoticon? {
        didSet {
            updateView()
        }
    }
    
}
