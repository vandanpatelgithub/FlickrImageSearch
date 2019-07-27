//
//  Utilities.swift
//  FlickrImageSearch
//
//  Created by Vandan Patel on 7/27/19.
//  Copyright © 2019 Vandan Patel. All rights reserved.
//

import Foundation

class Utilities {
    private init() {}
    static let shared = Utilities()
    
    func constructImageURL(for photo: Photo) -> String {
        return "https://farm\(photo.farmID).staticflickr.com/\(photo.serverID)/\(photo.ID)_\(photo.secret).jpg"
    }
}
