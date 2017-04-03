//
//  ProfileFeedsVC.swift
//  KinbowConnect
//
//  Created by ioshero on 3/3/17.
//  Copyright © 2017 ioshero. All rights reserved.
//

import UIKit
import AVFoundation

let cell_Height_Feed  =   100

class FeedsVC: UIViewController,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate {

    //MARK: - Variable Declaration
    @IBOutlet var tblList: UITableView!
    
    var arrFeedData = [AnyObject]()
    
    var visibleCells = [UITableViewCell]()
    var currentPlayIndex = Int()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.loadDatafromJSON()
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.stopAllAudioVideoPlayer()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- setup UI
    func setupUI() {
        tblList.estimatedRowHeight = CGFloat(cell_Height_Feed)
        tblList.rowHeight = UITableViewAutomaticDimension
        tblList.tableFooterView = UIView()
        
        tblList.register(UINib(nibName: "FeedImageCell", bundle: nil), forCellReuseIdentifier: "FeedImageCell")
        tblList.register(UINib(nibName: "FeedTextCell", bundle: nil), forCellReuseIdentifier: "FeedTextCell")
        tblList.register(UINib(nibName: "FeedVideoCell", bundle: nil), forCellReuseIdentifier: "FeedVideoCell")
    }
    
    //MARK:- Load Data from JSON
    func loadDatafromJSON()
    {
        let dictFeeds = loadJson(forFilename: "feedMaster") as! [String : AnyObject]
        self.arrFeedData = dictFeeds["result"] as! [AnyObject]
    }
    
    //MARK:- TableView DataSource and Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection sectionIndex: Int) -> Int {
        return self.arrFeedData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var dicData = [String : AnyObject]()
        dicData = self.arrFeedData[indexPath.row ] as! [String : AnyObject]
        
