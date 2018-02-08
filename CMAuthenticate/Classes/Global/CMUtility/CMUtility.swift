//
//  CMUtility.swift
//  Components
//
//  Created by ChicMic on 09/11/17.
//  Copyright © 2017 ChicMic. All rights reserved.

// Common Function used in Application

import Foundation
import UIKit

//MARK:- Enums


/**
 Webservice Type
 
 @case Error set kError Title.
 @case Warning set kWarning Title.
 @case Message set kMessage Title.
 
 */

public enum CMAlertType {
    case Error
    case Warning
    case Message
}

/**
 Webservice Type
 
 @case Get for get type webservices.
 @case Post for post type webservices.
 
 */

public enum CMApiType {
    case Get
    case Post
}

//   MARK:-  Custom Methods

// Check Email Validation
public  func isValidEmail(emailString:String) -> Bool {
    let emailRegEx = CONSTANT.sEMAIL_REGEX
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: emailString)
}

/**
 Get Config File Content
 
 */
func getConfigContent() -> NSDictionary? {
    var myDict: NSDictionary?
    if let path = Bundle.main.path(forResource: "Config", ofType: "plist") {
        myDict = NSDictionary(contentsOfFile: path)
    }
    else {
        print("Config file not found")
    }
    return myDict
    
}


/**
 Show Alert
 
 @param alertType define type of alert - error - message - warning.
 @param subTitle message to alert controller
 @param view to present alert controller.
 */
public func showAlertWith(_ pAlertType: CMAlertType, _ pSubTitle: String, _ pView: UIViewController) {
    switch pAlertType {
    case .Error:
        showCustomAlert(CONSTANT.sALERT_TITLE_ERROR, pSubTitle, pView, CONSTANT.sBUTTON_OK, nil, completionHandler: nil)
    case .Warning:
        showCustomAlert(CONSTANT.sALERT_TITLE_WARNING, pSubTitle, pView, CONSTANT.sBUTTON_OK, CONSTANT.sBUTTON_CANCEL, completionHandler: nil)
    case .Message:
        showCustomAlert(CONSTANT.sALERT_TITLE_MESSAGE, pSubTitle, pView, CONSTANT.sBUTTON_OK, nil, completionHandler: nil)
    }
}

/**
 Show Alert for Warnings with completion handler
 @param title Title for alert
 @param subtitle Subtitle for alert
 @view Controller to present alert
 @cancelTitle title for cancel button
 @doneTitle optional Value title for Done button
 @completionHandler optional Click on Done Button
 */
public func showCustomAlert(_ pTitle: String, _ pSubtitle: String, _ pView: UIViewController,_ pCancelTitle: String, _ pDoneTitle : String?, completionHandler : ((_ isCompleted : Bool) -> ())?) {
    
    let controller = UIAlertController.init(title: pTitle , message: pSubtitle, preferredStyle: .alert)
    let action = UIAlertAction.init(title: pCancelTitle, style: .cancel, handler: nil)
    controller.addAction(action)
    if pDoneTitle != nil {
        let action = UIAlertAction.init(title: pDoneTitle, style: .default, handler: { (alert) in
            completionHandler!(true)
        })
        controller.addAction(action)
    }
    pView.present(controller, animated: true, completion: nil)
}

/**
 Parse FireBase error and Show Alert
 @error error Error from firebase server
 */

public func showFireBaseServerError(_ error:Error) {
    let dic = (error as NSError).userInfo;
    let data = dic[CONSTANT.sERROR_DICTIONARY]
    if let nsdata = data as? Data {
        let decodedJson = try? JSONSerialization.jsonObject(with: nsdata, options:    []) as! [String: Any]
        if let message = decodedJson![CONSTANT.sERROR_KEY] as? [String : Any] {
            showAlertWith(.Error, message[CONSTANT.sMESSAGE_KEY] as! String, topController()!)
        }
    }
}


/**
 Check Password
 @param password Password string
 @return bool true if valid else No
 */
public  func isPasswordValid(password : String) -> Bool{
    //Check For more than 6 characters
    return password.count > CONSTANT.sPASSWORD_MIN_CHARACTER
}

/**
Return Top view Controller
 */
public func topController() -> UIViewController? {    
    // recursive follow
    func follow(from:UIViewController?) -> UIViewController? {
        if let to = (from as? UITabBarController)?.selectedViewController {
            return follow(from: to)
        } else if let to = (from as? UINavigationController)?.visibleViewController {
            return follow(from: to)
        } else if let to = from?.presentedViewController {
            return follow(from: to)
        }
        return from
    }
    let root = UIApplication.shared.keyWindow?.rootViewController
    
    return follow(from: root)
    
}
