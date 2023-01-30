//
//  File.swift
//  
//
//  Created by 刘斌斌 on 2022/11/6.
//

import Foundation
extension ZentaoApi{
    func getSessionID() async -> SessionIDData {
        let s = await request.get( path: self.url.absoluteString  + "/api-getsessionid.json")
        let result =  try! JSONDecoder().decode(SessionIDResult.self,from:Data(s.utf8))
        return try! JSONDecoder().decode(SessionIDData.self, from: Data(result.data!.utf8))
    }
}
struct SessionIDResult : Result{
    var status: String?
    
    var reason: String?
    
    var md5: String?
    
    var data:String?
}
struct SessionIDData: Codable {
    var title: String?
    var sessionName: String?
    var sessionID: String?
    var rand: Int?
    var pager: Int?
}
