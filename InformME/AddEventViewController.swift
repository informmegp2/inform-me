//
//  AddEventViewController.swift
//  InformME
//
//  Created by nouf abdullah on 4/28/1437 AH.
//  Copyright © 1437 King Saud University. All rights reserved.
//

import UIKit

class AddEventViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var EventLogoo: UIButton!
    @IBOutlet var EventLogo: UIImageView!
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

    @IBAction func uploadImage(sender: AnyObject) {
        print("button pressed")
        var myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(myPickerController, animated: true, completion: nil)
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func  myImageUploadRequest(){
        
    }
    
    
   
    
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
        
    {
        EventLogoo.setBackgroundImage(info[UIImagePickerControllerOriginalImage] as? UIImage, forState: .Normal)
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
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
            print(EventName.text)
            var e : Event = Event()
            e.AddEvent (name, web: website, date: date, logo: EventLogoo.backgroundImageForState(.Normal)!)
                    }
     
        
    }
    
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
