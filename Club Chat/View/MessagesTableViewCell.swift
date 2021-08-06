//
//  MessagesTableViewCell.swift
//  Club Chat
//
//  Created by Caner on 13.07.2021.
//

import UIKit
import PaddingLabel
class MessagesTableViewCell: UITableViewCell{
    @IBOutlet weak var messageLabel: PaddingLabel!
    @IBOutlet weak var senderLabel: PaddingLabel!
    @IBOutlet weak var stackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
