//
//  File.swift
//  
//
//  Created by 刘斌斌 on 2022/11/6.
//

import Foundation
extension ZentaoApi{
    func userLogin(sessionId:String,account:String,password:String) async -> UserLoginData {
        let queryItems = [
            URLQueryItem(name: "zentaosid", value: sessionId),
            URLQueryItem(name: "account", value: account),
            URLQueryItem(name: "password", value: password),
        ]
        var urlComps = URLComponents(string: self.url.absoluteString + "/user-login.json")!
        urlComps.queryItems = queryItems
        let result = urlComps.url!
        let s =  await request.get(path: result.absoluteString )
        let r =  try! JSONDecoder().decode(UserLoginResult.self,from:Data(s.utf8))
        return r.user!
        
    }
}
struct UserLoginResult:Result{
    var status: String?
    
    var reason: String?
    
    var md5: String?
    
    var user:UserLoginData?
    
}
struct UserLoginData:Codable{
    var id:String
    var dept:String
    var account:String
    var role:String
    var realname:String
    var nickname:String
    var commiter:String
    var avatar:String
    var birthday:String
    var gender:String
    var email:String
    var skype:String
    var qq:String
    var mobile:String
    var phone:String
    var weixin:String
    var dingding:String
    var slack:String
    var whatsapp:String
    var address:String
    var zipcode:String
    var join:String
    var visits:String
    var ip:String
    var last:String
    var fails:String
    var locked:String
    var ranzhi:String
    var score:String
    var scoreLevel:String
    var clientStatus:String
    var clientLang:String
    var lastTime:String
    var admin:Bool
    var modifyPassword:Bool
    var modifyPasswordReason:String
//    var rights:[]
//    var groups
    struct View:Codable{
        var account:String
        //id spilt by ,
        var products:String
        //id spilt by ,
        var projects:String
    }
    var view:View
    var company:String
}
