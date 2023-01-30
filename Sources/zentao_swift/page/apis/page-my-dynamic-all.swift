//
//  File.swift
//  
//
//  Created by 刘斌斌 on 2022/11/7.
//

import Foundation

extension ZentaoPageApi{
    func myDynamic() async -> MyDynamicData {
        let response = await request.get(path: url.absoluteString + "/my-dynamic-all.json")
        let r =  try! JSONDecoder().decode(MyDynamicResult.self,from:Data(response.utf8))
        let d =  try! JSONDecoder().decode(MyDynamicData.self,from:Data(r.data!.utf8))
        return d
    }
    struct MyDynamicResult : Result{
        var status: String?
        
        var reason: String?
        
        var md5: String?
        
        var data: String?
        
    }
    struct MyDynamicData :Codable{
        var title:String
        var type:String?
        var orderBy:String
        struct PagerData :Codable{
            var recTotal:Int
            var recPerPage:Int
            var pageCookie:String
            var pageTotal:Int
            var pageID:Int
            var moduleName:String
            var methodName:String
            var params:String?
        }
        var pager:PagerData
        struct GroupItem:Codable{
            var id:String
            //task,user,
            var type:String?
            var objectID:String
            var product:String
            var project:String
            var actor:String
            var action:String
            var date:String
            var comment:String
            var extra:String
            var read:String
            var objectName:String
            var originalDate:String
            var actionLabel:String
            var objectLabel:String
            var objectLink:String
            var major:Int
            var time:String
        }
        var dateGroups:[String:[GroupItem]]
        var direction:String
    }
}

