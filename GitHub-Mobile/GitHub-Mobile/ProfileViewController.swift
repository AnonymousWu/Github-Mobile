//
// ProfileViewController.swift
//  GitHub-Mobile
//
//  Created by WuXiaoxiao on 3/8/19.
//  Copyright © 2019 WuXiaoxiao. All rights reserved.
//

import UIKit
import Alamofire
import OAuthSwift
import Kingfisher

var username = "AnonymousWu"

class ProfileViewController: UIViewController {
    
    // MARK - Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet var ReposCountLabel: UILabel!
    @IBAction func ReposButton(_ sender: UIButton) {
        tabBarController!.selectedIndex = 1
    }
    @IBOutlet var FollowerCountLabel: UILabel!
    @IBAction func FollowersButton(_ sender: UIButton) {
        tabBarController!.selectedIndex = 3
    }
    @IBOutlet var FollowingCountLabel: UILabel!
    @IBAction func FollowingButton(_ sender: UIButton) {
        tabBarController!.selectedIndex = 2
    }
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var profileCreateDateLabel: UILabel!
    
//    var access_token = "0f61ac41c59e710e19166c66c06183c4b4daed51"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        logIn()
    }
    
    
    func logIn(){
        
        Alamofire.request("https://api.github.com/users/" + username).responseJSON { response in
        //Alamofire.request("https://api.github.com/user?access_token=" + access_token).responseJSON { response in
            //print(response)
            if let dict = response.result.value as? [String: Any] {
                //print(dict)
                
                // name
                self.nameLabel.text = ((dict["name"] is NSNull || dict["name"] == nil ? "" : dict["name"]!) as! String)
                
                // username
                self.usernameLabel.text = ((dict["login"] is NSNull || dict["login"] == nil ? "" : dict["login"]!) as! String)
                
                // avatar
                let avatar_url = (dict["avatar_url"] is NSNull || dict["avatar_url"] == nil ? "" : dict["avatar_url"]!) as! String
                let avatarURL = URL(string: avatar_url)
                let data = try? Data(contentsOf: avatarURL!)
                if let imageData = data {
                    let image = UIImage(data: imageData)
                    self.avatarImage.image = image
                    self.avatarImage.layer.borderWidth = 1
                    self.avatarImage.layer.masksToBounds = false
                    self.avatarImage.layer.borderColor = UIColor.black.cgColor
                    self.avatarImage.layer.cornerRadius = self.avatarImage.frame.height/2
                    self.avatarImage.clipsToBounds = true
                }
                
                // Number of Repositories
                self.ReposCountLabel.text = ((dict["public_repos"] is NSNull || dict["public_repos"] == nil ? "" : "\(String(describing: dict["public_repos"]!))"))
                
                // Numbert of Followers
                self.FollowerCountLabel.text = ((dict["followers"] is NSNull || dict["followers"] == nil ? "" : "\(String(describing: dict["followers"]!))"))
                
                
                self.FollowingCountLabel.text = ((dict["following"] is NSNull || dict["following"] == nil ? "" : "\(String(describing: dict["following"]!))"))

                // bio
                self.bioLabel.text = ((dict["bio"] is NSNull || dict["bio"] is NSNull || dict["bio"] == nil ? "" : dict["bio"]!) as! String)
                
                // email
                print(dict)
                self.emailLabel.text = ((dict["email"] is NSNull || dict["email"] == nil ? "" : dict["email"]!) as! String)
                
                // website
                self.websiteLabel.text = ((dict["blog"] is NSNull || dict["blog"] == nil ? "" : dict["blog"]!) as! String)
                
                // profile create date
                self.profileCreateDateLabel.text = (dict["create_at"] is NSNull  || dict["created_at"] == nil ? "" : String((dict["created_at"]! as! String).dropLast(10)))
                
            }
        }
    }


}
