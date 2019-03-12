//
//  RepositoriesCell.swift
//  GitHub-Mobile
//
//  Created by WuXiaoxiao on 3/10/19.
//  Copyright © 2019 WuXiaoxiao. All rights reserved.
//

import UIKit

class RepositoriesCell: UITableViewCell {
    
    // MARK: - IBOutlets: connected to scene using the storyboar
    @IBOutlet weak var repo_nameLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    // MARK: - Properties
    func initRepositoriesCell(repositories: Repositories) {
    
        repo_nameLabel.text = repositories.repo_name
        authorLabel.text = repositories.author
        summaryLabel.text = repositories.summary
        languageLabel.text = repositories.summary
        iconImageView.image = repositories.icon
        
        
        
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
