//
//  ZentaoPageApi.swift
//  
//
//  Created by 刘斌斌 on 2022/11/6.
//

import XCTest
@testable import zentao_swift

final class ZentaoPageApiTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    var url :URL = URL(string: testHost)!
    var api :ZentaoPageApi = ZentaoPageApi(url: URL(string: testHost)!)
    func test_userLogin() async{
        let loginResult = await api.userLogin(account: testUsername, password: testPassword)
    }
    func test_myDynamic() async{
        let d = await api.myDynamic()
        XCTAssertFalse(d.dateGroups.isEmpty)
    }
    func test_myDynamic_login() async{
        await test_userLogin()
        let d = await api.myDynamic()
        XCTAssertFalse(d.dateGroups.isEmpty)
    }
    func test_myBug_login() async{
        await test_userLogin()
        let d = await api.myBug()
        XCTAssertFalse(d.bugs.isEmpty)
    }
    func test_myTask_login() async{
        await test_userLogin()
        let d = await api.myTask()
        XCTAssertFalse(d.tasks.isEmpty)
    }
}
