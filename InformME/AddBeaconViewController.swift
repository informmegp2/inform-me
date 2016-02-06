//
//  BeaconViewController.swift
//  InformME
//
//  Created by sara on 4/24/1437 AH.
//  Copyright © 1437 King Saud University. All rights reserved.
//

import UIKit

class AddBeaconViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var Label: UITextField!
    @IBOutlet weak var Major: UITextField!
    @IBOutlet weak var Minor: UITextField!
    
    @IBOutlet weak var beaconText: UILabel!
    
    var llabel:String?
    var major:Int?
    var minor:Int?
    var cellContent = [String]()
    var numRow:Int?

    @IBAction func submit(sender: AnyObject) {
       minor = Int(Minor.text!)
       llabel = Label.text!
       major = Int(Major.text!)
       
        if (Minor.text == "" || Major.text == "" || llabel == "") {
            let alert = UIAlertController(title: "", message: " يرجى إكمال كافة الحقول", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "موافق", style: .Default, handler: { (action) -> Void in
                
                self.dismissViewControllerAnimated(true, completion: nil)
                
            }))
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else {
            AddBeacon (llabel!, Major :major!, Minor:minor!)}
      
    }
    override func viewDidLoad() {
        super.viewDidLoad()
   
        
            
        }
    
    
    
    func AddBeacon(Label:String , Major:Int , Minor:Int){

        let MYURL = NSURL(string:"http://bemyeyes.co/API/beacon/AddBeacon.php")
        let request = NSMutableURLRequest(URL:MYURL!)
     
        request.HTTPMethod = "POST";
        
        //Change UserID"
        
        let postString = "Label="+llabel!+"&Major=+ \(Major)&Minor=+ \(Minor)&UserID=1"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding);
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil
            {
                print("error=\(error)")
                return
            }
            
            // You can print out response object
            print("response = \(response)")
            
            
            
        }
        
        task.resume()
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
