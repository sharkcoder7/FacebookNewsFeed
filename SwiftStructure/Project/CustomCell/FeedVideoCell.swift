//
//  FeedVideoCell.swift
//  KinbowConnect
//
//  Created by  on 23/02/17.
//  Copyright © 2017 ioshero. All rights reserved.
//

import UIKit
import AVFoundation

class FeedVideoCell: UITableViewCell {
    //MARK: - Variable Declaration
    @IBOutlet weak var imgProfilePic: UIImageView!
    @IBOutlet weak var imgTimeline: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblDescription: ContextLabel!
    
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var btnComment: UIButton!
    @IBOutlet weak var btnShare: UIButton!
    
    @IBOutlet var btnPlay: UIButton!
    @IBOutlet var btnVideo: UIButton!   //To show/hide play/pause
    
    @IBOutlet var viewVideo: UIView!
    var avPlayer: AVPlayer?
    var avPlayerLayer: AVPlayerLayer?
    var paused: Bool = false
    
    @IBOutlet var btnCelebrity: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //self.avPlayerLayer?.frame = self.imgTimeline.bounds
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


