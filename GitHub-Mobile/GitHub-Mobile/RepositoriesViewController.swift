//
//  RepositoriesViewController.swift
//  GitHub-Mobile
//
//  Created by WuXiaoxiao on 3/10/19.
//  Copyright © 2019 WuXiaoxiao. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class RepositoriesViewController: UITableViewController {
    
    var repos : [Repositories] = []
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.register(RepositoriesTableViewCell.self, forCellReuseIdentifier: "repo_cell")
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        getRepos()
    

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func getRepos(){
        
        self.repos=[]
        
        Alamofire.request("https://api.github.com/users/"+username+"/repos").responseJSON { response in
            //print(response)
            
            if response.result.isSuccess{
                print("Success! Got Repositories")
                let repoJSON: JSON = JSON(response.result.value!)
                //print(repoJSON)
                self.updateRepo(json: repoJSON)
            }
            else{
                print("ERROR \(String(describing: response.result.error))")
            }
            self.tableView.reloadData()
            }
        
    }
    
    func updateRepo(json: JSON){
        for (_,dict) in json{
            
            
            //let repo_name = dict["name"].rawString()!
            let repo_name = (dict["name"].rawString()!)
            //print(repo_name)
            let author_dict = dict["owner"]
            let author = author_dict["login"].rawString()!
            let url = dict["html_url"].rawString()!
            let summary = dict["description"].rawString()!
            let language = dict["language"].rawString()!
            
            let repo = Repositories(repo_name: repo_name, author: author, url: url, summary: summary, language: language)
            
            self.repos.append(repo)
        }
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.repos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let repo_cell = tableView.dequeueReusableCell(withIdentifier: "repo_cell", for: indexPath) as! RepositoriesTableViewCell
 //       print(repo_cell)
        
        //var repo: Repositories
        let curr = self.repos[indexPath.row]
        //print(repo)
        //repo_cell.repoNameLabel?.text = repo.repo_name
        repo_cell.setRepoCell(repo: curr)

        return repo_cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let url = self.repos[indexPath.row].url
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
