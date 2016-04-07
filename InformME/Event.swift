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
    
    
    func requesteventlist(id: Int,completionHandler: (eventsInfo:[Event]) -> ()){
        var eventsInfo: [Event] = []
        print("in event managment")
        let uid=id
        
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
                        print("is it before?")
                        var evID = jsonResult[x]["EventID"] as! String
                        e.date=jsonResult[x]["Date"] as! String
                        e.name=jsonResult[x]["EventName"] as! String
                        e.website=jsonResult[x]["Website"] as! String
                        print("is it after?\(evID)")

                        e.id = Int(evID)!
                        let url:NSURL = NSURL(string : jsonResult[x]["Logo"] as! String)!
                       let data = NSData(contentsOfURL: url)
                        e.logo=UIImage(data: data!)
                        eventsInfo.append(e)
                        print("is it at the end?")

                        
                        
                    }
                   
                    
                } catch {
                    
                    print("JSON serialization failed")
                    
                }
                
                
            }
            print("here?")
              completionHandler(eventsInfo: eventsInfo)
        }
        task.resume()
        print("hi");
        
        
       
 
        
       
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
        
        let filename = "EventLogo.jpg"
        
        let mimetype = "image/jpg"
        
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.appendString("Content-Type: \(mimetype)\r\n\r\n")
        body.appendData(imageDataKey)
        body.appendString("\r\n")
        
        
        
        body.appendString("--\(boundary)--\r\n")
        
        return body
    }
    
    
    
    
    func AddEvent(uid:Int, name: String,web: String,date: String,logo: UIImage, completionHandler: (flag:Bool) -> ()){
        
        
        var f=false
        
        
        
        var uuid = String(uid)
        
        let MYURL = NSURL(string:"http://bemyeyes.co/API/event/addEvent.php")
        let request = NSMutableURLRequest(URL:MYURL!)
        request.HTTPMethod = "POST";
        
        let param = [
            "evName"  : name,
            "evWebsite"    : web,
            "evDate"    : date,
            "uid" : uuid
        ]
        
        //Change UserID"
        
        let boundary = generateBoundaryString()
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        
        let imageData = UIImageJPEGRepresentation(logo, -1)
        if imageData==nil{
            print("it is nil")}
        
        request.HTTPBody = createBodyWithParameters(param, filePathKey: "file", imageDataKey: imageData!, boundary: boundary)
        
        /*let base64String = image!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
        
        
        let postString = "evName="+name+"&evWebsite="+web+"&evDate="+date+"&uid=1"+"&logo="+base64String
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding);*/
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil
            {
                print("error=\(error)")
                return
            }
           f=true
                    // You can print out response object
                    print("response = \(response)")
            
            
          completionHandler(flag: f)
            
        }
        
        task.resume()
        
        
        
    }
    
    
    
    
    func requestTodeleteEvent(){}
    func DeleteEvent(id: Int){
        var eid = String(id)
        
        
        
        
        let MYURL = NSURL(string:"http://bemyeyes.co/API/event/deleteEvent.php")
        let request = NSMutableURLRequest(URL:MYURL!)
        request.HTTPMethod = "POST";
        
        
        //Change UserID"
        
        
        
        
        let postString = "&evid="+eid
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
    func requestToUpdateEvent(){}
    func updateEvent(id: Int,name: String,web: String,date: String,logo: UIImage, completionHandler: (flag:Bool) -> ()){
        
        
        var f=false
        
        let eid = String(id)
        
        
        
        let MYURL = NSURL(string:"http://bemyeyes.co/API/event/EditEvent.php")
        let request = NSMutableURLRequest(URL:MYURL!)
        request.HTTPMethod = "POST";
        
        let param = [
            "evName"  : name,
            "evWebsite"    : web,
            "evDate"    : date,
            "uid" : eid
        ]
        
        //Change UserID"
        
        let boundary = generateBoundaryString()
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        
        let imageData = UIImageJPEGRepresentation(logo, -1)
        if imageData==nil{
            print("it is nil")}
        
        request.HTTPBody = createBodyWithParameters(param, filePathKey: "file", imageDataKey: imageData!, boundary: boundary)
        
        /*let base64String = image!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
        
        
        let postString = "evName="+name+"&evWebsite="+web+"&evDate="+date+"&uid=1"+"&logo="+base64String
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding);*/
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil
            {
                print("error=\(error)")
                return
            }
            f=true
            // You can print out response object
            print("response = \(response)")
            
            
            completionHandler(flag: f)
            
        }
        
        task.resume()}
    
}
extension NSMutableData {
    
    func appendString(string: String) {
        let data = string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        appendData(data!)
    }
}