//
//  CMRegister.swift
//  Components
//
//  Created by ChicMic on 08/11/17.
//  Copyright © 2017 ChicMic. All rights reserved.
//

import Foundation

extension CMLogin {
    
    /**
     Validate the Parameters and create Register request at url.
     
     @params params  required parameters for login.
     @params url  Webservice for login.
     @params api  Webservice type .Get or .Post.
     @response result if Successful
     @return error user if error encountered.
     
     */
    func registerWithEmail( pUser: CMRegisterDetail, _ url : String, _ api: CMApiType , _ result:@escaping (_ response : CMResponse) -> ())  {
        
        guard isValidEmail(emailString: pUser.email) else {
            let responseModel = CMResponse().getError(CONSTANT.sEMAIL_ERROR, nil)
            result(responseModel)
            return
        }
        guard isPasswordValid(password: pUser.password) else {
            let responseModel = CMResponse().getError(CONSTANT.sPASSWORD_ERROR, nil)
            result(responseModel)
            return
        }
        guard pUser.confirmPassword == pUser.password else {
            let responseModel = CMResponse().getError(CONSTANT.sCONFIRM_ERROR, nil)
            result(responseModel)
            return
        }
        let parameters = pUser.convertModeltoDictionary()
        CMServerHandler.sharedInstance.serverRequest(parameters, url, api, { (res, error) in
            if error != nil {
                let responseModel = CMResponse().getError(CONSTANT.sSERVER_ERROR, error)
                result(responseModel)
            }
            else {
                let responseModel = CMResponse().getSuccess(CONSTANT.sREGITER_SUCESS, res!)
                result(responseModel)
            }
        })
        
    }
    
    
}
