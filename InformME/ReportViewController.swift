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
    
    func displayAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction((UIAlertAction(title: "موافق", style: .Default, handler: { (action) -> Void in
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        })))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
        
    }//end fun display alert
    
    
    override func viewDidLoad() {
        if(Reachability.isConnectedToNetwork()){
        report.viewReport(event){
            (contents:[Content]) in
            dispatch_async(dispatch_get_main_queue()) {
            self.contents = contents
            self.tableView.reloadData()
        }

            }}
        else {
            self.displayAlert("", message: "الرجاء الاتصال بالانترنت")
        }
        print("I am Back22")
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.reloadData();
    }
    // MARK: --- Table Functions ---
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //TODO: Comments Repeat every 5 contents!
        let cell = tableView.dequeueReusableCellWithIdentifier("contentReportCell", forIndexPath: indexPath) as! ContentReportTableViewCellController
        let name = self.contents[indexPath.row].Title
        cell.name.text = name as String
        let likes = self.contents[indexPath.row].likes.counter
        cell.likes.text = String(likes)
        let dislikes = self.contents[indexPath.row].dislikes.counter
        cell.dislikes.text = String(dislikes)
        let comments = self.contents[indexPath.row].comments
        cell.comments = comments
        if(comments.count > 0) {
            print("\(comments[0].comment) + \(contents[indexPath.row].contentId)")}
        else {
            print("\(contents[indexPath.row].contentId)")}
        cell.commentsNo.text = String(comments.count)
        cell.commentsTable.delegate = cell;
        cell.commentsTable.dataSource = cell;
        cell.commentsTable.reloadData()
        cell.sharesNo.text = String(self.contents[indexPath.row].shares)
        return cell
        
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return contents.count;
    }
    
 


}