//
//  CMSERVICE_CONSTANT.swift
//  Components
//
//  Created by ChicMic on 09/11/17.
//  Copyright © 2017 ChicMic. All rights reserved.
//

// Service CONSTANTs Used in Application

import Foundation

public struct SERVICE_CONSTANT {
    //Service keywords
   public static let sPOST_BODY = "postBody"
    public static let sREQUEST_URI = "requestUri"
   public  static let sRETURN_IDP_CREDENTIAL = "returnIdpCredential"
    public static let sRETURN_SECURE_TOKEN = "returnSecureToken"
   public static let sEMAIL = "email"
  public  static let sPASSWORD = "password"
  public  static let sRESETPASSWORD = "PASSWORD_RESET"
  public  static let sREQUEST_TYPE = "requestType"
  public  static let sCONFIRM_PASSWORD = "confirmPassword"
  public  static let sLOCAL_HOST = "http://localhost"
    
    //Services
   public static let sBASE_URL = "https://www.googleapis.com/identitytoolkit/v3/relyingparty/"
   public static let sLOGIN_WEBSERVICE = "verifyPassword?key="+CONSTANT.sFIREBASE_KEY
  public  static let sSOCIAL_WEBSERVICE = "verifyAssertion?key="+CONSTANT.sFIREBASE_KEY
   public static let sFORGET_WEBSERVICE = "getOobConfirmationCode?key="+CONSTANT.sFIREBASE_KEY
   public static let sREGISTER_WEBSERVICE  = "signupNewUser?key="+CONSTANT.sFIREBASE_KEY
    
    

}
