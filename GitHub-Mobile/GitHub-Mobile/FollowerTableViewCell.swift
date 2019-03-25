//
//  FollowerTableViewCell.swift
//  GitHub-Mobile
//
//  Created by WuXiaoxiao on 3/24/19.
//  Copyright © 2019 WuXiaoxiao. All rights reserved.
//

import UIKit

class FollowerTableViewCell: UITableViewCell {
    
    // MARK - Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    
    func setFollowerCell(follower: User){
        nameLabel?.text = follower.name
        avatarImage.image = follower.image
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
