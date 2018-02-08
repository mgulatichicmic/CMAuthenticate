//
//  CMLogin.swift
//  Components
//
//  Created by ChicMic on 06/11/17.
//  Copyright © 2017 ChicMic. All rights reserved.
//

import UIKit
import GoogleSignIn


@objc class CMLogin: NSObject {
  
    
    /**
     Store Call Back
     */
    var completionHandler: ((_ response : CMResponse) -> ())?

    
    /**
     View Controller to present Social view
     */
    var selfController:UIViewController? = nil
    var loginUrl: String?
    var apiType :CMApiType?
    
    class var sharedInstance: CMLogin {
        struct Static {
            static let instance = CMLogin()
        }
        return Static.instance
    }
    
    /**
     Get new instance of CMLogin
     */
    class var getInstance: CMLogin {
        return CMLogin()
    }
   
    
    /**
     Validate the Parameters and create login request at url.
     
     @params  required parameters for login.
     @url  Webservice for login.
     @api  Webservice type .Get or .Post.
     @return response returns object of CMResponse 
     
     */
    //Login With Email
    func loginWithEmail( _ pUser: CMLoginDetail , _ pUrl : String, _ pApi: CMApiType , _ result:@escaping (_ response : CMResponse) -> ()) {
        guard   isValidEmail(emailString: pUser.email) else {
           let responseModel = CMResponse().getError(CONSTANT.sEMAIL_ERROR, nil)
            result(responseModel)
            return
        }
        guard  isPasswordValid(password: pUser.password) else {
            
            let responseModel = CMResponse().getError(CONSTANT.sPASSWORD_ERROR, nil)
            result(responseModel)
            return
        }
        let parameters = pUser.convertModeltoDictionary()
        CMServerHandler.sharedInstance.serverRequest(parameters, pUrl, pApi, { (res, error) in
            if error != nil {
                let responseModel = CMResponse().getError(CONSTANT.sSERVER_ERROR, error)
                result(responseModel)
            }
            else {
                let responseModel = CMResponse().getSuccess(CONSTANT.sLOGIN_SUCESS, res)
                result(responseModel)
            }
        })
        
    }
    
    func fetchDetailFor(_ key: String) -> String {
        
        if let dict = getConfigContent() {
            return dict[key] as! String
        }
        print("\(key) \(CONSTANT.sKEY_NOT_FOUND)")
        return ""
    }
    
}

