//
//  EventTableCell.swift
//  InformME
//
//  Created by Amal Ibrahim on 2/5/16.
//  Copyright © 2016 King Saud University. All rights reserved.
//

import Foundation
import UIKit

@objc protocol EventCellDelegate: class {
    func showEventDetails()
}
class EventTableCellViewController: UITableViewCell {
    var delegate:EventCellDelegate?

}