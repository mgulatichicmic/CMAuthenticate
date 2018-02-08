//
//  CMTwitter.swift
//  Components
//
//  Created by ChicMic on 08/11/17.
//  Copyright © 2017 ChicMic. All rights reserved.
//

import Foundation
import TwitterKit


extension CMLogin {
    
    /**
     Fetch user Detail from Twitter and create login request
     
     @param urlString login Url String for login request
     
     @param api Specified service type .Get or .Post
     
     @return response returns object of CMResponse
     */
    
     func twitterLogin( _ pUrlString: String , pApi: CMApiType, _ response: @escaping (_ response : CMResponse) -> () ) {
        
        Twitter.sharedInstance().start(withConsumerKey:self.fetchDetailFor(CONSTANT.sTWITTER_CONSUMER_KEY) , consumerSecret: self.fetchDetailFor(CONSTANT.sTWITTER_SECRET_KEY))
        Twitter.sharedInstance().logIn(completion: { (session, error) in
            if (session != nil) {
                //Call loginApi
                let twitterCredentials = "\(CONSTANT.sACCESS_TOKEN)=\(session!.authToken)\(CONSTANT.sAUTH_SECRET)\(session!.authTokenSecret)\(CONSTANT.sPROVIDE_TWITTER)"
                    CMServerHandler.sharedInstance.serverSocialRequest(twitterCredentials, pUrlString, pApi, { (res, error) in
                        if error != nil {
                            let responseModel =  CMResponse().getError(CONSTANT.sSERVER_ERROR, error)
                            response(responseModel)
                        }
                        else {
                            let responseModel = CMResponse().getSuccess(CONSTANT.sLOGIN_SUCESS, res)
                            response(responseModel)
                        }
                    })
                }
                else {
                    print("error \(String(describing: error))")
                let responseModel = CMResponse().getError(CONSTANT.sTWITTER_ERROR, error)
                    response(responseModel)
                }
            })
        }
    
}


