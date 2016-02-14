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
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().UUIDString)"
    }
    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
        var body = NSMutableData();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString("--\(boundary)\r\n")
                body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString("\(value)\r\n")
            }
        }
        
        let filename = "user-profile.jpg"
        
        let mimetype = "image/jpg"
        
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.appendString("Content-Type: \(mimetype)\r\n\r\n")
        body.appendData(imageDataKey)
        body.appendString("\r\n")
        
        
        
        body.appendString("--\(boundary)--\r\n")
        
        return body
    }
    
    func AddEvent(name: String,web: String,date: String,logo: UIImage){
        
        
      
        
        
        
 
        
        let MYURL = NSURL(string:"http://bemyeyes.co/API/event/addEvent.php")
        let request = NSMutableURLRequest(URL:MYURL!)
        request.HTTPMethod = "POST";
     
        
        //Change UserID"
          let boundary = generateBoundaryString()
          request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        let imageData = UIImageJPEGRepresentation(logo, 1)
        
        
        
   
        let param = [
            "evName"  : name,
            "evWebsite"    : web,
            "evDate"    : date,
            "uid" : "1"
        ]
       
      
        request.HTTPBody = createBodyWithParameters(param as! [String : String], filePathKey: "file", imageDataKey: imageData!, boundary: boundary)
        
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
extension NSMutableData {
    
    func appendString(string: String) {
        let data = string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        appendData(data!)
    }
}