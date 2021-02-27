//
//  CommentCell.swift
//  trash
//
//  Created by Ekrem Özkaraca on 22.11.2020.
//

import UIKit
import Firebase

class CommentCell: UITableViewCell {

    @IBOutlet weak var commentusernameText: UILabel!
    @IBOutlet weak var commentUserComment: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
