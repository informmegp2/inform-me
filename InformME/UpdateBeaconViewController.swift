//
//  UpdateBeaconViewController.swift
//  InformME
//
//  Created by Amal Ibrahim on 2/9/16.
//  Copyright © 2016 King Saud University. All rights reserved.
//

import Foundation
import UIKit
class UpdateBeaconViewController: UIViewController , UITextFieldDelegate{
    
    @IBOutlet  var Label: UITextField!
    @IBOutlet  var Major: UITextField!
    @IBOutlet  var Minor: UITextField!
    
    var mmajor:String=""
    var mminor:String=""
    var llabel:String=""
    var temp:String=""
    
    var cellContent = [String]()
    var numRow:Int?
    
    
    @IBAction func Submit(sender: AnyObject) {
        
        
        var minor = Minor.text!
        var llabel = Label.text!
        var  major = Major.text!
        var flag : Bool = false
        
        if (self.Label.text == "self." || self.Major.text == "" || self.Minor.text == "") {
            let alert = UIAlertController(title: "", message: " يرجى إكمال كافة الحقول", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "موافق", style: .Default, handler: { (action) -> Void in
                
                // self.dismissViewControllerAnimated(true, completion: nil)
                
            }))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        var alertController = UIAlertController(title: "", message: " هل أنت متأكد من رغبتك بحفظ التغييرات؟", preferredStyle: .Alert)
        
        // Create the actions
        var okAction = UIAlertAction(title: "موافق", style: UIAlertActionStyle.Default) {
            UIAlertAction in
            NSLog("OK Pressed")
            
            var b : Beacon = Beacon()
            b.updateBeacon (llabel, major: major,minor:minor , Temp: self.temp)
         

//            let destinationController = storyboard!.instantiateViewControllerWithIdentifier("alertPressedOK")
  //          presentViewController(destinationController, animated: true, completion: nil)
            self.performSegueWithIdentifier("alertPressedOK", sender:sender)

            
        }
    
        var cancelAction = UIAlertAction(title: "إلغاء الأمر", style: UIAlertActionStyle.Cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }
          // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        // Present the controller
        self.presentViewController(alertController, animated: true, completion: nil)
    
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.Label.text = llabel
        self.Major.text = mmajor
        self.Minor.text = mminor
        temp = llabel
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
