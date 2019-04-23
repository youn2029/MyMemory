//
//  UserInfoManager.swift
//  MyMemory
//
//  Created by 윤성호 on 22/04/2019.
//  Copyright © 2019 윤성호. All rights reserved.
//

import UIKit

struct UserInfoKey {
    
    // 저장에 사용할 키
    static let loginId = "LOGINID"
    static let account = "ACCOUNT"
    static let name = "NAME"
    static let profile = "PROFILE"
}

class UserInfoManager {
    
    // 연산 프로퍼티 loginId 정의
    var loginId: Int{
        get {
            return UserDefaults.standard.integer(forKey: UserInfoKey.loginId)
        }
        set(v) {
            let ud = UserDefaults.standard
            ud.set(v, forKey: UserInfoKey.loginId)
            ud.synchronize()
        }
    }
    
    // 연산 프로퍼티 account 정의
    var account: String? {
        get {
            return UserDefaults.standard.string(forKey: UserInfoKey.account)
        }
        set(v) {
            let ud = UserDefaults.standard
            ud.set(v, forKey: UserInfoKey.account)
            ud.synchronize()
        }
    }
    
    // 연산 프로퍼티 name 정의
    var name: String? {
        get {
            return UserDefaults.standard.string(forKey: UserInfoKey.name)
        }
        set(v) {
            let ud = UserDefaults.standard
            ud.set(v, forKey: UserInfoKey.name)
            ud.synchronize()
        }
    }
    
    // profile 정의
    var profile: UIImage? {
        get {
            let ud = UserDefaults.standard
            if let _profile = ud.data(forKey: UserInfoKey.profile) {
                return UIImage(data: _profile)
            }else {
                return UIImage(named: "account.jpg")
            }
        }
        set(v) {
            if v != nil {
                let ud = UserDefaults.standard
                ud.set(v!.pngData(), forKey: UserInfoKey.profile)   // pngData() : 이미지를 NSData형식으로 변환
                ud.synchronize()
            }
        }
    }
    
    // 로그인 여부
    var isLogin: Bool{
        if self.loginId == 0 || self.account == nil {   // loginId가 없거나 계정이 비어있으면
            return false
        }else {
            return true
        }
    }
    
    // 로그인을 처리하는 메소드
    func login(account: String, passwd: String) -> Bool {
        
        if account.isEqual("youn2029@naver.com") && passwd.isEqual("1234") {
            let ud = UserDefaults.standard
            ud.set(100, forKey: UserInfoKey.loginId)
            ud.set(account, forKey: UserInfoKey.account)
            ud.set("성호", forKey: UserInfoKey.name)
            ud.synchronize()
            return true
        }else {
            return false
        }
    }
    
    // 로그아웃을 처리하는 메소드
    func logout() -> Bool {
        let ud = UserDefaults.standard
        ud.removeObject(forKey: UserInfoKey.loginId)
        ud.removeObject(forKey: UserInfoKey.account)
        ud.removeObject(forKey: UserInfoKey.name)
        ud.removeObject(forKey: UserInfoKey.profile)
        ud.synchronize()
        return true
    }
}
