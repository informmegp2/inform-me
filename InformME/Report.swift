//
//  Report.swift
//  InformME
//
//  Created by Amal Ibrahim on 2/4/16.
//  Copyright © 2016 King Saud University. All rights reserved.
//

import Foundation
class Report {
    
    func viewReport(event: Event,completionHandler: (contents:[Content]) -> ()){
        var contents: [Content] = []
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://bemyeyes.co/API/viewreport.php")!)
        request.HTTPMethod = "POST"
        let postString = "uid=\(event.id)"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if let urlContent = data {
                
                do {
                    
                    let jsonResult = try NSJSONSerialization.JSONObjectWithData(urlContent, options: NSJSONReadingOptions.MutableContainers)
                    
                    for x in 0 ..< jsonResult.count {
                        let item = jsonResult[x] as AnyObject
                        let c : Content = Content()
                        
                        _ = item["ContentID"] as! String
                        c.Title = item["Title"] as! String
                        if item["Likes"] is NSNull  {
                            c.likes.counter = 0
                            c.dislikes.counter = 0
                        }
                        else{
                        c.likes.counter = Int(item["Likes"] as! String)!
                        c.dislikes.counter = Int(item ["DisLikes"] as! String)!
                        }
                        if item["ShareCounter"] != nil  {
                            c.shares = Int(item["ShareCounter"] as! String)!
                        }
                        else {
                             c.shares = 0
                            }
                        var comments: [Comment] = []
                        let itemC = item["Comments"] as! NSArray
                        for i in 0 ..< itemC.count {
                            let comment: Comment = Comment()
                            comment.comment = itemC[i]["CommentText"] as! String
                            comment.user.username = itemC[i]["UserName"] as! String
                            comments.append(comment)
                        }
                        c.comments = comments
                        contents.append(c)
                        print("DONE")
                    }
                } catch {
                    
                    print("JSON serialization failed")
                    
                }
                
                
            }
            
            completionHandler(contents: contents)
        }
        task.resume()
    }
}