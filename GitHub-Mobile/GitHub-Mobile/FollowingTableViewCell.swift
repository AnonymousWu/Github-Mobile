//
//  FollowingTableViewCell.swift
//  GitHub-Mobile
//
//  Created by WuXiaoxiao on 3/24/19.
//  Copyright © 2019 WuXiaoxiao. All rights reserved.
//

import UIKit

class FollowingTableViewCell: UITableViewCell {
    
    // MARK - Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    
    
    func setFollowingCell(following: User){
        nameLabel?.text = following.name
        avatarImage.image = following.image
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
