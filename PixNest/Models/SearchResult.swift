//
//  ImageModel.swift
//  PixNest
//
//  Created by Andrea Bottino on 26/10/2024.
//

import Foundation

struct SearchResult: Codable {
    
    let total: Int
    var totalPages: Int
    var results: [Result]
}

struct Result: Codable {
    let urls: URLS
    let user: User
    let links: Link
}

struct User: Codable {
    let name : String
    let profileImage: ProfileImage
    let links: Links
}

struct ProfileImage: Codable {
    let medium: String
}

struct Links: Codable {
    let html: String
}

struct URLS: Codable {
    let small: String
    let full: String
}

struct Link: Codable {
    let downloadLocation: String
}
