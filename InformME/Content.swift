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
var Pdf: NSData = NSData() //this will be changed depending on our chosen type.
var likes: Like = Like()
var dislikes:Dislike = Dislike()
var comments: [Comment] = []

    
    func saveContent() {}
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