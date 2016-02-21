//
//  ReportViewV.swift
//  InformME
//
//  Created by Amal Ibrahim on 2/19/16.
//  Copyright © 2016 King Saud University. All rights reserved.
//

import Foundation
import UIKit

class ReportViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var contents:[Content] = []
    var report: Report = Report()
    var event: Event = Event()
    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        self.event.id = 1
        self.viewReport(event)
        print("I am Back")
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.reloadData();
    }
    // MARK: --- Table Functions ---
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("contentReportCell", forIndexPath: indexPath) as! ContentReportTableViewCellController
        let name = self.contents[indexPath.row].Title
        cell.name.text = name as String
        let likes = self.contents[indexPath.row].likes.counter
        cell.likes.text = String(likes)
        let dislikes = self.contents[indexPath.row].dislikes.counter
        cell.dislikes.text = String(dislikes)
        let comments = self.contents[indexPath.row].comments
        cell.comments = comments
        cell.commentsNo.text = String(comments.count)
        cell.commentsTable.delegate = cell;
        cell.commentsTable.dataSource = cell;
        return cell
        
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: this number should be changed to the actual number of recieved events.
        //return values.count;
        return contents.count;
    }
    
    func viewReport(event: Event){
        var contents: [Content] = []
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://bemyeyes.co/API/viwereport.php")!)
        request.HTTPMethod = "POST"
        let postString = "uid=\(event.id)"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if let urlContent = data {
                
                do {
                    
                    let jsonResult = try NSJSONSerialization.JSONObjectWithData(urlContent, options: NSJSONReadingOptions.MutableContainers)
                    
                    for var x=0; x<jsonResult.count;x++ {
                        let item = jsonResult[x]
                        let c : Content = Content()
                        
                        _ = item["ContentID"] as! String
                        c.Title = item["Title"] as! String
                        c.likes.counter = Int(item["Likes"] as! String)!
                        c.dislikes.counter = Int(item ["DisLikes"] as! String)!
                        
                        var comments: [Comment] = []
                        let itemC = item["Comments"] as! NSArray
                        for var i=0; i<itemC.count;i++ {
                            let comment: Comment = Comment()
                            comment.comment = itemC[i]["CommentText"] as! String
                            comment.user.username = itemC[i]["UserID"] as! String
                            comments.append(comment)
                        }
                        c.comments = comments
                        contents.append(c)
                        print("DONE")
                    }
                    dispatch_async(dispatch_get_main_queue())
                        {
                            self.contents = contents;
                            self.tableView.reloadData();
                    }
                } catch {
                    
                    print("JSON serialization failed")
                    
                }
                
                
            }
            
            
        }
        task.resume()
        tableView.reloadData()
    }

}