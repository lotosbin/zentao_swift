//
//  File.swift
//
//
//  Created by 刘斌斌 on 2022/11/7.
//

import Foundation

extension ZentaoPageApi{
    public func myBug() async -> MyBugData {
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
    public struct MyBugData :Codable{
        public var title:String?
        public struct BugData :Codable{
            public var id:String?
            public var title:String?
            public var product:String?
            public var branch:String?
            public var module:String?
            public var project:String?
            public var plan:String?
            public var story:String?
            public var status:String?
            public var activatedDate:String?
            public var openedBy:String?
            public var openedDate:String?
            public var assignedTo:String?
            public var assignedDate:String?
            public var resolvedBy:String?
            public var resolvedDate:String?
            public var closedBy:String?
            public var closedDate:String?
            public var lastEditedBy:String?
            public var lastEditedDate:String?
        }
        public var bugs:[BugData]
    }
}

