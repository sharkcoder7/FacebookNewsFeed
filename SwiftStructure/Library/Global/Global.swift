//
//  Global.swift
//  Swift Structure
//
//  Created by ioshero on 02/08/16.
//  Copyright © 2016 ioshero. All rights reserved.
//

import Foundation
import UIKit

//MARK: - --------------------------------GENERAL--------------------------------
//MARK: - BASE URL -
let BASE_URL                =   "http://<Server IP>/<Project>/ws/v1/"

//MARk:API Action
let api_Api_Name1       =   "\(BASE_URL)apiname1"
let api_Api_Name2       =   "\(BASE_URL)apiname2"
let api_Api_Name3       =   "\(BASE_URL)apiname3"
let api_Api_Name4       =   "\(BASE_URL)apiname4"

//MARK: - App Delegate -
let APP_DELEGATE            =   UIApplication.shared.delegate as! AppDelegate


//MARK: - DateTime -
let dateTimeFormatDefault       = "yyyy-MM-dd HH:mm"        //yyyy-MM-dd HH:mm:ss
let dateTimeFormatDisplay       = "dd-MMM-yyyy hh:mm a"     //30-Jun-2016 12:00 AM

let dateTimeFormatNotification  = "dd:MM:yyyy hh:mm:ss"

let timeFormatDefault       = "HH:mm"
let timeFormatDisplay       = "hh:mm a"     //12:00 AM



//MARK: - --------------------------------PROJECT WISE--------------------------------

//MARK: - Story Board -
let storyBoard_SideMenu         = UIStoryboard(name: "SideMenu", bundle: nil)
let storyBoard_Main             = UIStoryboard(name: "Main", bundle: nil)

//MARK: - SideMenu -
enum SideMenu: Int
{
    case    home = 1,
            settings,
            about,
            contact,
            rate
}

//MARK: - WebPage URL -
let URL_WebPage             = "https://www.google.com/"
let URL_SwiftStructure      = "http://www.9spl.com/"

//MARK: - ACESS CODE REGEX
let pattern_Access_Code =  "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"

