//
//  RoomsTableViewCell.swift
//  Club Chat
//
//  Created by Caner on 12.07.2021.
//

import UIKit

class RoomsTableViewCell: UITableViewCell {
    @IBOutlet weak var odaIsimLabel: UILabel!
    @IBOutlet weak var lockImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        

        // Configure the view for the selected state
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 10, bottom: 10, right: 10))
    }

}
