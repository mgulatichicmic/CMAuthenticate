//
//  CMServer.swift
//  Components
//
//  Created by ChicMic on 06/11/17.
//  Copyright © 2017 ChicMic. All rights reserved.
//

import UIKit
import AFNetworking


@objc class CMServerHandler: NSObject  {
    
    class var sharedInstance: CMServerHandler {
        struct Static {
            static let instance = CMServerHandler()
        }
        return Static.instance
    }
    
    /**
    Initializes a Get request with the specified base URL.
     
     @param url The base URL for the HTTP client.
     
     @param parameters type [String : Any].
     
     @return resultSuccess If Successful with  type Any.
     
     @return error If not Successful with  server error.
     
    */
  private  func serverGet(_ pUrl : String, _ param : [String:Any]?, _ pResultSuccess : @escaping (_ response: Any) -> (), _ pError : @escaping (_ error: Error) -> ())   {

        let manager = AFHTTPSessionManager()
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.responseSerializer = AFJSONResponseSerializer(readingOptions: .allowFragments)
        manager.get(pUrl, parameters: param, progress: nil, success: { (task, response) in
            pResultSuccess(response!)
        }) { (task, err) in
            pError(err)
        }
    }
    
    /**
     Initializes a Post request with the specified base URL.
     
     @param url The base URL for the HTTP client.
     
     @param parameters type [String : Any].
     
     @return resultSuccess If Successful with  type Any.
     
     @return error If not Successful with  server error.
     
     */
  private  func serverPost(_ pUrl : String, _ param : [String:Any]?, _ pResultSuccess : @escaping (_ response: Any) -> (), _ pError : @escaping (_ error: Error) -> ())   {
        let manager = AFHTTPSessionManager()
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.responseSerializer = AFJSONResponseSerializer()
        manager.post(pUrl, parameters: param, progress: nil, success: { (task, response) in
            pResultSuccess(response!)
        }) { (task, err) in
            pError(err)
        }
    }
    
    /**
     Create Login Request
     
     @param token : access token from social
     
     @param urlString login webservice
     
     @param api Specified service type .Get or .Post
     
     @return result returns success if no error and if error will retuwn error
     */
    
   open func serverSocialRequest(_ pToken : String, _ pUrlString : String, _ pApi : CMApiType, _ pResult : @escaping (_ response: Any?, _ error : Error?) -> () )  {
        var params = Dictionary<String, Any>();
        params[SERVICE_CONSTANT.sPOST_BODY] = pToken
        params[SERVICE_CONSTANT.sREQUEST_URI] = SERVICE_CONSTANT.sLOCAL_HOST
        params[SERVICE_CONSTANT.sRETURN_IDP_CREDENTIAL] = true
        params[SERVICE_CONSTANT.sRETURN_SECURE_TOKEN] = true
        if let baseUrl = getBaseUrl() {
            let url = baseUrl + pUrlString
                if pApi == .Get {
                    CMServerHandler.sharedInstance.serverGet(url, params, { (res) in
                        pResult(res,nil)
                    }, { (error) in
                        pResult(nil,error)
                    })
                }
                else {
                    CMServerHandler.sharedInstance.serverPost(url, params, { (res) in
                        pResult(res,nil)
                    }, { (error) in
                        pResult(nil,error)
                    })
                }
            } else {
            print("Enter Base Url")
        }
        
    }
    
    /**
     Create Login Request
     
     @param token : access token from social
     
     @param urlString login webservice
     
     @param api Specified service type .Get or .Post
     
     @return result	 returns success if no error and if error will retuwn error
     */
  open func serverRequest(_ params: Dictionary <String, Any>, _ pUrlString : String, _ pApi : CMApiType, _ pResult : @escaping (_ response: Any?, _ error : Error?) -> () )  {

        if let baseUrl = getBaseUrl() {
            let url = baseUrl + pUrlString
            if pApi == .Get {
                serverGet(url, params, { (res) in
                    pResult(res,nil)
                }, { (error) in
                    pResult(nil,error)
                })
            }
            else {
                serverPost(url, params, { (res) in
                    pResult(res,nil)
                }, { (error) in
                    pResult(nil,error)
                })
            }
        } else {
            print("Enter Base Url")
        }
    
    }
    
    func getBaseUrl() -> String? {
       
        if let dict = getConfigContent() {
            return dict[CONSTANT.sBASE_URL_PLIST] as? String
        }
        return nil
    }


    
    
}
