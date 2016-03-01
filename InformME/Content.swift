//
//  File.swift
//  InformME
//
//  Created by Amal Ibrahim on 2/4/16.
//  Copyright © 2016 King Saud University. All rights reserved.
//

import Foundation
import UIKit
class Content {
    var Title: String = ""
    var Abstract: String = ""
    var Images: [UIImage] = []
    var Video: String = ""
    //var Pdf: NSData = NSData() //this will be changed depending on our chosen type.
    var Pdf : String = ""
    var likes: Like = Like()
    var dislikes:Dislike = Dislike()
    var comments: [Comment] = []
    var CID:Int?
    var shares: Int = 0
    var label: String = ""
    var contentId: Int = 0
    var like: Int = 0
    var dislike: Int = 0
    
    
    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
        var body = NSMutableData();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString("--\(boundary)\r\n")
                body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString("\(value)\r\n")
            }
        }
        
        let filename = "ContentImage.jpg"
        
        let mimetype = "image/jpg"
        
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.appendString("Content-Type: \(mimetype)\r\n\r\n")
        body.appendData(imageDataKey)
        body.appendString("\r\n")
        
        
        
        body.appendString("--\(boundary)--\r\n")
        
        return body
    }


    func saveContent(title: String,abstract: String ,video: String,Pdf: String,image: [UIImage],flagI: [Bool], completionHandler: (flag:Bool) -> ()) {
        
        var f=false

        let eid=1
        let l = "be"
        let SC = 1
        
        let MYURL = NSURL(string:"http://bemyeyes.co/API/content/AddContent.php")

        let request = NSMutableURLRequest(URL:MYURL!)

        request.HTTPMethod = "POST";
        let postString = "Title="+title+"&Abstract="+abstract+"&ShareCounter=\(SC)&Label=\(l)&EventID=\(eid)&PDF=\(Pdf)&Video=\(video)"
        
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding);

        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil
            {
                print("error=\(error)")
                return
            }
            

            print("response = \(response)")
            
        }

        task.resume()
        addImage(title,abstract: abstract,image: image ,flagI: flagI)
        f=true
        completionHandler(flag: f)
}
    
    func addImage(title: String,abstract: String ,image: [UIImage] , flagI : [Bool]){
        let eid=1
        let l = "be"
        let SC = 1

        for i in 0...image.count {
            if flagI[i]{
                
                let MYURL = NSURL(string:"http://bemyeyes.co/API/content/AddImage.php")
                
                let request = NSMutableURLRequest(URL:MYURL!)
                
                request.HTTPMethod = "POST";
                
                let param : [String: String] = [
                    "Title"     : title,
                    "Abstract"  :abstract,
                    "EventID"  :String(eid),
                    "ShareCounter" :String(SC),
                    "Label" : l,
                    "ImageNum" : String(i)
                ]
                let boundary = generateBoundaryString()
                request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
                let imageData = UIImageJPEGRepresentation(image[i], -1)
                if imageData==nil{
                    print("it is nil")}
                
                request.HTTPBody = createBodyWithParameters(param, filePathKey: "file", imageDataKey: imageData!, boundary: boundary)
                
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
        }
    }

    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().UUIDString)"
    }
    
    func updateContent(title: String,abstract: String ,video: String,Pdf: String , TempV: String , TempP: String , cID:Int ,completionHandler: (flag:Bool) -> ()) {
        
        var f=false

        let MYURL = NSURL(string:"http://bemyeyes.co/API/content/EditContent.php")
        let request = NSMutableURLRequest(URL:MYURL!)
        request.HTTPMethod = "POST";
        
        //Change UserID"
        
        let postString = "Title=\(title)&Abstract=\(abstract)&PDF=\(Pdf)&Video=\(video)&CID=\(cID)&pPDF=\(TempP)&pVideo=\(TempV)"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding);
        
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
    
    func DeleteContent(id: Int ,completionHandler: (flag:Bool) -> ()){
        
        var f=false

        let MYURL = NSURL(string:"http://bemyeyes.co/API/content/DeleteContent.php")
        let request = NSMutableURLRequest(URL:MYURL!)
        request.HTTPMethod = "POST";
        
        
        //Change UserID"
        
        let postString = "cid=\(id)"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding);
        
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
    func requestcontentlist(id: Int,completionHandler: (contentInfo:[Content]) -> ()){
        
        
        var TitleA : [String] = []
        var contentInfo: [Content] = []
        let uid=id
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
                            //self.values.addObject(content)
                           
                            contentInfo.append(content)
                        }}}
                catch {
                    
                    print("JSON serialization failed")
                    
                }
                
                
            }
            
            completionHandler(contentInfo: contentInfo)
        }
        task.resume()
        
        
    }

    
    
    func shareContent(cid: Int, completionHandler: (done:Bool) -> ()) {
        let MYURL = NSURL(string:"http://bemyeyes.co/API/content/shareContent.php")
        let request = NSMutableURLRequest(URL:MYURL!)
        request.HTTPMethod = "POST";
        
        //Change UserID"
        
        let postString = "cid=\(cid)"
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
            
            
            completionHandler(done: true)
        }
        
        task.resume()
     
    
    }
    func createContent(title: String,abstract: String ,images: [UIImage],video: String,Pdf: NSData) {}
    func deleteComment(comment: Comment) {}
    
    func disLikeContent(cid: Int, uid: Int, completionHandler: (done:Bool) -> ()) {
        let MYURL = NSURL(string:"http://bemyeyes.co/API/content/evaluate.php")
        let request = NSMutableURLRequest(URL:MYURL!)
        request.HTTPMethod = "POST";
        
        //Change UserID"
        let dislike = 1
        let like = 0
        let postString = "cid=\(cid)&uid=\(uid)&like=\(like)&dislike=\(dislike)"
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
            
            
            completionHandler(done: true)
        }
        
        task.resume()
        

    }
    func likeContent(cid: Int, uid: Int, completionHandler: (done:Bool) -> ()){
        let MYURL = NSURL(string:"http://bemyeyes.co/API/content/evaluate.php")
        let request = NSMutableURLRequest(URL:MYURL!)
        request.HTTPMethod = "POST";
        
        //Change UserID"
        let dislike = 0
        let like = 1
        let postString = "cid=\(cid)&uid=\(uid)&like=\(like)&dislike=\(dislike)"
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
            
            
            completionHandler(done: true)
        }
        
        task.resume()
        

    
    
    
    
    }
    
    //MARK --Found No Need for the commented methods
    //func requestToAddComment() {}
    //func requestToDeleteComment() {}

    func saveComment(comment: Comment, completionHandler: (done:Bool) -> ()) {
        let com = comment.comment
        let user = comment.user.userID
        let cid = comment.contentID
        let MYURL = NSURL(string:"http://bemyeyes.co/API/content/addcomment.php")
        let request = NSMutableURLRequest(URL:MYURL!)
        request.HTTPMethod = "POST";
        
        //Change UserID"
        
        let postString = "cid=\(cid)&uid=\(user)&comment=\(com)"
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

            
            completionHandler(done: true)
        }
        
        task.resume()
        
    }

    
    //MARK: --- THIS METHOD WAS MOVED FROM EVENTS CLASS ---
    func ViewContent(ContentID: Int, UserID:Int, completionHandler: (content:Content) -> ()){
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://bemyeyes.co/API/content/contentdetails.php")!)
        request.HTTPMethod = "POST"
        let postString = "cid=\(ContentID)&uid=\(UserID)"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if let urlContent = data {
                
                do {
                    let jsonResult = try NSJSONSerialization.JSONObjectWithData(urlContent, options: NSJSONReadingOptions.MutableContainers)
                    
                    for var x=0; x<jsonResult.count;x++ {
                        let item = jsonResult[x]
                        let c : Content = Content()
                        c.contentId = Int(item["ContentID"] as! String)!
                        c.Title = item["Title"] as! String
                        c.Abstract = item["Abstract"] as! String
                        c.Pdf = item["PDFFiles"] as! String
                        c.Video = item["Videos"] as! String
                        c.shares = Int(item["ShareCounter"] as! String)!
                        c.label = item["Label"] as! String
                        //c.likes.counter = Int(item["Likes"] as! String)!
                        //c.dislikes.counter = Int(item ["DisLikes"] as! String)!
                        
                        var comments: [Comment] = []
                        let itemC = item["Comments"] as! NSArray
                        for var i=0; i<itemC.count;i++ {
                            let comment: Comment = Comment()
                            comment.comment = itemC[i]["CommentText"] as! String
                            comment.user.username = itemC[i]["UserName"] as! String
                            comments.append(comment)
                        }
                       let lk = item["Like"] as! String
                        c.like = Int(lk)!
                        
                        let dislk = item["dislike"] as! String
                        c.dislike = Int(lk)!
                        c.comments = comments
                        completionHandler(content: c)

                        print("DONE")
                    }
                } catch {
                    
                    print("JSON serialization failed")
                    
                }
                
                
            }
        }
        task.resume()
    }
    
    init ()
    {   Title = ""
        Abstract = ""
        Images = [UIImage] ()
        Video  = ""
        //Pdf: NSData = NSData() //this will be changed depending on our chosen type.
        Pdf  = ""
        likes = Like()
        dislikes = Dislike()
        comments = [Comment]()
        shares = 0
        label = ""
        contentId = 0}
    
    init(json: [String: AnyObject]) {
        contentId = Int(json["ContentID"] as! String)!
        Title = json["Title"] as! String
        Abstract = json["Abstract"] as! String
       // Pdf = json["PDFFiles"] as! String
      //  Video = json["Videos"] as! String
        shares = Int(json["ShareCounter"] as! String)!
        label = json["Label"] as! String
        //likes.counter = Int(json["Likes"] as! String)!
        //dislikes.counter = Int(json ["DisLikes"] as! String)!
        
       /* var comments: [Comment] = []
        let itemC = json["Comments"] as! NSArray
        for var i=0; i<itemC.count;i++ {
            let comment: Comment = Comment()
            comment.comment = itemC[i]["CommentText"] as! String
            comment.user.username = itemC[i]["UserName"] as! String
            comments.append(comment)
        }
        self.comments = comments*/
    }
}
/*extension NSMutableData {
    
    func appendString(string: String) {
        let data = string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        appendData(data!)
    }
}*/