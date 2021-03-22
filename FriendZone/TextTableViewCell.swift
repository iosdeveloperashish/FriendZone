//
//  TextTableViewCell.swift
//  FriendZone
//
//  Created by Ashish Viltoriya on 03/03/21.
//

import UIKit

class TextTableViewCell: UITableViewCell {

    @IBOutlet weak var textField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
