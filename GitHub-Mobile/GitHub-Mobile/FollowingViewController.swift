//
//  FollowingViewController.swift
//  GitHub-Mobile
//
//  Created by WuXiaoxiao on 3/8/19.
//  Copyright © 2019 WuXiaoxiao. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FollowingViewController: UITableViewController {
    
    var access_token = "0f61ac41c59e710e19166c66c06183c4b4daed51"
    var following : [User] = []

    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.tableView.delegate = self
        self.tableView.dataSource = self
        getFollowing()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func getFollowing(){
        
        self.following = []
        
        Alamofire.request("https://api.github.com/users/AnonymousWu/following").responseJSON { response in
            
            if response.result.isSuccess{
                print("Success! Got Following")
                let followingJSON: JSON = JSON(response.result.value!)
                //print(followingJSON)
                self.updateFollowing(json: followingJSON)
            }
            else{
                print("ERROR \(String(describing: response.result.error))")
            }
            self.tableView.reloadData()
        }
        
        
    }
    
    func updateFollowing(json: JSON){
        for (_,dict) in json{
            
            let name = (dict["login"].rawString()!)
            //print(name)

            let avatar_url = dict["avatar_url"].rawString()!
            // read image
            let Aurl = URL(string: avatar_url)
            let data = try? Data(contentsOf: Aurl!)
            let image = UIImage(data: data!)!
            
            let url = dict["html_url"].rawString()!
            
            let follow = User(image: image, name: name, url: url)
            self.following.append(follow)
        }
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.following.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let following_cell = tableView.dequeueReusableCell(withIdentifier: "following_cell", for: indexPath) as! FollowingTableViewCell
        //       print(following_cell)

        let curr = self.following[indexPath.row]
        following_cell.setFollowingCell(following: curr)

        return following_cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let url = self.following[indexPath.row].url
        if let url = URL(string: url){
            UIApplication.shared.open(url)
        }
        tableView.deselectRow(at: indexPath, animated: true)
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
