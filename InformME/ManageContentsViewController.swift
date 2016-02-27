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
        var TitleA : [String] = []
        let eid=1
        let cid=1
        
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://bemyeyes.co/API/content/SelectContent.php")!)
        
        request.HTTPMethod = "POST"
        let postString = "eid=\(eid)&cid=\(cid)"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if let urlContent = data {
                
                do {
                    
                    let jsonResult = try NSJSONSerialization.JSONObjectWithData(urlContent, options: NSJSONReadingOptions.MutableContainers)
                    
                    
                    for var x=0; x<jsonResult.count;x++ {
                        var content: Content = Content()
                        var t : AnyObject = jsonResult[x]["Title"]as! String
                        var a : AnyObject = jsonResult[x]["Abstract"]as! String
                        var p : AnyObject = jsonResult[x]["PDFFiles"]as! String
                        var v : AnyObject = jsonResult[x]["Videos"]as! String
                        var id : String = jsonResult[x]["ContentID"]as! String


                        content.Title=t as! String
                        content.Abstract=a as! String
                        content.Pdf=p as! String
                        content.Video=v as! String
                        content.CID=Int (id)
                        if TitleA.contains(t as! String) {
                            
                        }
                        else
                        {
                            TitleA.append(t as! String)
                            self.values.addObject(content)
                            self.contentsInfo.addObject(content)
                        }
                        
                       
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
    
    
    func showContentDetails(){
        performSegueWithIdentifier("showContentDetails", sender: self)
    }
   
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        
        if (segue.identifier == "showContentDetails") {
            let pointInTable: CGPoint = sender.convertPoint(sender.bounds.origin, toView: self.tableView)
            let cellIndexPath = self.tableView.indexPathForRowAtPoint(pointInTable)
            print(cellIndexPath?.row)
            var c : Content = Content()
            c=contentsInfo[(cellIndexPath?.row)!] as! Content
            //Checking identifier is crucial as there might be multiple
            // segues attached to same view
            var detailVC = segue!.destinationViewController as! ContentForOrganizerViewController
            
            detailVC.ttitle=c.Title
            detailVC.abstract=c.Abstract
            detailVC.pdf=c.Pdf
            detailVC.video=c.Video
            detailVC.contentid=c.CID!
            

        
        }
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