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
    
    func saveContent(title: String,abstract: String ,video: String,Pdf: String,completionHandler: (flag:Bool) -> ()) {
        
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
            f=true

            print("response = \(response)")
            completionHandler(flag: f)

        }

        task.resume()

        
    }
    
   // func updateContent(title: String,abstract: String ,images: [UIImage],video: String,Pdf: String) {
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
    func disLikeContent() {}
    func likeContent() {}
    
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
    func ViewContent(ContentID: Int, completionHandler: (content:Content) -> ()){
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://bemyeyes.co/API/content/contentdetails.php")!)
        request.HTTPMethod = "POST"
        let postString = "cid=\(ContentID)"
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
}
