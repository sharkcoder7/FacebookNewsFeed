//
//  utility.swift
//  Swift Structure
//
//  Created by ioshero on 03/08/16.
//  Copyright © 2016 ioshero. All rights reserved.
//

import Foundation
import AVFoundation
import AVKit

//MARK: - Log(Print) Utility -
func logD(_ message:Any,
          file: String = #file, line: Int = #line,function: String = #function) {
    let str  : NSString = file as NSString
    #if DEBUG
        print("[\(str.lastPathComponent)][\(line)][\(function)]\n💜\(message)💜\n")
    #endif
}

//MARK: - User Default -
//Set Value
func setToUserDefaultForKey(_ value:AnyObject?,key:String)
{
    UserDefaults.standard.set(value, forKey: key)
    UserDefaults.standard.synchronize()
}

//Get Value
func getFromUserDefaultForKey(_ key:String)->AnyObject?
{
    return UserDefaults.standard.object(forKey: key) as AnyObject?
}

//MARK: - UIView -
//Border
func setDefaultBorder(_ view : UIView, color : UIColor, width : CGFloat)
{
    view.layer.borderColor = color.cgColor
    view.layer.borderWidth = width
}

//Set Borders -
func setBorders(_ arrViews: [UIView], color : UIColor, radius : CGFloat, width : CGFloat)
{
    for view in arrViews
    {
        view.layer.borderWidth = width
        view.layer.borderColor = color.cgColor
        view.layer.masksToBounds = true
        view.layer.cornerRadius = radius
    }
}

func setCornerRadius(_ arrViews : [UIView], radius : CGFloat)
{
    for view in arrViews
    {
        view.layer.masksToBounds = true
        view.layer.cornerRadius = radius
    }
}

//MARK: - Set TextField Indicator Right/Left View -
func setTextFieldsIndicator(_ txtFields : [UITextField], position: Int)
{
    //position = 0 = left side, position = 1 = right side
    for txtField : UITextField in txtFields
    {
        let imgView = UIImageView (image: UIImage (named: "down_drop"))
        
        if (position==1)
        {   
            txtField.rightViewMode = UITextFieldViewMode.always
            imgView.frame = CGRect(x: 0.0, y: 0.0, width: 30.0, height: 20.0)
            imgView.contentMode = UIViewContentMode.scaleAspectFit
            txtField.rightView = imgView;
        }
        else {
            imgView.image = UIImage (named: "down_drop")
            txtField.leftViewMode = UITextFieldViewMode.always
            imgView.frame = CGRect(x: 0.0, y: 0.0, width: 30.0, height: 20.0)
            imgView.contentMode = UIViewContentMode.scaleAspectFit
            txtField.leftView = imgView;
        }
    }
}

//Right Indicator
func setTextFieldIndicator(_ txtField : UITextField, imageView : UIImageView)
{
    txtField.rightViewMode = UITextFieldViewMode.always
    imageView.frame = CGRect(x: 0.0, y: 0.0, width: 30.0, height: 20.0)
    imageView.contentMode = UIViewContentMode.scaleAspectFit
    txtField.rightView = imageView;
}

//Left Margin
func setLeftPadding(_ txtField: UITextField)
{
    let view = UIView()
    view.frame = CGRect(x: 0.0, y: 0.0, width: 10, height: 20)
    txtField.leftViewMode = UITextFieldViewMode.always
    txtField.leftView = view
}

//MARK: - Date-Time Formattion -
func getDefaultTime(time: String, format : String) -> Date { //Convert String Time to NSDate
    let timeFormatOriginal = DateFormatter()
    timeFormatOriginal.dateStyle = DateFormatter.Style.none
    timeFormatOriginal.timeStyle = DateFormatter.Style.short
    timeFormatOriginal.timeZone = TimeZone.current
    timeFormatOriginal.dateFormat = format
    return timeFormatOriginal.date(from: time)!
}

func getDefaultTimeToStore(time: String, format : String) -> String {
    let timeFormatOriginal = DateFormatter()
    timeFormatOriginal.dateStyle = DateFormatter.Style.none
    timeFormatOriginal.timeStyle = DateFormatter.Style.short
    timeFormatOriginal.timeZone = TimeZone.current
    timeFormatOriginal.dateFormat = format
    
    let time24 = timeFormatOriginal.date(from: time)
    
    timeFormatOriginal.dateFormat = timeFormatDefault
    
    return timeFormatOriginal.string(from: time24!)
}

