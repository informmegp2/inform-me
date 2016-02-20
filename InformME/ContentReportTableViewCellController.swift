//
//  EventReportTableViewCell.swift
//  InformME
//
//  Created by Amal Ibrahim on 2/20/16.
//  Copyright © 2016 King Saud University. All rights reserved.
//

import Foundation
import UIKit

@objc protocol ReportCellDelegate: class {
}
class ContentReportTableViewCellController: UITableViewCell, UITableViewDelegate, UITableViewDataSource{
    var delegate:ReportCellDelegate?
    
    @IBOutlet var name: UILabel!
    @IBOutlet var likes: UILabel!
    @IBOutlet var dislikes: UILabel!
    @IBOutlet var commentsNo: UILabel!
    @IBOutlet var commentsTable: UITableView!
    
    var comments: [Comment] = []
    
    // MARK: --- Table Functions ---
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("commentCell", forIndexPath: indexPath) as! CommentTableViewCellController
            let maindata = self.comments[indexPath.row].comment
             cell.comment.text = maindata as String
            let username = self.comments[indexPath.row].user.username
            cell.user.text = username as String
        
        return cell
        
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: this number should be changed to the actual number of recieved events.
        return comments.count;
    }

}