//
//  UIKitNoteTests.swift
//  UIKitNoteTests
//
//  Created by HuangSenhui on 2020/12/20.
//

import XCTest
@testable import UIKitNote

class UIKitNoteTests: XCTestCase {

    func testInitialSuccess() {
        //
        let meal = Meal(name: "清蒸鱼", image: nil, rating: 5)
        
        XCTAssertNotNil(meal)
        
        let zeroRating = Meal(name: "清蒸鱼", image: nil, rating: 0)
        XCTAssertNotNil(zeroRating)
    }
    
    func testInitialFailure() {
        let emptyName = Meal(name: "", image: nil, rating: 8)
        
        XCTAssertNil(emptyName)
        
        for i in [-1, 6] {
            let outOfRange = Meal(name: "清蒸鱼", image: nil, rating: i)
            
            XCTAssertNil(outOfRange, "失败: \(i)")
        }
    }

}
