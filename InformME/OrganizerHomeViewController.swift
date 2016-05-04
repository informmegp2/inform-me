//
//  OrganizerHomeViewController.swift
//  InformME
//
//  Created by Amal Ibrahim on 2/5/16.
//  Copyright © 2016 King Saud University. All rights reserved.
//

import Foundation

import UIKit

class OrganizerHomeViewController: CenterViewController  {
    @IBOutlet weak var menuButton: UIBarButtonItem!
    /*Hello : ) */
    override func viewDidLoad() {
        super.viewDidLoad()

        //setup tint color for tha back button.
    }
    
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
        if(segue.identifier != "backtologin") {
            containerViewController.centerViewController.delegate?.collapseSidePanels!()
            
        }
        
    }
    
    func mainStoryboard() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()) }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
}

}