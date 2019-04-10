//
//  FollowerViewController.swift
//  GitHub-Mobile
//
//  Created by WuXiaoxiao on 3/9/19.
//  Copyright © 2019 WuXiaoxiao. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Firebase
import FirebaseDatabase

var followers : [User] = []

class FollowerViewController: UITableViewController {
    
    var follower_ref : DatabaseReference!

    
    @objc func onButtonClicked(_ sender: UIButton) {
        let todoEndpoint = "https://api.github.com/user/following/" + followers[sender.tag].name
        Alamofire.request(todoEndpoint, method: .put, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization": "token " + token]).responseJSON { response in
            print("Follow Success")
        }
       //sender.setTitle("unfollow", for: .normal)
    }
    
  
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        getFollowers()
        
        self.follower_ref = Database.database().reference()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func getFollowers(){
        followers = []
        
        Alamofire.request("https://api.github.com/users/"+username+"/followers").responseJSON { response in
            
            if response.result.isSuccess{
                print("Success! Got Followers")
                let followersJSON: JSON = JSON(response.result.value!)
                //print(followerJSON)
                self.updateFollowers(json: followersJSON)
            }
            else{
                print("ERROR \(String(describing: response.result.error))")
            }
            self.tableView.reloadData()
        }
    }
    
    func updateFollowers(json: JSON){
        for (_,dict) in json{
            
            let name = (dict["login"].rawString()!)
            //print(name)
            
            let avatar_url = dict["avatar_url"].rawString()!
            // read image
            let Aurl = URL(string: avatar_url)
            let data = try? Data(contentsOf: Aurl!)
            let image = UIImage(data: data!)!
            
            let url = dict["html_url"].rawString()!
            
            let follower = User(image: image, name: name, url: url)
            
            let ref = self.follower_ref.child("Followers")
            let follower_ref = ref.child(name)
            follower_ref.setValue(["name": name,
                                   "url": url])
            
            followers.append(follower)
        }
    }
    

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return followers.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let follower_cell = tableView.dequeueReusableCell(withIdentifier: "follower_cell", for: indexPath) as! FollowerTableViewCell
        //       print(follower_cell)

        let curr = followers[indexPath.row]
        //print(curr.name)
        follower_cell.setFollowerCell(follower: curr)
        
        let button = follower_cell.followButton
        button?.isUserInteractionEnabled = true
        button?.tag = indexPath.row
        button?.addTarget(self, action: #selector(onButtonClicked(_:)), for: .touchUpInside)

        return follower_cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

//        let url = self.followers[indexPath.row].url
//        if let url = URL(string: url){
//            UIApplication.shared.open(url)
//        }
        tableView.deselectRow(at: indexPath, animated: true)
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "0") as! UITabBarController
        self.present (vc, animated: true, completion: nil)
        username = followers[indexPath.row].name
        vc.selectedIndex = 0
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
}
