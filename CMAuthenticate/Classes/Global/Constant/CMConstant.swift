//
//  CMCONSTANT.swift
//  Components
//
//  Created by ChicMic on 09/11/17.
//  Copyright © 2017 ChicMic. All rights reserved.

//  CONSTANTs Used in Application

import Foundation

public struct CONSTANT {
    //Google Client Id
   public static let sFIREBASE_KEY = "AIzaSyBb-jlkF4eHxfemRn0gTdDEj7noU3xGQf4"
//    static let sGOOGLE_CLIENT_ID = "939514916805-mjtjeanc765enrb3sra77fn0nrig8sa6.apps.googleusercontent.com"
  public  static let sAUTH_SECRET = "&oauth_token_secret="
   public static let sPROVIDE_GOOGLE = "&providerId=google.com"
   public static let sPROVIDE_TWITTER = "&providerId=twitter.com"
    public static let sPROVIDE_FACEBOOK = "&providerId=facebook.com"
    
    //Twitter
//    static let sTWITTER_CONSUMER_KEY = "lfcow13Ps9VtdMxSUcHZeSGl7"
//    static let sTWITTER_CONSUMER_SECRET = "kzkcxEjsPyADPH1ePrOYh1gM3gXdeRwUUkUux2BHJ5wubtYOhY"
    
    //Instagram
   public static let sINSTAGRAM_CLIENTID = "d66238390c2d4b269d06882ed88ea06e"
  public  static let sINSTAGRAM_CLIENT_SECRET = "c9cf75cd8f4241dda761ec2cf344b60d"
  public  static let sINSTAGRAM_PERMISSION = "basic"
  public  static let sINSTAGRAM_AUTHURL = "https://api.instagram.com/oauth/authorize/"
  public  static let sINSTAGRAM_REDIRECT_URI = "https://chicmic.auth0.com/login/callback"
  public  static let sACCESS_TOKEN = "access_token"
    
    //Facebook
  public  static let sFACEBOOK_PERMISSION = ["public_profile", "email"]
    
    //Validations
   public static let sEMAIL_REGEX = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
   public static let sPASSWORD_REGEX = "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}"
    
    //CONSTANTs
  public  static let sAPPLICATION_NAME = "Component"
  public  static let sGOOGLE_ID = "GoogleClientID"
  public  static let sTWITTER_CONSUMER_KEY = "TwitterCustomerKey"
  public  static let sTWITTER_SECRET_KEY = "TwitterSecretKey"
   public static let sALERT_TITLE_ERROR = "Error"
   public static let sALERT_TITLE_WARNING = "Warning"
   public static let sALERT_TITLE_MESSAGE = "Message"
   public static let sBUTTON_OK = "Ok"
   public static let sBUTTON_CANCEL = "Cancel"
   public static let sPASSWORD_MIN_CHARACTER = 6
    
    //Alert Messages
  public  static let sPASSWORD_ERROR = "Password Should be more than 6 Characters"
  public  static let sEMAIL_ERROR = "Enter Correct Email"
  public  static let sCONFIRM_ERROR = "Password Mismtach"
  public  static let sSERVER_ERROR = "Server Error"
  public  static let sFACEBOOK_ERROR = "Facebook Error"
  public  static let sGOOGLE_ERROR = "Google Error"
  public  static let sTWITTER_ERROR = "Twitter Error"
  public  static let sLOGIN_SUCESS = "login Successful"
  public  static let sREGITER_SUCESS = "Register Successful"
  public  static let sFORGET_SUCESS = "Mail Sent"
  public  static let sUSER_CANCEL = "Cancelled by user"
  public  static let sCONFIG_ERROR = "Config file not found"
  public  static let sKEY_NOT_FOUND = "key not found"
    
    //Parsing
  public  static let sERROR_DICTIONARY = "com.alamofire.serialization.response.error.data"
  public  static let sERROR_KEY = "error"
  public  static let sMESSAGE_KEY = "message"
   public static let sBASE_URL_PLIST = "BaseUrl"
  public  static let sURL_PLIST = "url"
   public static let sTYPE_PLIST = "typeGet"
  public  static let sLOGIN_PLIST = "Login"
   public static let sREGISTER_PLIST = "Register"
   public static let sFORGET_PLIST = "Forget"
   public static let sSOCIAL_PLIST = "Social"
}



