//
//  AuthManager.swift
//  MemoryBox
//
//  Created by David Zhu on 10/29/24.
//

import Foundation

class AuthManager {
    static func setAuth(token: String, userId: String) {
        UserDefaults.standard.set(token, forKey: "jwtToken")
        UserDefaults.standard.set(userId, forKey: "userId")
    }
    
    static func clearAuth() {
        UserDefaults.standard.removeObject(forKey: "jwtToken")
        UserDefaults.standard.removeObject(forKey: "userId")
    }
    
    static var token: String? {
        UserDefaults.standard.string(forKey: "jwtToken")
    }
    
    static var userId: String? {
        UserDefaults.standard.string(forKey: "userId")
    }
}
