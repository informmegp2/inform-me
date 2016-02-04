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

    func requesteventlist() {}
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
    func AddEvent(event: Event){}
    func requestTodeleteEvent(){}
    func DeleteEvent(){}
    func requestToUpdateEvent(){}
    func updateEvent(){}
    
    

}