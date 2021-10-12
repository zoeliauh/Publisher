//
//  ArtitleTableViewCell.swift
//  Publisher
//
//  Created by woanjwu liauh on 2021/10/12.
//

import UIKit

class ArtitleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var articleTitleLabel: UILabel!
    
    @IBOutlet weak var authorNameLabel: UILabel!
    
    @IBOutlet weak var createdTimeLabel: UILabel!
    
    @IBOutlet weak var artitleContentTextView: UITextView!
    
    @IBOutlet weak var catagoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
}
