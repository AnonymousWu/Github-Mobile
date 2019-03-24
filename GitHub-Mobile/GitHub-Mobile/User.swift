//
//  Following.swift
//  GitHub-Mobile
//
//  Created by WuXiaoxiao on 3/24/19.
//  Copyright © 2019 WuXiaoxiao. All rights reserved.
//

import Foundation
import UIKit

class User{
    
    var image : UIImage
    var name : String
    var url: String
    
    init(image: UIImage, name: String, url: String){
        self.image = image
        self.name = name
        self.url = url
    }
}
