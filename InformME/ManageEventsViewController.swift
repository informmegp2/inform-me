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
   var values:NSMutableArray = []
     var eventsID:NSMutableArray = []
    var eventsInfo:NSMutableArray=[]
    var eID:Int = 1;
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        get();
       tableView.reloadData()
        
        //setup tint color for tha back button.
    }
    func get(){
        let uid=1
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://bemyeyes.co/API/event/retrieveEvents.php")!)
        request.HTTPMethod = "POST"
        let postString = "uid=\(uid)"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if let urlContent = data {
                
                do {
                    
                    let jsonResult = try NSJSONSerialization.JSONObjectWithData(urlContent, options: NSJSONReadingOptions.MutableContainers)
                    
                    for var x=0; x<jsonResult.count;x++ {
                        
                        
                        var e : Event = Event()
                        e.date=jsonResult[x]["Date"] as! String
                        e.name=jsonResult[x]["EventName"] as! String
                        e.website=jsonResult[x]["Website"] as! String
                       // e.id=jsonResult[x]["EventID"] as! String
                      self.eventsInfo.addObject(e)
                        
                        
                        self.values.addObject(jsonResult[x]["EventName"] as! String)
                         self.eventsID.addObject(jsonResult[x]["EventID"] as! String)
                        print(self.values[x])
                         print(self.eventsID[x])
                    }
                    dispatch_async(dispatch_get_main_queue())
                        {
                            
                            self.tableView.reloadData()
                    }
                    
                } catch {
                    
                    print("JSON serialization failed")
                    
                }
                
                
            }
            
            
        }
        task.resume()
        print("hi");
        
        
        tableView.reloadData()    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
}
    // TODO: Check the dynamic table tutorial in Google Drive it will help a lot.
    // MARK: --- Table Functions ---
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("eventCell", forIndexPath: indexPath) as! EventTableCellViewController
        let maindata = self.values[indexPath.row]
        cell.name.text = maindata as? String
        
        return cell


    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // TODO: this number should be changed to the actual number of recieved events.
          return values.count;
    }
    
    // MARK: --- Go Event Page ---
    func showEventDetails() {
        performSegueWithIdentifier("showEventDetails", sender: self)
    }
    
   override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        let pointInTable: CGPoint = sender.convertPoint(sender.bounds.origin, toView: self.tableView)
        let cellIndexPath = self.tableView.indexPathForRowAtPoint(pointInTable)
        print(cellIndexPath?.row)
        print(values[(cellIndexPath?.row)!])
        var e : Event = Event()
        e=eventsInfo[(cellIndexPath?.row)!] as! Event
print(e.name)
            //Checking identifier is crucial as there might be multiple
            // segues attached to same view
            var detailVC = segue!.destinationViewController as! EventDetailsViewController;
           //detailVC.evid = e.id
        detailVC.evname=e.name
detailVC.evwebsite=e.website
detailVC.evdate=e.date
        
        
    }
}