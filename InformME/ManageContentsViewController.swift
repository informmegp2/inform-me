//
//  ManageContentViewController.swift
//  InformME
//
//  Created by sara on 5/4/1437 AH.
//  Copyright © 1437 King Saud University. All rights reserved.
//

import Foundation
import UIKit

class ManageContentsViewController: UIViewController,UITableViewDataSource, UITableViewDelegate ,ContentCellDelegate  {
    
    var values:NSMutableArray = []
    var label:NSMutableArray = []
    var contentsInfo:NSMutableArray=[]
    //var bID:Int = 1;
    
    @IBOutlet var tableView: UITableView!


        override func viewDidLoad() {
            super.viewDidLoad()
            get();
            tableView.reloadData()
            //setup tint color for tha back button.
        }
        func get(){
            let eid=1
            
            
            
            let request = NSMutableURLRequest(URL: NSURL(string: "http://bemyeyes.co/API/content/SelectContent.php")!)
            
            request.HTTPMethod = "POST"
            let postString = "eid=\(eid)"
            request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
            
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
                data, response, error in
                
                if let urlContent = data {
                    
                    do {
                        
                        let jsonResult = try NSJSONSerialization.JSONObjectWithData(urlContent, options: NSJSONReadingOptions.MutableContainers)
                        
                        
                        for var x=0; x<jsonResult.count;x++ {
                            var content: Content = Content()
                            var t : AnyObject = jsonResult[x]["Title"]as! String
                           // var m : AnyObject = jsonResult[x]["Major"]as! String
                            // var mi : AnyObject = jsonResult[x]["Minor"]as! String
                            
                            content.Title=t as! String
                          //  content.Major=m as! String
                            //content.Minor=mi as! String
                            self.values.addObject(content)
                            self.contentsInfo.addObject(content)
                            
                            
                        }
                        dispatch_async(dispatch_get_main_queue()){
                            self.tableView.reloadData()}
                        
                    } catch {
                        
                        print("JSON serialization failed")
                        
                    }
                    
                    
                }
                
                
            }
            task.resume()
            tableView.reloadData()
        }
    
        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("contentCell", forIndexPath: indexPath) as! ContentTableCellViewController
            //var maindata = values[indexPath.row].minor
            var c: Content = Content()
            c = self.values[indexPath.row] as! Content
            
            cell.title.text = c.Title
            
            
            
            return cell
            
            
        }
        
        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // TODO: this number should be changed to the actual number of recieved events.
            return values.count;
        }
        

        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
    
}