        let mediaType = dicData["feedMediaType"] as! NSNumber
        switch mediaType.intValue {
        case 1:   //Image
            let CellIdentifier = "FeedImageCell"
            let cell  = (self.tblList!.dequeueReusableCell(withIdentifier: CellIdentifier) as? FeedImageCell)!
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            
            cell.lblName.text = "\(dicData["name"] as! String)"
            cell.imgProfilePic.image = UIImage(named: dicData["profileImage"] as! String)
            
            let arrFeedMedia = dicData["feedMedia"] as! [AnyObject]
            cell.imgTimeline.image = UIImage(named: arrFeedMedia[0]["url"] as! String)
            let index = IndexPath(row: indexPath.row , section: indexPath.section)
            self.configureImageCell(cell: cell, atIndex: index , dicData: dicData)
            return cell
            
        case 2: //Text
            let CellIdentifier = "FeedTextCell"
            let cell  = self.tblList!.dequeueReusableCell(withIdentifier: CellIdentifier) as? FeedTextCell
            cell?.selectionStyle = UITableViewCellSelectionStyle.none
            
            cell?.lblName.text = "\(dicData["name"] as! String)"
            //cell.imgProfilePic.image = UIImage(named: dicData["profileImage"] as! String)?.af_imageRoundedIntoCircle()
            cell?.imgProfilePic.image = UIImage(named: dicData["profileImage"] as! String)
            
            let index = IndexPath(row: indexPath.row , section: indexPath.section)
            self.configureTextCell(cell: cell!, atIndex: index, dicData: dicData)
            return cell!
            
        case 3: //Video
            let CellIdentifier = "FeedVideoCell"
            let cell  = self.tblList!.dequeueReusableCell(withIdentifier: CellIdentifier) as? FeedVideoCell
            cell?.selectionStyle = UITableViewCellSelectionStyle.none
            
            cell?.lblName.text = "\(dicData["name"] as! String)"
            cell?.imgProfilePic.image = UIImage(named: dicData["profileImage"] as! String)
            
            let index = IndexPath(row: indexPath.row , section: indexPath.section)
            self.configureVideoCell(cell: cell!, indexpath: index, dicData: dicData)
            return cell!
            
        default:
            break;
        }
        let cell = UITableViewCell()
        return cell
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        autoPlayVideo()
    }
    
    //MARK:- Configure Cells
    //MARK: Image Cell
    func configureImageCell( cell : FeedImageCell, atIndex: IndexPath ,dicData: [String : AnyObject])
    {
        let date = getDateInDefaultFormat(date: dicData["feedDate"] as! String, dateFormat: dateTimeFormatDefault, dateStyle: .medium,timeStyle : .short, isDisplayTime: true)
        cell.lblDate.text = date
        
        cell.lblDescription.text = "\(dicData["feedTitle"] as! String)"
        let tapGesture =  UITapGestureRecognizer(target: self, action:  #selector (self.handleTapGesture(_:)))
        cell.lblDescription.addGestureRecognizer(tapGesture)
    }
	
    //MARK: Text Cell
    func configureTextCell( cell : FeedTextCell, atIndex: IndexPath ,dicData: [String : AnyObject])
    {
        let date = getDateInDefaultFormat(date: dicData["feedDate"] as! String, dateFormat: dateTimeFormatDefault, dateStyle: .medium,timeStyle : .short, isDisplayTime: true)
        cell.lblDate.text = date
        
        cell.lblDescription.text = "\(dicData["feedTitle"] as! String)"
        let tapGesture =  UITapGestureRecognizer(target: self, action:  #selector (self.handleTapGesture(_:)))
        cell.lblDescription.addGestureRecognizer(tapGesture)
    }
	
    //MARK: Video Cell
    func configureVideoCell(cell : FeedVideoCell, indexpath: IndexPath,dicData : [String : AnyObject])
    {
        let date = getDateInDefaultFormat(date: dicData["feedDate"] as! String, dateFormat: dateTimeFormatDefault, dateStyle: .medium,timeStyle : .short, isDisplayTime: true)
        cell.lblDate.text = date
        
        cell.lblDescription.text = "\(dicData["feedTitle"] as! String)"
        let tapGesture =  UITapGestureRecognizer(target: self, action:  #selector (self.handleTapGesture(_:)))
        cell.lblDescription.addGestureRecognizer(tapGesture)
		
        cell.btnPlay.tag = indexpath.row
        cell.btnPlay.addTarget(self, action: #selector(btnTappedPlay(_:)), for: UIControlEvents.touchUpInside)
        
        if cell.avPlayer == nil {
            var arrFeedMedia = [AnyObject]()
            arrFeedMedia = self.arrFeedData[indexpath.row]["feedMedia"] as! [AnyObject]
            
            let videoName  = arrFeedMedia[0]["url"] as! String
            let avasset = AVAsset(url: URL(string: videoName)!)
            let item = AVPlayerItem(asset: avasset)
            cell.avPlayer = AVPlayer(playerItem: item)
            cell.avPlayerLayer = AVPlayerLayer(player: cell.avPlayer)
            cell.avPlayerLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
            cell.avPlayerLayer?.frame = CGRect (x: (cell.avPlayerLayer?.frame.origin.x)!, y: (cell.avPlayerLayer?.frame.origin.y)!, width: self.view.frame.size.width-30.0, height: (self.view.frame.size.width-30.0)/1.5)
            cell.viewVideo.layer.addSublayer(cell.avPlayerLayer!)
        }
    }
    
    //MARK: - Media Play from Cell
    func btnTappedPlay(_ button : UIButton)
    {
        let cell =  self.tblList.cellForRow(at: IndexPath(row: button.tag  , section: 0)) as! FeedVideoCell
        
        if button.isSelected {
            cell.avPlayer?.pause()
        }
        else {
            self.stopAllAudioVideoPlayer()
            
            var arrFeedMedia = [AnyObject]()
            arrFeedMedia = self.arrFeedData[button.tag]["feedMedia"] as! [AnyObject]
            
            let videoName  = arrFeedMedia[0]["url"] as! String
            let videoURL = NSURL(string: videoName)
            let item = AVPlayerItem(url: videoURL as! URL)
            
            NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: item)
            
            if cell.avPlayer != nil {
                cell.avPlayer?.play()
            }
            else {
                cell.avPlayer = AVPlayer(playerItem: item)
                cell.avPlayerLayer = AVPlayerLayer(player: cell.avPlayer)
                cell.avPlayerLayer?.frame = cell.imgTimeline.bounds
                cell.avPlayerLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
                cell.viewVideo.layer.addSublayer(cell.avPlayerLayer!)
                cell.avPlayer?.play()
            }
        }
        cell.btnPlay.isSelected = !cell.btnPlay.isSelected
    }
	
    func autoPlayVideo()
    {
        visibleCells.removeAll()
        visibleCells = tblList.visibleCells
        
        for item in visibleCells {
            currentPlayIndex = tblList.indexPath(for: item)!.row
            var dictData : [String : AnyObject]
            dictData = self.arrFeedData[currentPlayIndex] as! [String : AnyObject]
            
            let mediaType = dictData["feedMediaType"] as! NSNumber
            if (mediaType.intValue == 3)
            {
                let cellRect = tblList.rectForRow(at: tblList.indexPath(for: item)!)
                if tblList.bounds.contains(cellRect)
                {
                    let visibleCell2 = tblList.cellForRow(at: tblList.indexPath(for: item)!) as! FeedVideoCell
                    //visibleCell2.btnPlay.isHidden = true
                    visibleCell2.btnPlay.isSelected = true
                    visibleCell2.avPlayer?.play()
                }
                else {
                    let visibleCell1 = tblList.cellForRow(at: tblList.indexPath(for: item)!) as! FeedVideoCell
                    //visibleCell1.btnPlay.isHidden = false
                    visibleCell1.btnPlay.isSelected = false
                    visibleCell1.avPlayer?.pause()
                }
            }
        }
    }
    
    //MARK: - Stop All Cell Media Player
    func stopAllAudioVideoPlayer()
    {
        var dicData = [String : AnyObject]()
        var arrData = [AnyObject]()
        arrData = self.arrFeedData
        
        for j in 0..<self.tblList.numberOfRows(inSection: 0)
        {
            dicData = arrData[j] as! [String : AnyObject]
            let mediaType = dicData["feedMediaType"] as! NSNumber
            
            if mediaType.intValue == 3 {
                if let cell = self.tblList.cellForRow(at: IndexPath(row: j, section: 0)) as? FeedVideoCell {
                    cell.avPlayer?.pause()
                    cell.btnPlay.isSelected = false
                }
                else {
                    let cell = self.tblList.dequeueReusableCell(withIdentifier: "FeedVideoCell", for: IndexPath(row: j, section: 0)) as! FeedVideoCell
                    cell.avPlayer?.pause()
                    cell.btnPlay.isSelected = false
                }
            }
        }
    }
    
    //MARK: - Handle AVPlayerDidEnd Playing
    func playerDidFinishPlaying( _ notification : Notification) {
    }
    
    //MARK:- Handle tapGesture on HashTag
    func handleTapGesture(_ sender:UITapGestureRecognizer) {
        let context = sender.view as! ContextLabel
        if context.selectedLinkResult != nil {
        }
    }
}
