//
//  UserDef.swift
//  EVV
//
//  Created by Abhisar Bhatnagar on 20/11/19.
//  Copyright © 2019 Saif Mukadam. All rights reserved.
//

import Foundation

enum UserDefaultsKeys : String {
    case isLoggedIn
    case Useremail
    case Username
    case UserProfilePic
    case ReferralCode
    case id
}


extension UserDefaults{
    
    func setLoggedIn(value: Bool) {
        set(value, forKey: UserDefaultsKeys.isLoggedIn.rawValue)
    }
    func isLoggedIn()-> Bool {
        return bool(forKey: UserDefaultsKeys.isLoggedIn.rawValue)
    }
    
    
    func setid(value: String){
        set(value, forKey: UserDefaultsKeys.id.rawValue)
    }
    func getid() -> String{
        return string(forKey: UserDefaultsKeys.id.rawValue) ?? "123"
    }
    

    func setUserEmail(value: String){
        set(value, forKey: UserDefaultsKeys.Useremail.rawValue)
    }
    func getUserEmail() -> String{
        return string(forKey: UserDefaultsKeys.Useremail.rawValue) ?? "123"
    }
    
    
    func setUsername(value: String){
        set(value, forKey: UserDefaultsKeys.Username.rawValue)
    }
    func getUsername() -> String{
        return string(forKey: UserDefaultsKeys.Username.rawValue) ?? "123"
    }
    
    
    func setUserUserProfilePic(value: String){
        set(value, forKey: UserDefaultsKeys.UserProfilePic.rawValue)
    }
    func getUserProfilePic() -> String{
        return string(forKey: UserDefaultsKeys.UserProfilePic.rawValue) ?? "null"
    }
    
   
    func setReferralCode(value: String){
        set(value, forKey: UserDefaultsKeys.ReferralCode.rawValue)
    }
    
    func getReferralCode() -> String{
        return string(forKey: UserDefaultsKeys.ReferralCode.rawValue) ?? "null"
    }
   
}
