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
    var date: String=""
    var venue: String = ""
    var id: Int=0
    var organizer: EventOrganizer = EventOrganizer()
  var eventsName: Array<String> = []
    func requesteventlist() {
        
        let parameters = [ "uid":1]

        
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

    func AddEvent(name: String,web: String,date: String,logo: UIImage){
        
        
      
        
        
        
 
        
        let MYURL = NSURL(string:"http://bemyeyes.co/API/event/addEvent.php")
        let request = NSMutableURLRequest(URL:MYURL!)
        request.HTTPMethod = "POST";
     
        
        //Change UserID"
        
        let image=UIImageJPEGRepresentation(logo,0.1)

let base64String = image!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)

    
        let postString = "evName="+name+"&evWebsite="+web+"&evDate="+date+"&uid=1"+"&logo="+base64String
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
