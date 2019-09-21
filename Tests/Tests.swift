//
//  Tests.swift
//  Tests
//
//  Created by Sergey Makeev on 20/09/2019.
//  Copyright © 2019 Sergey Makeev. All rights reserved.
//


import XCTest
import SwiftAnonymousClass

protocol ADelegate: class {
	func `do`()
}

class A {
	weak var delegate: ADelegate?
	
	deinit {
		delegate?.do()
	}
}

//////////////////////////////

protocol Greeting {
	func sayHello() -> String
}

/////////////////////////////

class Tests: XCTestCase {
	
	var testExpectations: [String]!
	var testResult: [String]!
	
	override func setUp() {
		testExpectations = [String]()
		testResult = [String]()
		
	}
	
	override func tearDown() {
		XCTAssert(testExpectations == testResult)
	}
	
	func testExample() {
		let object: Greeting? = _new {
			class NoName: Greeting {
				func sayHello() -> String {
					return "hello from no name class"
				}
			}
			return NoName()
		}
		XCTAssert("hello from no name class" == object?.sayHello())
	}
	
	func testURLSessionDelegate() {
		let configuration = URLSessionConfiguration.default
		let downloadsSession = URLSession(configuration: configuration,
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
	
	func testLifeTime() {
	
		testExpectations = ["first delegate deinit", "DO from second", "second delegate deinit"]
	
		let a = A()
		a.delegate = _new(owner: a) {
			
			class ADelegateInstance: ADelegate {
				let superSelf: Tests!
				init(_ tests: Tests) {
					superSelf = tests
				}
			
				func `do`() {
					superSelf.testResult.append("DO from first")
				}
				
				deinit {
					superSelf.testResult.append("first delegate deinit")
				}
			}
			
			return ADelegateInstance(self)
		}
	
		a.delegate = _new(owner:a) {
			class ADelegateInstance: ADelegate {
				let superSelf: Tests!
				init(_ tests: Tests) {
					superSelf = tests
				}
				func `do`() {
					superSelf.testResult.append("DO from second")
				}
				
				deinit {
					superSelf.testResult.append("second delegate deinit")
				}
			}
			
			return ADelegateInstance(self)
		}
	}
	
}
