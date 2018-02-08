//
//  CMServices.swift
//  Components
//
//  Created by ChicMic on 13/11/17.
//  Copyright © 2017 ChicMic. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import GoogleSignIn
import TwitterKit

public class CMServices: NSObject {

    var mGoogleInstances = [CMLogin]()
   public class var sharedInstance: CMServices {
        struct Static {
            static let instance = CMServices()
        }
        return Static.instance
    }
    
    /**
     Validate the Parameters and create login request at url.
     
     @params  required parameters for login.
     @url  Webservice for login.
     @api  Webservice type .Get or .Post.
     @return response returns object of CMResponse
     
     */
    public func loginWithEmail( _ pUser: CMLoginDetail, _ pResult:@escaping (_ response : CMResponse) -> ()) {
        
        if let loginDic = getWebservice(CONSTANT.sLOGIN_PLIST) {
            CMLogin.sharedInstance.loginWithEmail(pUser, loginDic[CONSTANT.sURL_PLIST] as! String, loginDic[CONSTANT.sTYPE_PLIST] as! CMApiType, pResult)
        } else {
            let responseModel = CMResponse().getError(CONSTANT.sCONFIG_ERROR, nil)
            pResult(responseModel)
        }
    }
    
    /**
     Fetch user Detail from facebook and create login request

     @param permissions : optional, defaults to ["public_profile", "email"]
     @param viewController to present facebook viewController
     @param urlString login Url String for login request
     @param api Specified service type .Get or .Post
     @return response returns object of CMResponse
     */
   public func facebookLogin( _ pPermissions:[String]?, _ pResponse:@escaping (_ response : CMResponse) -> () ) {
        if let registerDic = getWebservice(CONSTANT.sSOCIAL_PLIST) {
            CMLogin.sharedInstance.facebookLogin( pPermissions, registerDic[CONSTANT.sURL_PLIST] as! String, pApi: registerDic[CONSTANT.sTYPE_PLIST] as! CMApiType, pResponse)
        } else {
            let responseModel = CMResponse().getError(CONSTANT.sCONFIG_ERROR, nil)
            pResponse(responseModel)
        }
        
    }
    
    /**
     Fetch user Detail from Twitter and create login request
     
     @param urlString login Url String for login request
     @param api Specified service type .Get or .Post
     @return response returns object of CMResponse
     */
  public  func twitterLogin(_ pResponse:@escaping (_ response : CMResponse) -> () ) {
        if let registerDic = getWebservice(CONSTANT.sSOCIAL_PLIST) {
            CMLogin.sharedInstance.twitterLogin(registerDic[CONSTANT.sURL_PLIST] as! String, pApi: registerDic[CONSTANT.sTYPE_PLIST] as! CMApiType, pResponse)
        } else {
            let responseModel = CMResponse().getError(CONSTANT.sCONFIG_ERROR, nil)
            pResponse(responseModel)
        }
        
    }
    
    
    /**
     Fetch user Detail from google and create login request
     
     @param urlString login Url String for login request
     
     @param api Specified service type .Get or .Post
     
      @return response returns object of CMResponse
     */
  public func googleLogin( _ pResult:@escaping (_ response : CMResponse) -> ()) {
    
    if let registerDic = getWebservice(CONSTANT.sSOCIAL_PLIST) {
        let instance = CMLogin.getInstance
        mGoogleInstances.append(instance)
        instance.googleLogin(pUrl: registerDic[CONSTANT.sURL_PLIST] as! String, pApi: registerDic[CONSTANT.sTYPE_PLIST] as! CMApiType) { (reponse) in
            let instanceIndex = self.mGoogleInstances.index(of: instance)
            if instanceIndex! > 0 && instanceIndex! < self.mGoogleInstances.count {
                self.mGoogleInstances.remove(at: instanceIndex!)
            }
            pResult(reponse);
        }
    } else {
        let responseModel = CMResponse().getError(CONSTANT.sCONFIG_ERROR, nil)
        pResult(responseModel)
        }

    
    }
    
    /**
     Validate Email and Create forget Request
     
     @params  required parameters for login.
     @url  Webservice Link of  Forget Password.
     @api  Webservice type .Get or .Post.
     @return response returns object of CMResponse
     */
   public func forgetPasswordWithEmail( _ pUser: CMBaseUser, _ pResult:@escaping (_ response : CMResponse) -> ()) {
        
        if let forgetDic = getWebservice(CONSTANT.sFORGET_PLIST) {
            CMLogin.sharedInstance.forgetPasswordWithEmail(pUser, forgetDic[CONSTANT.sURL_PLIST] as! String, forgetDic[CONSTANT.sTYPE_PLIST] as! CMApiType, pResult)
        } else {
            let responseModel = CMResponse().getError(CONSTANT.sCONFIG_ERROR, nil)
            pResult(responseModel)
        }
        
    }
    
    /**
     Validate the Parameters and create Register request at url.
     
     @params params required parameters for login.
     @params url  Webservice for login.
     @params api  Webservice type .Get or .Post.
     @return response returns object of CMResponse
     
     */
  public  func registerWithEmail( _ pUserModel: CMRegisterDetail, _ result:@escaping (_ response : CMResponse) -> ()) {
        
        if let registerDic = getWebservice(CONSTANT.sREGISTER_PLIST) {
            CMLogin.sharedInstance.registerWithEmail(pUser: pUserModel, registerDic[CONSTANT.sURL_PLIST] as! String, registerDic[CONSTANT.sTYPE_PLIST] as! CMApiType, result)
        } else {
            let responseModel = CMResponse().getError(CONSTANT.sCONFIG_ERROR, nil)
            result(responseModel)
        }
        
    }
    
    /**
     get Url from config file.
     
     @params pWebserviceName name of webservice.
     @return [String : Any] returns - Type of webservice
                                    - Url of webservice
     
     */
    func getWebservice(_ pWebserviceName: String) -> [String : Any]? {
        if let pList = getConfigContent(), let loginDic = pList[pWebserviceName] as? NSDictionary {
            let apiType:CMApiType = loginDic[CONSTANT.sTYPE_PLIST] as! Bool == false ? .Post : .Get
            let url = loginDic[CONSTANT.sURL_PLIST] as! String
            return [CONSTANT.sTYPE_PLIST : apiType,
                    CONSTANT.sURL_PLIST : url ];
        } else {
            return nil
        }
    }
  
  /**
   This method will verify an authentication token sent by the Twitter API to finish the web-based authentication flow.
   */
  
 public func twitterApplication(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
    return Twitter.sharedInstance().application(app, open: url, options: options)
  
  }
  /**
   This method will verify an authentication token sent by the Facebook and Google.
   */
 public func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
    if url.absoluteString.contains("fb") {
      return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    else {
      return GIDSignIn.sharedInstance().handle(url, sourceApplication: sourceApplication, annotation: annotation)
    }
  }
  
  /**
   This method will intial set up Facebook.
   */
public  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
