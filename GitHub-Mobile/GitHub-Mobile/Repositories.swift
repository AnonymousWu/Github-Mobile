//
//  Repositories.swift
//  GitHub-Mobile
//
//  Created by WuXiaoxiao on 3/10/19.
//  Copyright © 2019 WuXiaoxiao. All rights reserved.
//

import Foundation
import UIKit

class Repositories{
    
    var repo_name: String
    var author: String
    var url: String
    var summary: String
    var language: String
    var icon: UIImage
    
    init(repo_name: String, author: String, summary: String, language: String, icon: UIImage){
        self.repo_name = repo_name
        self.author = author
        self.url = ""
        self.summary = summary
        self.language = language
        self.icon = icon
    }
}

