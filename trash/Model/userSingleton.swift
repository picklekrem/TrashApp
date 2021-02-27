//
//  userSingleton.swift
//  trash
//
//  Created by Ekrem Özkaraca on 16.11.2020.
//

import Foundation

class userSingleton {
    static let sharedUserInfo  = userSingleton()
    
    var email = ""
    var username = ""
    var password = ""
    var count = Int()
    
    private init () {
        
    }
}
