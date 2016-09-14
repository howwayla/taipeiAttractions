//
//  TAGetAttractionsTests.swift
//  taipeiAttractions
//
//  Created by Hardy on 2016/6/27.
//  Copyright © 2016年 Hardy. All rights reserved.
//

import XCTest
import Nimble
import OHHTTPStubs

class TAGetAttractionsTests: XCTestCase {
    
    let router = TAAttractionRouter.attractions
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        OHHTTPStubs.removeAllStubs()
    }

    
    //MARK:- Test router
    func testRouterPath() {
        expect(self.router.path).to(equal("/opendata/datalist/apiAccess"))
    }
    
    func testRouterParameters() {
        expect(self.router.parameters).toNot(beNil())
        expect(self.router.parameters!["scope"] as? String).to(equal("resourceAquire"))
        expect(self.router.parameters!["rid"] as? String).to(equal("36847f3f-deff-4183-a5bb-800737591de5"))
    }
    
    
    //MARK:- Test Service
    func testGetAttractionsSuccess() {
        let expectation = self.expectation(description: "test get attractions success")
        
        TAAttractionService.getAttractions() { result in
            expect(result.isSuccess).to(beTrue())
            expect(result.error).to(beNil())
            expect(result.value?.count).to(equal(319))
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(100) { error in
            expect(error).to(beNil())
        }
    }

    /**
     Test get attraction success but without results JSON data
     */
    func testGetAttractionsSuccessWithZeroAttraction() {
        let JSON = [
            "result":[
                "offset":0,
                "limit":10000,
                "count":0,
                "sort":""
                ]
            ]
        stub(isHost("data.taipei")) { _ in
            return OHHTTPStubsResponse(JSONObject: JSON, statusCode: 200, headers: nil)
        }
        
        let expectation = self.expectation(description: "test get attractions success")
        
        TAAttractionService.getAttractions() { result in
            expect(result.isSuccess).to(beTrue())
            expect(result.error).to(beNil())
            expect(result.value?.count).to(equal(0))
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(100) { error in
            expect(error).to(beNil())
        }
    }
    
    
    /**
     Test get attraction fail when internet not available
     */
    func testGetAttractionsFail() {
        let notConnectedError = NSError(domain:NSURLErrorDomain,
                                        code:Int(CFNetworkErrors.cfurlErrorNotConnectedToInternet.rawValue),
                                        userInfo:nil)
        stub(isHost("data.taipei")) { _ in
            return OHHTTPStubsResponse(error:notConnectedError)
        }

        
        let expectation = self.expectation(description: "test get attractions fail")
        
        TAAttractionService.getAttractions() { result in
            expect(result.isFailure).to(beTrue())
            expect(result.error).toNot(beNil())
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(100) { error in
            expect(error).to(beNil())
        }
    }
}
