//
//  CustomModel.swift
//  UITextField
//
//  Created by Aleksandr Bagdasaryan on 11.07.23.
//

import Foundation

struct EsShatImanamInch: Decodable {
    let name: String?
}

struct TaskModel: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
    let body: String?
}

struct PhotoModel: Codable {
    let albumID: Int?
    let id: Int?
    let title: String?
    let url, thumbnailURL: String?

    enum CodingKeys: String, CodingKey {
        case albumID = "albumId"
        case id, title, url
        case thumbnailURL = "thumbnailUrl"
    }
}
