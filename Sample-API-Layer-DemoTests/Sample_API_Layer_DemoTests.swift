//
//  Sample_API_Layer_DemoTests.swift
//  Sample-API-Layer-DemoTests
//
//  Created by NishiokaKohei on 2017/04/16.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import XCTest
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


    func testGnaviResults() {
        // (注意)
        // 非オプショナル型で宣言したプロパティがある場合には,
        // ここに必ず定義しておく必要があります。
        // さもないとデコード中にクラッシュが発生します.

        // given
        var object = Dictionary<String, Any>()
        object["total_hit_count"] = "30"
        object["hit_per_page"] = "3"
        object["page_offset"] = "100"
        object["rest"] = []
        var data: Data
        do {
            let jsonData = try! JSONSerialization.data(withJSONObject: object, options: [])
            let string = String(data: jsonData, encoding: .utf8)!
            data = string.data(using: .utf8)!
        }

        // when
        let gnavi = try! JSONDecoder().decode(GnaviResults.self, from: data)

        // then
        XCTAssertTrue(gnavi.page == 3)
        XCTAssertTrue(gnavi.pageOffset == 100)
        XCTAssertTrue(gnavi.count == 30)
    }

    func testRestraunts(){
        // (注意)
        // 非オプショナル型で宣言しているプロパティがある場合には,
        // ここに必ず定義しておく必要があります。
        // さもないとデコード中にクラッシュが発生します.

        // given
        var object = Dictionary<String, Any>()
        object["name"] = "Hoge ほげ屋"
        object["access"] = ["station": "東京", "walk": "5"]
        object["address"] = "埼玉県北本市"
        object["image_url"] = ["shop_image1": "https://yahoo.co.jp"]
        object["budget"] = "5000"
        object["tel"] = "0000-00-0001"
        object["walk"] = ""
        object["id"] = "1234"
        let jsonData = try! JSONSerialization.data(withJSONObject: object, options: [])
        let string = String(data: jsonData, encoding: .utf8)!
        let data = string.data(using: .utf8)!

        // when
        let restraunt = try! JSONDecoder().decode(Restraunt.self, from: data)

        // then
        XCTAssertTrue(restraunt.name == "Hoge ほげ屋")
        XCTAssertTrue(restraunt.station == "東京")
        XCTAssertTrue(restraunt.walk == "5")
        XCTAssertTrue(restraunt.address == "埼玉県北本市")
        XCTAssertTrue(restraunt.tel == "0000-00-0001")
        XCTAssertTrue(restraunt.budget == 5000)
        XCTAssertTrue(restraunt.thumbnailURL == "https://yahoo.co.jp")
    }
    
}
