//
//  ManageEventsViewController.swift
//  InformME
//
//  Created by Amal Ibrahim on 2/5/16.
//  Copyright © 2016 King Saud University. All rights reserved.
//

import Foundation

import UIKit

class ManageEventsViewController: UIViewController , UITableViewDataSource, UITableViewDelegate, EventCellDelegate {
    /*Hello : ) */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setup tint color for tha back button.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
}
    // TODO: Check the dynamic table tutorial in Google Drive it will help a lot.
    // MARK: --- Table Functions ---
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("eventCell", forIndexPath: indexPath) as! EventTableCellViewController
       
            // if self.retrievedEvents != nil && self.retrievedEvents?.count >= indexPath.row
        //{
            //let event = self.events![indexPath.row]
            cell.delegate = self
            //cell.eventName.text = anEvent.Name
       // }
        return cell

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // TODO: this number should be changed to the actual number of recieved events.
        return 10;
    }
    
    // MARK: --- Go Event Page ---
    func showEventDetails() {
        performSegueWithIdentifier("showEventDetails", sender: self)
    }
}