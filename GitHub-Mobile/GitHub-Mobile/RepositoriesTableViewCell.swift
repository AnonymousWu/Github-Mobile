//
//  RepositoriesTableViewCell.swift
//  GitHub-Mobile
//
//  Created by WuXiaoxiao on 3/12/19.
//  Copyright © 2019 WuXiaoxiao. All rights reserved.
//

import UIKit

class RepositoriesTableViewCell: UITableViewCell {
    
    // MARK - Properties
    
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    func setRepoCell(repo : Repositories){
        
        repoNameLabel?.text = repo.repo_name
        summaryLabel?.text = repo.summary
        languageLabel?.text = repo.language
        authorLabel?.text = repo.author
    
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
