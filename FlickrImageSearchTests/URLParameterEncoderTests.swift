//
//  URLParameterEncoderTests.swift
//  FlickrImageSearchTests
//
//  Created by Vandan Patel on 7/27/19.
//  Copyright © 2019 Vandan Patel. All rights reserved.
//

@testable import FlickrImageSearch
import XCTest

class URLParameterEncoderTests: XCTestCase {
    
    let parameters: Parameters = [
        "method": "flickr.photos.search",
        "api_key": "0fe1aaa149e2cd9cfae6d59c927e453f",
        "text": "Food",
        "format": "json",
        "page": 1
        ]

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testEncode() {
        guard let url = URL(string: "https://www.flickr.com") else {
            XCTFail("Error building URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.url?.appendPathComponent("services/rest/")
        
        do {
            try URLParameterEncoder.encode(urlRequest: &request, with: parameters)
            guard let url = request.url else {
                XCTFail()
                return
            }
            
            let delimiter = "?"
            var urlBeforeParameters = url.absoluteString.components(separatedBy: delimiter)
            XCTAssertEqual(urlBeforeParameters[0], "https://www.flickr.com/services/rest/")
            
            let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
            XCTAssertEqual(components?.queryItems?.count, 5)
            XCTAssertTrue(components?.queryItems?.contains(URLQueryItem(name: "method", value: "flickr.photos.search")) ?? false)
            XCTAssertTrue(components?.queryItems?.contains(URLQueryItem(name: "api_key", value: "0fe1aaa149e2cd9cfae6d59c927e453f")) ?? false)
            XCTAssertTrue(components?.queryItems?.contains(URLQueryItem(name: "text", value: "Food")) ?? false)
            XCTAssertTrue(components?.queryItems?.contains(URLQueryItem(name: "format", value: "json")) ?? false)
            XCTAssertTrue(components?.queryItems?.contains(URLQueryItem(name: "page", value: "1")) ?? false)
        } catch {
            XCTFail("Error: \(error.localizedDescription)")
        }
    }
    
}
