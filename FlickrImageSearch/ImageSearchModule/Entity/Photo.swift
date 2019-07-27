//
//  Photo.swift
//  FlickrImageSearch
//
//  Created by Vandan Patel on 7/27/19.
//  Copyright © 2019 Vandan Patel. All rights reserved.
//

import Foundation

struct Photo: Codable {
    let ID: String
    let secret: String
    let serverID: String
    let farmID: Int
    
    private enum CodingKeys: String, CodingKey {
        case ID = "id"
        case farmID = "farm"
        case serverID = "server"
        case secret = "secret"
    }
}
