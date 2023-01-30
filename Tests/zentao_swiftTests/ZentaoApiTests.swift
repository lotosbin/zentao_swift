import XCTest
@testable import zentao_swift

final class ZentaoApiTests: XCTestCase {
    var url :URL = URL(string: testHost )!
    var api :ZentaoApi = ZentaoApi(url: URL(string: testHost)!)
    override func setUp() async throws {
    }
    func test_getSessionID() async throws -> SessionIDData {
        let sessionID = await api.getSessionID()
        XCTAssertNotNil(sessionID)
        return sessionID
    }
    func test_isLogin() async {
        let isLogin = await api.isLogin()
        XCTAssertFalse(isLogin)
    }
    func test_userLogin() async throws {
        let sessionId = try! await test_getSessionID()
        var props = Dictionary<HTTPCookiePropertyKey, Any>()
        props[HTTPCookiePropertyKey.name] = sessionId.sessionName
        props[HTTPCookiePropertyKey.value] = sessionId.sessionID
        props[HTTPCookiePropertyKey.path] = "/"
        props[HTTPCookiePropertyKey.domain] = url.host
        let cookie = HTTPCookie(properties: props)
        URLSession.shared.configuration.httpCookieStorage?.setCookie(cookie!)
        //            .cookies(for:url).setValue(sessionId.sessionID, forKey: sessionId.sessionName)
        let loginResult = await api.userLogin(sessionId: sessionId.sessionID!, account: testUsername, password: testPassword)
    }
}
