//
//  FeedTableViewCell.swift
//  KinbowConnect
//
//  Created by 9spl on 15/12/16.
//  Copyright © 2016 ioshero. All rights reserved.
//

import UIKit

class FeedImageCell: UITableViewCell {
    //MARK: - Variable Declaration
    @IBOutlet weak var imgProfilePic: UIImageView!
    @IBOutlet weak var imgTimeline: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblDescription: ContextLabel!
    
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var btnComment: UIButton!
    @IBOutlet weak var btnShare: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
