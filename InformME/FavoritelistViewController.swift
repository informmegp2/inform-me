//
//  FavoritelistViewController.swift
//  InformME
//
//  Created by Amal Ibrahim on 2/9/16.
//  Copyright © 2016 King Saud University. All rights reserved.
//

import Foundation
import UIKit

class FavoritelistViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    
    
    var contentList = [Content]()
    var uid = 30;
    
    @IBOutlet var tableView: UITableView!
    @IBAction func out(sender: AnyObject) {
        print(" iam in 1")
        
        var flag: Bool
        flag = false
        
        
        
        var current: Authentication = Authentication();
        
        current.logout(){
            (login:Bool) in
            
            dispatch_async(dispatch_get_main_queue()) {
                
                flag = login
                if(flag) {
                    
                    self.performSegueWithIdentifier("backtologin", sender: self)
                    
                    
                    print("I am happy",login,flag) }
                
            }
            print("I am Here")  }
        
    } //end out */ backtologin
    
  
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
      //  loadFavorite ()
       
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFavorite () {
            () in
            dispatch_async(dispatch_get_main_queue()) {
                self.tableView.reloadData()
            }
        }
      // self.tableView.reloadData()
     /*   var c = Content ()
        c.contentId = 106
        c.Title = "This is working"
        contentList.append(c)
        
        
        self.tableView.reloadData()
print("Done")*/
    }
    
 
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentList.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("contentCell", forIndexPath: indexPath) as! ContentTableCellViewController
        
     
        cell.Title.text = contentList[indexPath.row].Title
        
        cell.tag = contentList[indexPath.row].contentId
        
        cell.ViewContentButton.tag = contentList[indexPath.row].contentId
        
        cell.SaveButton.tag = contentList[indexPath.row].contentId
        
        print("HERE IN CELL")
        
        return cell
        
    }
    
    
    @IBAction func save(sender: UIButton) {
        
        let imageFull = UIImage(named: "starF.png") as UIImage!
        let imageEmpty = UIImage(named: "star.png") as UIImage!
        if (sender.currentImage == imageFull)
        {//content saved -> user wants to delete save
            sender.setImage(imageEmpty, forState: .Normal)
            Content().unsaveContent(uid, cid: contentList[sender.tag].contentId)
        }
        else
        {//content is not saved -> user wants to save
            sender.setImage(imageFull, forState: .Normal)
            let image = UIImage(named: "starF.png") as UIImage!
            sender.setImage(image, forState: .Normal)
            Content().saveContent(uid, cid: contentList[sender.tag].contentId)
        }
    }

    
  override func prepareForSegue (segue: UIStoryboardSegue, sender: AnyObject?)
    {        print("in segue")
        
        if (segue.identifier == "ShowView")
        {
            var upcoming: ContentForAttendeeViewController = segue.destinationViewController as! ContentForAttendeeViewController
            
            let indexPath = self.tableView.indexPathForSelectedRow!
            
            let cid = contentList[indexPath.row].contentId
            
            upcoming.cid = cid
            
        }}
    
    func loadFavorite (completion: () -> Void)
    {
        
        //Col::(ContentID, Title, Abstract, Sharecounter, Label, EventID)
       
        let request = NSMutableURLRequest(URL: NSURL(string: "http://bemyeyes.co/API/content/getFavourite.php")!)
        request.HTTPMethod = "POST";
        
        let postString = "uid=\(uid)";
        
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding);
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            print("HERE in task");
            if error != nil {
                print("error=\(error)")
                return
            }
            else {
                do {
                    if let jsonResults = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [AnyObject]{
                        print(jsonResults)
                        for item in jsonResults {
                            self.contentList.append(Content(json: item as! [String : AnyObject]))
                        }
                    }
                    
                }
                catch {
                    // failure
                    print("Fetch failed: \((error as NSError).localizedDescription)")
                }
                
            }
            
            completion()
        }
        task.resume()
        
    }


    
}