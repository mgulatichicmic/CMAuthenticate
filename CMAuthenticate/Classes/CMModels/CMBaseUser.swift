//
//  CMBaseUser.swift
//  Components
//
//  Created by ChicMic on 04/12/17.
//  Copyright © 2017 ChicMic. All rights reserved.
//

import UIKit


public class CMBaseUser: CMObject {
    
    @objc dynamic var email : String = ""
    
   public convenience init(_ pParameters: [String : Any]) {
        self.init()
        self.setValuesForKeys(pParameters)
        
    }
    
}
