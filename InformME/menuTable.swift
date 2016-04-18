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
            out()}
    }
    
    func out() {
        
        
        print(" iam in 1")
        
        var flag: Bool
        flag = false
        
        
        
        let current: Authentication = Authentication();
        
        current.logout(){
            (login:Bool) in
            
            dispatch_async(dispatch_get_main_queue()) {
                
                flag = login
                if(flag) {
                    
                self.performSegueWithIdentifier("backtologin", sender: self)
                    
                    
                    print("I am happy",login,flag) }
                
            }
            print("I am Here")  }
        
        
        
        
        
        
    } //end out */
    
    
    
}
