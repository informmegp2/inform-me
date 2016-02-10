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
    
    @IBOutlet weak var Label: UITextField!
    @IBOutlet weak var Minor: UITextField!
    @IBOutlet weak var Major: UITextField!
    
    //var llabel:String?
    //var major:Int?
    //var minor:Int?
    var cellContent = [String]()
    var numRow:Int?
    
    
    @IBAction func Submit(sender: AnyObject) {
        
        var minor = Minor.text!
        var llabel = Label.text!
        var  major = Major.text!
        
        if (Minor.text == "" || Major.text == "" || llabel == "") {
            let alert = UIAlertController(title: "", message: " يرجى إكمال كافة الحقول", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "موافق", style: .Default, handler: { (action) -> Void in
                
                self.dismissViewControllerAnimated(true, completion: nil)
                
            }))
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else {
            var b : Beacon = Beacon()
            //TODO: ساره عدلي هذا لحق الابديت بدال الاد
            b.addBeacon (llabel, major: major,minor:minor)}
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        Minor.delegate = self
        Major.delegate = self
        Label.delegate = self
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
