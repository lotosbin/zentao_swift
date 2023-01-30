import Foundation

extension ZentaoPageApi{
    func myTask() async -> MyTaskData {
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
    struct MyTaskData :Codable{
        var title:String?
        struct TaskData :Codable{
            var id:String?
            var name:String?
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
            var canceledBy:String?
            var canceledDate:String?
            var finishedBy:String?
            var finishedDate:String?
            var closedBy:String?
            var closedDate:String?
            var lastEditedBy:String?
            var lastEditedDate:String?
        }
        var tasks:[TaskData]
    }
}

