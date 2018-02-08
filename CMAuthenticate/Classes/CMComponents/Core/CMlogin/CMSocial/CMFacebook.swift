//
//  CMFacebook.swift
//  Components
//
//  Created by ChicMic on 07/11/17.
//  Copyright © 2017 ChicMic. All rights reserved.
// https://firebase.google.com/docs/reference/rest/auth/

import Foundation
import FBSDKCoreKit
import FBSDKLoginKit



extension CMLogin {

    /**
     Fetch user Detail from facebook and create login request
     
     @param permissions : optional, defaults to ["public_profile", "email"]
     
     @param viewController to present facebook viewController
     
     @param urlString login Url String for login request
     
     @param api Specified service type .Get or .Post
     
     @return response returns object of CMResponse 
     */
    
     func facebookLogin(  _ pPermissions:[String]?, _ pUrlString: String , pApi: CMApiType,   _ response:@escaping (_ response : CMResponse) -> () )  {
        var fbPermission: [String]
        if pPermissions == nil {
            fbPermission = CONSTANT.sFACEBOOK_PERMISSION
        } else {
            fbPermission = pPermissions!
        }
        let login = FBSDKLoginManager()

        login.logIn(withReadPermissions: fbPermission, from: topController(), handler: {(result, error) in
            if error != nil {
                let responseModel = CMResponse().getError(CONSTANT.sFACEBOOK_ERROR, error)
                response(responseModel)
            }
            else {
                if let accessToken = FBSDKAccessToken.current().tokenString {
                    let stringToken = "\(CONSTANT.sACCESS_TOKEN)=\(accessToken)\(CONSTANT.sPROVIDE_FACEBOOK)"
                    CMServerHandler.sharedInstance.serverSocialRequest(stringToken, pUrlString, pApi, { (res, error) in
                        if error != nil {
                            let responseModel = CMResponse().getError(CONSTANT.sSERVER_ERROR, error)
                            response(responseModel)
                        }
                        else {
                            let responseModel = CMResponse().getSuccess(CONSTANT.sLOGIN_SUCESS, res)
                            response(responseModel)
                        }
                    })
                }
            }
            
        })
    }
    
    
}
