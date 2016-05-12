//
//  menuTable.swift
//  InformME
//
//  Created by Amal Ibrahim on 3/28/16.
//  Copyright © 2016 King Saud University. All rights reserved.
//

import UIKit

class menuTable: UITableViewController {
    @IBOutlet weak var logout: UITableViewCell!
    
    @IBOutlet var table: UITableView!

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedCell = tableView.cellForRowAtIndexPath(indexPath)
        if(selectedCell == logout){
            if(Reachability.isConnectedToNetwork()){
                out()
            }
            else{
                self.displayAlert("", message: "الرجاء الاتصال بالانترنت")
            }
            }
    }
    func displayAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction((UIAlertAction(title: "موافق", style: .Default, handler: { (action) -> Void in
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        })))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
        
    }//end fun display alert
    
    @IBAction func out() {
        
        
        print(" iam in 1")
        
        var flag: Bool
        flag = false
        
        
        
        let current: Authentication = Authentication();
        
        current.logout(){
            (login:Bool) in
            
            dispatch_async(dispatch_get_main_queue()) {
                
                flag = login
                if(flag) {
                    self.view.window!.rootViewController?.dismissViewControllerAnimated(false, completion: nil)
                self.performSegueWithIdentifier("backtologin", sender: self)
                    print("I am happy",login,flag) }
                
            }
            print("I am Here")  }
        
        
    } //end out */
    var window:UIWindow!
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let containerViewController = ContainerViewController()
        if(segue.identifier == "orgMain"){
        containerViewController.centerViewController = mainStoryboard().instantiateViewControllerWithIdentifier("CenterViewController1") as? CenterViewController
        print(window!.rootViewController)
        
        window!.rootViewController = containerViewController
        print(window!.rootViewController)
        
        window!.makeKeyAndVisible()
        }
        else  if(segue.identifier == "events"){
            containerViewController.centerViewController = mainStoryboard().instantiateViewControllerWithIdentifier("eventsMng") as? CenterViewController
            print(window!.rootViewController)
            
            window!.rootViewController = containerViewController
            print(window!.rootViewController)
            
            window!.makeKeyAndVisible()
        }
        else  if(segue.identifier == "beacons"){
            containerViewController.centerViewController = mainStoryboard().instantiateViewControllerWithIdentifier("beaconsMng") as? CenterViewController
            print(window!.rootViewController)
            
            window!.rootViewController = containerViewController
            print(window!.rootViewController)
            
            window!.makeKeyAndVisible()
        }
        else  if(segue.identifier == "profile"){
            containerViewController.centerViewController = mainStoryboard().instantiateViewControllerWithIdentifier("profileMng") as? CenterViewController
            print(window!.rootViewController)
            
            window!.rootViewController = containerViewController
            print(window!.rootViewController)
            
            window!.makeKeyAndVisible()
        }
        else  if(segue.identifier == "nearby"){
            containerViewController.centerViewController = mainStoryboard().instantiateViewControllerWithIdentifier("nearby") as? CenterViewController
            print(window!.rootViewController)
            
            window!.rootViewController = containerViewController
            print(window!.rootViewController)
            
            window!.makeKeyAndVisible()
        }
        else  if(segue.identifier == "profile1"){
            containerViewController.centerViewController = mainStoryboard().instantiateViewControllerWithIdentifier("proflie") as? CenterViewController
            print(window!.rootViewController)
            
            window!.rootViewController = containerViewController
            print(window!.rootViewController)
            
            window!.makeKeyAndVisible()
        }
        else  if(segue.identifier == "fav"){
            containerViewController.centerViewController = mainStoryboard().instantiateViewControllerWithIdentifier("favorite") as? CenterViewController
            print(window!.rootViewController)
            
            window!.rootViewController = containerViewController
            print(window!.rootViewController)
            
            window!.makeKeyAndVisible()
        }
        else  if(segue.identifier == "attendeeMain"){
            containerViewController.centerViewController = mainStoryboard().instantiateViewControllerWithIdentifier("CenterViewController2") as? CenterViewController
            print(window!.rootViewController)
            
            window!.rootViewController = containerViewController
            print(window!.rootViewController)
            
            window!.makeKeyAndVisible()
        }
        if(segue.identifier != "backtologin") {
            containerViewController.centerViewController.delegate?.collapseSidePanels!()

        }

    }
   
    func mainStoryboard() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()) }
    
}
