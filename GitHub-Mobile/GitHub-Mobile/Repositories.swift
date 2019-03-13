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
    
    init(repo_name: String, author: String, url: String, summary: String, language: String){
        self.repo_name = repo_name
        self.author = author
        self.url = url
        self.summary = summary
        self.language = language
    }
}

