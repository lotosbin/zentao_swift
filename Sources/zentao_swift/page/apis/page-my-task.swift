import Foundation

extension ZentaoPageApi{
    public func myTask() async -> MyTaskData {
        let response = await request.get(path: url.absoluteString + "/my-task.json")
        let r =  try! JSONDecoder().decode(MyTaskResult.self,from:Data(response.utf8))
        let d =  try! JSONDecoder().decode(MyTaskData.self,from:Data(r.data!.utf8))
        return d
    }
    struct MyTaskResult : Result{
        var status: String?
        
        var reason: String?
        
        var md5: String?
        
        var data: String?
        
    }
    public struct MyTaskData :Codable{
        public var title:String?
        public struct TaskData :Codable{
           public var id:String?
           public var name:String?
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
           public var canceledBy:String?
           public var canceledDate:String?
           public var finishedBy:String?
           public var finishedDate:String?
           public var closedBy:String?
           public var closedDate:String?
           public var lastEditedBy:String?
           public var lastEditedDate:String?
        }
        public var tasks:[TaskData]
    }
}