func getGMTDateTime(_ datetime: Date, format : String) -> String {
    let timezone: TimeZone = TimeZone.autoupdatingCurrent
    let seconds: Int = timezone.secondsFromGMT()
    //offset
    
    //let currentdate: NSDate = NSDate()
    let dateFormat: DateFormatter = DateFormatter()
    dateFormat.dateFormat = format
    // format
    
    dateFormat.timeZone = TimeZone(secondsFromGMT: seconds)
    return dateFormat.string(from: datetime)
}

func getDefaultDate(_ datetime: String, format : String) -> Date {
    let dateFormat: DateFormatter = DateFormatter()
    dateFormat.dateFormat = format
    //dateFormat.timeZone = NSTimeZone.localTimeZone()
    dateFormat.timeZone = TimeZone(identifier: "GMT")
    return dateFormat.date(from: datetime)!
}

func getDateInDefaultFormat(date: String, dateFormat : String, dateStyle : DateFormatter.Style, timeStyle : DateFormatter.Style, isDisplayTime: Bool) -> String {
    let datetimeFormatOriginal = DateFormatter()
    datetimeFormatOriginal.dateFormat = dateFormat
    
    let datetimeFormatDisplay = DateFormatter()
    datetimeFormatDisplay.timeZone = TimeZone.current
    if isDisplayTime {
        datetimeFormatDisplay.timeStyle = timeStyle
    }
    datetimeFormatDisplay.dateStyle = dateStyle
    
    return datetimeFormatDisplay.string(from: datetimeFormatOriginal.date(from: date)!)
}

//MARK: - ALERT -
func showMessage(_ title: String, message: String!, VC: UIViewController) {
    let alert : UIAlertController = UIAlertController(title: msg_TitleAppName, message: message, preferredStyle: UIAlertControllerStyle.alert)
    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
        UIAlertAction in
    }
    alert.addAction(okAction)
    VC.present(alert, animated: true, completion: nil)
}

func showMessageWithConfirm(_ title: String, message:String, okTitle:String?, cancelTitle:String?, okCompletion: ((UIAlertAction) -> Void)?,cancelCompletion:((UIAlertAction) -> Void)?)
{
    let alertController = UIAlertController(title: msg_TitleAppName, message: message, preferredStyle: UIAlertControllerStyle.alert)
    let OKAction = UIAlertAction(title: okTitle != nil ? okTitle: "Ok", style: UIAlertActionStyle.default, handler: okCompletion)
    let cancelAction = UIAlertAction(title: cancelTitle != nil ? cancelTitle: "Cancel", style: UIAlertActionStyle.default, handler: cancelCompletion)
    
    if (okCompletion != nil) {
        alertController.addAction(OKAction)
    }
    if (cancelCompletion != nil) {
        alertController.addAction(cancelAction)
    }
    alertController.show()
}

func showMessage(_ title: String, message: String!){
    let alertView:UIAlertView = UIAlertView()
    alertView.title = msg_TitleAppName    //title
    alertView.message = message
    //alertView.delegate = self
    alertView.addButton(withTitle: "OK")
    alertView.show()
}

//MARK: - Loading Cell
func showLoadingCell(_ indicatorColor:UIColor) -> UITableViewCell
{
    let cell = UITableViewCell(style: .default, reuseIdentifier: "LoadingCell")
    cell.backgroundColor = UIColor.clear
    cell.selectionStyle = .none
    cell.isUserInteractionEnabled = false
    
    //cell.textLabel?.text = msg_LoadingMore
    
    let actIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    actIndicator.color = indicatorColor
    //actIndicator.center = CGPoint(x: (UIScreen.mainScreen().bounds.size.width/2)-(actIndicator.bounds.size.width/2), y: cell.center.y)
    actIndicator.frame = CGRect(x: 20.0, y: 20.0, width: 20.0, height: 20.0)
    cell.contentView.addSubview(actIndicator)
    actIndicator.startAnimating()
    actIndicator.hidesWhenStopped = true
    
    //let lblLoading: UILabel     = UILabel(frame: CGRectMake(50, 0, cell.bounds.size.width-70.0, cell.bounds.size.height))
    let lblLoading: UILabel     = UILabel(frame: CGRect(x: 50, y: actIndicator.frame.origin.y, width: cell.bounds.size.width-70.0, height: 20.0))
    lblLoading.text             = msg_LoadingMore
    lblLoading.numberOfLines    = 0
    lblLoading.lineBreakMode    = NSLineBreakMode.byWordWrapping
    lblLoading.textColor        = UIColor.lightGray
    lblLoading.textAlignment    = .left   //.Center
    cell.contentView.addSubview(lblLoading)
    
    return cell
}

