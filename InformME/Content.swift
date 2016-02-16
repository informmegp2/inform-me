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
    
    
    func saveContent(title: String,abstract: String ,video: String,Pdf: String) {
        let eid=1
        let l = "be"
        let SC = 1
        let cid = 1
        
        
        let MYURL = NSURL(string:"http://bemyeyes.co/API/content/AddContent.php")
        let MYURL1 = NSURL(string:"http://bemyeyes.co/API/content/AddPDF.php")
        let MYURL2  = NSURL(string:"http://bemyeyes.co/API/content/AddVideo.php")
        
        let request = NSMutableURLRequest(URL:MYURL!)
        let request1 = NSMutableURLRequest(URL:MYURL1!)
        let request2 = NSMutableURLRequest(URL:MYURL2!)
        
        request.HTTPMethod = "POST";
        request1.HTTPMethod = "POST";
        request2.HTTPMethod = "POST";
        
        
        //Change eid , label , cid"
        
        let postString = "Title="+title+"&Abstract="+abstract+"&ShareCounter=\(SC)&Label=\(l)&EventID=\(eid)"
        let postString1 = "PDF="+Pdf+"&CID=\(cid)"
        let postString2 = "Video="+video+"&CID=\(cid)"
        
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding);
        request1.HTTPBody = postString1.dataUsingEncoding(NSUTF8StringEncoding);
        request2.HTTPBody = postString2.dataUsingEncoding(NSUTF8StringEncoding);
        
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil
            {
                print("error=\(error)")
                return
            }
            print("response = \(response)")
        }
        let task1 = NSURLSession.sharedSession().dataTaskWithRequest(request1) {
            data, response, error in
            
            if error != nil
            {
                print("error=\(error)")
                return
            }
            print("response = \(response)")
        }
        let task2 = NSURLSession.sharedSession().dataTaskWithRequest(request2) {
            data, response, error in
            
            if error != nil
            {
                print("error=\(error)")
                return
            }
            print("response = \(response)")
        }
        
        task.resume()
        task1.resume()
        task2.resume()
        
    }
    
    func updateContent(title: String,abstract: String ,images: [UIImage],video: String,Pdf: NSData) {}
    func shareContent() {}
    func createContent(title: String,abstract: String ,images: [UIImage],video: String,Pdf: NSData) {}
    func requestToDeleteComment() {}
    func deleteComment(comment: Comment) {}
    func disLikeContent() {}
    func likeContent() {}
    func requestToAddComment() {}
    func saveComment(comment: Comment) {}
    
}