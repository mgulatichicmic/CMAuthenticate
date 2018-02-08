//
//  CMResponse.swift
//  Components
//
//  Created by ChicMic on 20/11/17.
//  Copyright © 2017 ChicMic. All rights reserved.
//

// Response Format 

import UIKit

public class CMResponse: NSObject {
   public var success: Bool = false
   public var message: String = ""
   public var error: Error?
   public var response : Any?
    
   public convenience init(_ pSuccess: Bool, _ pMessage: String, _ pError:Error?, _ pResponse:Any?) {
        self.init()
        intialise(pSuccess, pMessage, pError, pResponse)
    }
   private func intialise(_ pSuccess: Bool, _ pMessage: String, _ pError:Error?, _ pResponse:Any?) {
        success = pSuccess
        message = pMessage
        error = pError
        response = pResponse
    }
    
   public func getSuccess(_ pMessage:String,_ pResponse:Any? ) -> CMResponse {
        intialise(true, pMessage, nil, pResponse)
       return self
    }
    
   public func getError(_ pMessage:String,_ pError:Error? ) -> CMResponse {
        intialise(false, pMessage, pError, nil)
        return self
    }
}
