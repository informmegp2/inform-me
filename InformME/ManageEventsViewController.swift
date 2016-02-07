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
    override func viewDidLoad() {
        super.viewDidLoad()
        get();
       tableView.reloadData()
        
        //setup tint color for tha back button.
    }
    func get(){
        let uid=1
        /*let url = NSURL(string: "http://bemyeyes.co/API/event/retrieveEvents.php")
        let data = NSData(contentsOfURL: url!)
        values = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSArray
        print(String(data))
        tableView.reloadData()*/
        
        
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
                        
                        
                        
                        self.values.addObject(jsonResult[x]["EventName"] as! String)
                        print(self.values[x])
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
}