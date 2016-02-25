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
    
    @IBOutlet var tableView: UITableView!
  
     var eventsInfo: [Event] = []
    var event:Event = Event()
    var UserID: Int = 1
    
    override func viewDidLoad() {
       
        event.requesteventlist(UserID){
            (eventsInfo:[Event]) in
            dispatch_async(dispatch_get_main_queue()) {
                self.eventsInfo = eventsInfo
                self.tableView.reloadData()
            }
            
        }
        print("I am Back")
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.reloadData();
        
        //setup tint color for tha back button.
    }
    
   
  
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
}
    // TODO: Check the dynamic table tutorial in Google Drive it will help a lot.
    // MARK: --- Table Functions ---
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("eventCell", forIndexPath: indexPath) as! EventTableCellViewController
        var e : Event = Event()
        e=eventsInfo[(indexPath.row)] as! Event
        print(e.name)
       
        cell.name.text = e.name
        
        return cell


    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // TODO: this number should be changed to the actual number of recieved events.
          return eventsInfo.count;
    }
    
    
   
    // MARK: --- Go Event Page ---
    func showEventDetails() {
        performSegueWithIdentifier("showEventDetails", sender: self)
    }
    
   override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
    if (segue.identifier == "showEventDetails") {
        let pointInTable: CGPoint = sender.convertPoint(sender.bounds.origin, toView: self.tableView)
        let cellIndexPath = self.tableView.indexPathForRowAtPoint(pointInTable)
     
        var e : Event = Event()
        e=eventsInfo[(cellIndexPath?.row)!] as! Event

            //Checking identifier is crucial as there might be multiple
            // segues attached to same view
            var detailVC = segue!.destinationViewController as! EventDetailsViewController;
           detailVC.evid = e.id
        detailVC.evname=e.name
detailVC.evwebsite=e.website
detailVC.evdate=e.date
        
        detailVC.evlogo=e.logo    }
    
    }
}