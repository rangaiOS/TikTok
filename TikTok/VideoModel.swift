//
//  VideoModel.swift
//  Tiktok
//
//  Created by Rishabh on 17/02/23.
//  Copyright © 2023 Ranga. All rights reserved.
//

import Foundation


// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

// MARK: - WelcomeElement
struct VideoJSON: Codable {
    var id, title: String?
    var thumbnailURL: String?
    var duration, uploadTime, views, author: String?
    var videoURL: String?
    var description, subscriber: String?
    var isLive: Bool?

    enum CodingKeys: String, CodingKey {
        case id, title
        case thumbnailURL = "thumbnailUrl"
        case duration, uploadTime, views, author
        case videoURL = "videoUrl"
        case description, subscriber, isLive
    }
}

