//
//  CMRegisterModel.swift
//  Components
//
//  Created by ChicMic on 04/12/17.
//  Copyright © 2017 ChicMic. All rights reserved.
//

import Foundation
import UIKit


public class CMRegisterDetail: CMLoginDetail {
    
    @objc dynamic var confirmPassword : String = ""
    
  public  convenience init(_ param : NSDictionary) {
        self.init(param as! [String : Any])
        
    }
    
    
}
