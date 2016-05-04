//
//  AttendeeHomeViewController.swift
//  InformME
//
//  Created by Amal Ibrahim on 2/9/16.
//  Copyright © 2016 King Saud University. All rights reserved.
//

import UIKit
import Foundation

class AttendeeHomeViewController: CenterViewController {
    
    
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
    }
    var window:UIWindow!
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let containerViewController = ContainerViewController()
        if(segue.identifier == "nearby"){
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