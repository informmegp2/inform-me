//
//  EventDetailsViewController.swift
//  InformME
//
//  Created by nouf abdullah on 4/30/1437 AH.
//  Copyright © 1437 King Saud University. All rights reserved.
//

import UIKit

class EventDetailsViewController: UIViewController {
    @IBOutlet var name: UINavigationItem!
    var evid:Int=1;
    @IBOutlet var date: UILabel!
    @IBOutlet var website: UILabel!
   
    override func viewDidLoad() {
      
        super.viewDidLoad()
       
        print("here \(evid)")
get()
        // Do any additional setup after loading the view.
    }
    func get(){
        let request = NSMutableURLRequest(URL: NSURL(string: "http://bemyeyes.co/API/event/EventInfo.php")!)
        request.HTTPMethod = "POST"
        let postString = "eid=\(evid)"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if let urlContent = data {
                
                do {
                    
                    let jsonResult = try NSJSONSerialization.JSONObjectWithData(urlContent, options: NSJSONReadingOptions.MutableContainers)
                    
                   
                        
                        
                        
                        print(jsonResult[0]["EventName"])
                        print(jsonResult[0]["Website"])
                    
                    dispatch_async(dispatch_get_main_queue())
                        {
                            
                            self.website.text=jsonResult[0]["Website"] as? String
                            self.date.text=jsonResult[0]["Date"] as? String
                            self.name.title=jsonResult[0]["EventName"] as? String}
                } catch {
                    
                    print("JSON serialization failed")
                    
                }
                
                
            }
            
            
        }
        task.resume()
        print("hi");
        
        
      
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
