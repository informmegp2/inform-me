//
//  Event.swift
//  InformME
//
//  Created by Amal Ibrahim on 2/4/16.
//  Copyright © 2016 King Saud University. All rights reserved.
//

import Foundation
import UIKit
class Event {
    var report: Report = Report()
    var contentList: [ Content ] = []
    var name: String = ""
    var logo: UIImage?
    var website: String = ""
    var date: NSDate?
    var venue: String = ""
    var organizer: EventOrganizer = EventOrganizer()
  var eventsName: Array<String> = []
    func requesteventlist() {
        
        let parameters = [
            
            "uid":1]
        
       /* Alamofire.request(.POST, "http://bemyeyes.co/API/event/retrieveEvents.php", parameters: parameters)
            
            .responseJSON { response in
                
                
                
                
                
                print(response.request)  // original URL request
                
                print(response.response) // URL response
                
                print(response.data)     // server data
                
                print(response.result)   // result of response serialization
                
                
                
                if let JSON = response.result.value {
                    
                    print("JSON: \(JSON)")
                    print(JSON.count)
                    for var x=0; x<JSON.count;x++ {
                        
                        print(JSON[x]["EventName"] as! String)
                        
                        self.eventsName.append(JSON[x]["EventName"] as! String)
                        print(self.eventsName.count)
                    }
                    
                }
                
                
                print("lLLllll")
                
        }*/
        
        
        print(self.eventsName.count)
    }
    func viewevent() {}
    func requesttoaddcontent() {}
    func addcontent(title: String,abstract: String,images: [UIImage],video: String, Pdf: String) {}
    func requesttoupdatecontent() {}
    func updatecontent(title: String,abstract: String,images: [UIImage],video: String, Pdf: String){}
    func requestcontent(id: Int){}
    func requesttodeletecontent(content: Content){}
    func deletecontent(content: Content){}
    func RequestContentList(){}
    func ViewContent(ContentID: Int){}
    func RequestContent(label: String){}
    func requestToAddEvent(){}
    
    
    func AddEvent(name: String,web: String,date: String){
        let MYURL = NSURL(string:"http://bemyeyes.co/API/event/addEvent.php")
        let request = NSMutableURLRequest(URL:MYURL!)
        request.HTTPMethod = "POST";
        
        
        //Change UserID"
        
        let postString = "evName="+name+"&evWebsite="+web+"&evDate="+date+"&uid=1"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding);
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil
            {
                print("error=\(error)")
                return
            }
            
            // You can print out response object
            print("response = \(response)")
            
            
            
        }
        
        task.resume()
    
    
    }
    
    
    
    
    func requestTodeleteEvent(){}
    func DeleteEvent(){}
    func requestToUpdateEvent(){}
    func updateEvent(){}
    
    

}