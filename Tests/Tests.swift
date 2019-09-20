//
//  Tests.swift
//  Tests
//
//  Created by Sergey Makeev on 20/09/2019.
//  Copyright © 2019 Sergey Makeev. All rights reserved.
//


import XCTest
import SwiftAnonymousClass

protocol Greeting {
    func sayHello() -> String
}

class Tests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        let object: Greeting = _new {
            class NoName: Greeting {
                func sayHello() -> String {
                    return "hello from no name class"
                }
            }
            return NoName()
        }
        XCTAssert("hello from no name class" == object.sayHello())
    }

    func testURLSessionDelegate() {
        let configuration = URLSessionConfiguration.default
        var downloadsSession = URLSession(configuration: configuration,
                                          delegate: _new {
                                            class NoName: NSObject, URLSessionDownloadDelegate {
                                                func urlSession(_ session: URLSession,
                                                                downloadTask: URLSessionDownloadTask,
                                                                didFinishDownloadingTo location: URL) {
                                                    print("Finished downloading to \(location).")
                                                }
                                            }
                                            return NoName()
                                          },
                                          delegateQueue: nil)
        XCTAssert(downloadsSession.delegate != nil)
    }
}
