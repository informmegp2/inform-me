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
    var labels = [String]()
    var UID = [String]()
    var UserID: Int = NSUserDefaults.standardUserDefaults().integerForKey("id");
    
    var cellContent = [String]()
    var numRow:Int?
    
    
    // Update beacon
    @IBAction func Submit(sender: AnyObject) {
        
        
        let minor = Minor.text!
        let llabel = Label.text!
        let  major = Major.text!
        
        if (self.Label.text == "" || self.Major.text == "" || self.Minor.text == "") {
            let alert = UIAlertController(title: "", message: " يرجى إكمال كافة الحقول", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "موافق", style: .Default, handler: { (action) -> Void in
                
                // self.dismissViewControllerAnimated(true, completion: nil)
                
            }))
            self.presentViewController(alert, animated: true, completion: nil)
        }        else {
            let index =  labels.indexOf(llabel)!
            labels.removeAtIndex(index)
            if UID.contains(String(UserID)) && labels.contains(llabel) {
                let alert = UIAlertController(title: "", message: " إسم البيكون مستخدم مسبقا \n الرجاء إختيار إسم أخر ", preferredStyle: UIAlertControllerStyle.Alert)
                
                alert.addAction(UIAlertAction(title: "موافق", style: .Default, handler: { (action) -> Void in
                }))
                
                self.presentViewController(alert, animated: true, completion: nil)
            }
            else {
                
                let alertController = UIAlertController(title: "", message: " هل أنت متأكد من رغبتك بحفظ التغييرات؟", preferredStyle: .Alert)
                
                // Create the actions
                let okAction = UIAlertAction(title: "موافق", style: UIAlertActionStyle.Default) {
                    UIAlertAction in
                    NSLog("OK Pressed")
                    
                    let b : Beacon = Beacon()
                    b.updateBeacon (llabel, major: major,minor:minor ,Temp: self.temp)
                    // (flag:Bool) in
                    //we should perform all segues in the main thread
                    // dispatch_async(dispatch_get_main_queue()) {
                    if (b.save){
                        self.performSegueWithIdentifier("alertPressedOK", sender:sender)} }
                
                
                
                
                let cancelAction = UIAlertAction(title: "إلغاء الأمر", style: UIAlertActionStyle.Cancel) {
                    UIAlertAction in
                    NSLog("Cancel Pressed")
                }
                // Add the actions
                alertController.addAction(okAction)
                alertController.addAction(cancelAction)
                
                // Present the controller
                self.presentViewController(alertController, animated: true, completion: nil)
            }
        }}
    override func viewDidLoad() {
        super.viewDidLoad()
        self.Label.text = llabel
        self.Major.text = mmajor
        self.Minor.text = mminor
        temp = llabel
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    var window:UIWindow!
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print ("???????")
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let containerViewController = ContainerViewController()
        containerViewController.centerViewController = mainStoryboard().instantiateViewControllerWithIdentifier("beaconsMng") as? CenterViewController
        print(window!.rootViewController)
        
        window!.rootViewController = containerViewController
        print(window!.rootViewController)
        
        window!.makeKeyAndVisible()
        containerViewController.centerViewController.delegate?.collapseSidePanels!()
        
    }
    
    
    func mainStoryboard() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()) }
    

    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
