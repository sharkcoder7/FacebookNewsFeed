//
//  FeedTextCell.swift
//  KinbowConnect
//
//  Created by  on 09/03/17.
//  Copyright © 2017 ioshero. All rights reserved.
//

import UIKit

class FeedTextCell: UITableViewCell {
    //MARK: - Variable Declaration
    @IBOutlet weak var imgProfilePic: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblDescription: ContextLabel!
    
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var btnComment: UIButton!
    @IBOutlet weak var btnShare: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
