//
//  Key.swift
//  Swift Structure
//
//  Created by ioshero on 02/08/16.
//  Copyright © 2016 ioshero. All rights reserved.
//

import Foundation

//MARK: - Device Token -
let key_DeviceToken         = "DeviceToken"
let DeviceToken             = (getFromUserDefaultForKey(key_DeviceToken) != nil) ? getFromUserDefaultForKey(key_DeviceToken) as! String : "token"

//MARK: - Terms Conditions -
let key_IsTermsAccepted     = "TermsAccepted"

