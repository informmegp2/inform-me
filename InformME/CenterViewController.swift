//
//  CenterViewController.swift
//  InformME
//
//  Created by Amal Ibrahim on 4/23/16.
//  Copyright © 2016 King Saud University. All rights reserved.
//

import UIKit

@objc
protocol CenterViewControllerDelegate {
    optional func toggleAttendeePanel()
    optional func toggleOrganizerPanel()
    optional func collapseSidePanels()
}

class CenterViewController: UIViewController {

    var delegate: CenterViewControllerDelegate?
    
    // MARK: Button actions
    
    @IBAction func AttendeeMenuTapped(sender: AnyObject) {
        delegate?.toggleOrganizerPanel?()
    }
    @IBAction func OrganizerMenuTapped(sender: AnyObject) {
        delegate?.toggleOrganizerPanel?()
    }
}