//MARK: - Add Pull to Refresh
func addPullToRefresh(_ tableView: UITableView, ctrlRefresh: inout UIRefreshControl?, targetController: UIViewController, refreshMethod: Selector)
{
    //let ctrlRefresh = UIRefreshControl()
    ctrlRefresh = UIRefreshControl()
    ctrlRefresh!.backgroundColor = UIColor.white
    ctrlRefresh!.tintColor = UIColor.blue
    ctrlRefresh!.attributedTitle = NSAttributedString(string: msg_PullToRefersh, attributes: [NSForegroundColorAttributeName: const_Color_Border_Default])
    ctrlRefresh!.addTarget(targetController, action: refreshMethod, for: .valueChanged)
    tableView.addSubview(ctrlRefresh!)
}

func checkRecordAvailableWithRefreshControl(_ arrData: [AnyObject], tableView: UITableView, ctrlRefresh: UIRefreshControl?, targetController: UIViewController, displayMessage: String)
{
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = DateFormatter.Style.short
    dateFormatter.timeStyle = DateFormatter.Style.long
    dateFormatter.dateFormat = "MMM d, h:mm a"
    let now = Date()
    let updateString = "Last Updated at " + dateFormatter.string(from: now)
    ctrlRefresh!.attributedTitle = NSAttributedString(string: updateString)
    
    //ctrlRefresh!.attributedTitle = NSAttributedString(string: msg_PullToRefersh, attributes: [NSForegroundColorAttributeName: const_Color_Border_Default])
    ctrlRefresh!.endRefreshing()
    
    if arrData.count > 0 {
        tableView.reloadData()
        tableView.backgroundView = nil
    }
    else {
        tableView.reloadData()
        
        let lblNoData: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
        lblNoData.text             = displayMessage
        lblNoData.numberOfLines    = 0
        lblNoData.lineBreakMode    = NSLineBreakMode.byWordWrapping
        lblNoData.textColor        = UIColor.lightGray
        lblNoData.textAlignment    = .center
        tableView.backgroundView = lblNoData
        tableView.separatorStyle = .none
    }
}

func checkRecordAvailable(_ arrData: [AnyObject], tableView: UITableView, targetController: UIViewController, displayMessage: String)
{
    if arrData.count > 0 {
        tableView.reloadData()
        tableView.backgroundView = nil
    }
    else {
        tableView.reloadData()
        
        let lblNoData: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
        lblNoData.text             = displayMessage
        lblNoData.numberOfLines    = 0
        lblNoData.lineBreakMode    = NSLineBreakMode.byWordWrapping
        lblNoData.textColor        = UIColor.lightGray
        lblNoData.textAlignment    = .center
        tableView.backgroundView = lblNoData
        tableView.separatorStyle = .none
    }
}

//MARK: - Calling Number -
func callNumber(_ phoneNumber:String) {
    if let phoneCallURL:URL = URL(string:"tel://\(phoneNumber)") {
        let application:UIApplication = UIApplication.shared
        if (application.canOpenURL(phoneCallURL)) {
            application.openURL(phoneCallURL);
        }
    }
}

//MARK: - Validate TextField -
func requiredField(_ txtField:UITextField,title:String,message:String?) -> Bool {
    if txtField.hasText {
        return true
    }
    else {
        showMessage(title, message: message != nil ? message! :"Please enter \(txtField.placeholder!)")
        return false
    }
}

//MARK: - Play Audio -
func playAudio(_ fileName: String)
{
    let resourcePath = Bundle.main.resourcePath!
    let filePath = "\(resourcePath)/" + "\(fileName)"
    print(filePath)
    let url: URL = URL(fileURLWithPath: filePath)
    let playerObject = AVPlayer(url: url)
    let playerController = AVPlayerViewController()
    playerController.player = playerObject
    playerObject.play()
}

//MARK: - JSON Functions -
func loadJson(forFilename fileName: String) -> NSDictionary? {
    
    if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
        if let data = NSData(contentsOf: url) {
            do {
                let dictionary = try JSONSerialization.jsonObject(with: data as Data, options: .allowFragments) as? NSDictionary
                
                return dictionary
            } catch {
                print("Error!! Unable to parse  \(fileName).json")
            }
        }
        print("Error!! Unable to load  \(fileName).json")
    }
    
    return nil
}
