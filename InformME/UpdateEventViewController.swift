//
//  UpdateEventViewController.swift
//  InformME
//
//  Created by Amal Ibrahim on 2/9/16.
//  Copyright © 2016 King Saud University. All rights reserved.
//

import Foundation

//
//  EventDetailsViewController.swift
//  InformME
//
//  Created by Amal Ibrahim on 2/9/16.
//  Copyright © 2016 King Saud University. All rights reserved.
//

import Foundation
import UIKit

class UpdateEventViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var EventDate: UITextField!
    @IBOutlet var EventWebsite: UITextField!
    @IBOutlet var EventName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        EventDate.delegate = self
        EventWebsite.delegate = self
        EventName.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func save(sender: AnyObject) {
        var name = EventName.text!
        var website = EventWebsite.text!
        var  date = EventDate.text!
        
        if (EventName.text == "" || EventDate.text == "") {
            let alert = UIAlertController(title: "", message: " يرجى إكمال كافة الحقول", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "موافق", style: .Default, handler: { (action) -> Void in
                
                self.dismissViewControllerAnimated(true, completion: nil)
                
            }))
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else {
            var e : Event = Event()
            //TODO: نوف عدلي هذا لحق الابديت بدال الاد
            //e.AddEvent (name, web: website, date: date, logo:)
        }
    }}