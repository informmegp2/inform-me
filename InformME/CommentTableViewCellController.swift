//
//  CommentTableViewCellController.swift
//  InformME
//
//  Created by Amal Ibrahim on 2/20/16.
//  Copyright © 2016 King Saud University. All rights reserved.
//

import Foundation
import UIKit

class CommentTableViewCellController: UITableViewCell {
    @IBOutlet var comment: UILabel!
    @IBOutlet var user: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
}