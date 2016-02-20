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

    override func viewDidLoad() {
        
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
        
        return cell
        
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: this number should be changed to the actual number of recieved events.
        //return values.count;
        return 0;
    }
    
    

}