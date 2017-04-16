//
//  Sample_API_Layer_DemoTests.swift
//  Sample-API-Layer-DemoTests
//
//  Created by NishiokaKohei on 2017/04/16.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import XCTest
import Himotoki
@testable import Sample_API_Layer_Demo

class Sample_API_Layer_DemoTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testSetData() {
    }


    func testOrganizer() {
        var JSON = ["total_hit_count": 50,
                    "hit_per_page": 3,
                    "page_offset": 100,
                    "rest": ""] as [String : Any]

        let null: Any? = nil
        let json = ["": []]
        XCTAssert(AreaLMasters.organizer(null) != nil)
        XCTAssert(AreaLMasters.organizer(json) != nil)
        XCTAssert(AreaLMasters.organizer(JSON) != nil)
    }

    func testGnaviResults() {

        var JSON = ["total_hit_count": 50,
                                   "hit_per_page": 3,
                                   "page_offset": 100,
                                   "rest": ""] as [String : Any]
        guard let json = JSON as? Extractor else {
            return
        }

        let gnavi = try? GnaviResults.decode(json)
        XCTAssert(gnavi == nil)
        XCTAssert(gnavi?.count == 50)
        XCTAssert(gnavi?.page == 3)
        XCTAssert(gnavi?.pageOffset == 100)
        XCTAssert(gnavi?.rest == nil)

        JSON["rest"] = nil
        do {
            try GnaviResults.decodeValue(JSON)
        } catch let DecodeError.missingKeyPath(keyPath) {
            XCTAssert(keyPath == "rest")
        } catch {
            XCTFail()
        }

    }

    func testRestraunts(){
//        var JSON: [String: Any] = ["name": "Hoge ほげ屋",
//                                   "access": ["station": "東京",
//                                              "walk": 5],
//                                   "adress": "埼玉県北本市",
//                                   "image_url": ["shop_image1": "https://yahoo.co.jp"],
//                                   "budget": 5000,
//                                   "tel": "0000-00-0001"]
//
//        let group = try? Restraunt.decodeValue(JSON)
//        XCTAssert(group == nil)
//        XCTAssert(group?.name == "Hoge ほげ屋")
//        XCTAssert(group?.station == "東京")
//        XCTAssert(group?.walk == 5)
//        XCTAssert(group?.adress == "埼玉県北本市")
//        XCTAssert(group?.tel == "0000-00-0001")
//        XCTAssert(group?.budget == 5000)
//        XCTAssert(group?.thumbnailURL == "https://yahoo.co.jp")
//
//        JSON["rest"] = nil
//        do {
//            try Restraunt.decodeValue(JSON)
//        } catch let DecodeError.missingKeyPath(keyPath) {
//            XCTAssert(keyPath == "rest")
//        } catch {
//            XCTFail()
//        }
    }
    
}
