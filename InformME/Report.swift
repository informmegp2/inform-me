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
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://bemyeyes.co/API/viwereport.php")!)
        request.HTTPMethod = "POST"
        let postString = "uid=\(event.id)"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if let urlContent = data {
                
                do {
                    
                    let jsonResult = try NSJSONSerialization.JSONObjectWithData(urlContent, options: NSJSONReadingOptions.MutableContainers)
                    
                    for var x=0; x<jsonResult.count;x++ {
                        let item = jsonResult[x]
                        let c : Content = Content()
                        
                        _ = item["ContentID"] as! String
                        c.Title = item["Title"] as! String
                        c.likes.counter = Int(item["Likes"] as! String)!
                        c.dislikes.counter = Int(item ["DisLikes"] as! String)!
                        
                        var comments: [Comment] = []
                        let itemC = item["Comments"] as! NSArray
                        for var i=0; i<itemC.count;i++ {
                            let comment: Comment = Comment()
                            comment.comment = itemC[i]["CommentText"] as! String
                            comment.user.username = itemC[i]["UserID"] as! String
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