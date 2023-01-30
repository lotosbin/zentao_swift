import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

public struct ZentaoApi {
    
    
    var url:URL
    init(url: URL) {
        self.url = url
    }
    var request = ZentaoRequest()
    
    
    func isLogin() async -> Bool {
        URLSession.shared.configuration.httpCookieStorage?.cookies(for: url)?.contains(where: { cookie in cookie.name == "zentaosid"}) ?? false
    }
    
}
protocol Result: Codable {
    //failed,success
    var status: String? { get set }
    var reason:String? { get set }
    var md5: String? { get set }
}
