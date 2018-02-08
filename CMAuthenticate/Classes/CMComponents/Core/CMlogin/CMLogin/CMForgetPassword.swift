//
//  CMForgetPassword.swift
//  Components
//
//  Created by ChicMic on 09/11/17.
//  Copyright © 2017 ChicMic. All rights reserved.
//

import Foundation

extension CMLogin {
    
    /**
     Validate Email and Create forget Request
     
     @params  required parameters for login.
     @params url  Webservice Link of  Forget Password.
     @params api  Webservice type .Get or .Post.
     @return response returns object of CMResponse
     */
    public func forgetPasswordWithEmail( _ pUser: CMBaseUser , _ pUrl : String, _ pApi: CMApiType , _ result:@escaping (_ response : CMResponse) -> ()) {
        guard   isValidEmail(emailString: pUser.email) else {

            let responseModel = CMResponse().getError(CONSTANT.sEMAIL_ERROR, nil)
            result(responseModel)
            return
        }
        let parameters = pUser.convertModeltoDictionary()
        CMServerHandler.sharedInstance.serverRequest(parameters, pUrl, pApi, { (res, error) in
            if error != nil {
                let responseModel =  CMResponse().getError(CONSTANT.sSERVER_ERROR, nil)
                result(responseModel)
            }
            else {
                let responseModel = CMResponse().getSuccess(CONSTANT.sFORGET_SUCESS, res) 
                result(responseModel)
            }
        })
    }
    
}
