//
//  UtilitiesTests.swift
//  FlickrImageSearchTests
//
//  Created by Vandan Patel on 7/27/19.
//  Copyright © 2019 Vandan Patel. All rights reserved.
//

@testable import FlickrImageSearch
import XCTest

class UtilitiesTests: XCTestCase {
    
    let photo = Photo(ID: "48384911822", secret: "c617d385fd", serverID: "65535", farmID: 66)
    
    func testConstructImageURL() {
        let url = Utilities.shared.constructImageURL(for: photo)
        let expectedURL = "https://farm66.staticflickr.com/65535/48384911822_c617d385fd.jpg"
        XCTAssertEqual(url, expectedURL)
    }
}
