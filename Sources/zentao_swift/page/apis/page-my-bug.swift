//
//  File.swift
//
//
//  Created by 刘斌斌 on 2022/11/7.
//

import Foundation

extension ZentaoPageApi{
    func myBug() async -> MyBugData {
        let response = await request.get(path: url.absoluteString + "/my-bug.json")
        let r =  try! JSONDecoder().decode(MyBugResult.self,from:Data(response.utf8))
        let d =  try! JSONDecoder().decode(MyBugData.self,from:Data(r.data!.utf8))
        return d
    }
    struct MyBugResult : Result{
        var status: String?
        
        var reason: String?
        
        var md5: String?
        
        var data: String?
        
    }
    struct MyBugData :Codable{
        var title:String?
        struct BugData :Codable{
            var id:String?
            var title:String?
            var product:String?
            var branch:String?
            var module:String?
            var project:String?
            var plan:String?
            var story:String?
            var status:String?
            var activatedDate:String?
            var openedBy:String?
            var openedDate:String?
            var assignedTo:String?
            var assignedDate:String?
            var resolvedBy:String?
            var resolvedDate:String?
            var closedBy:String?
            var closedDate:String?
            var lastEditedBy:String?
            var lastEditedDate:String?
        }
        var bugs:[BugData]
    }
}

