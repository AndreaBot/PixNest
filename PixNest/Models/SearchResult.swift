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


//MARK: - Extensions

extension SearchResult: Equatable {
    static func == (lhs: SearchResult, rhs: SearchResult) -> Bool {
        lhs.total == rhs.total
        &&
        lhs.totalPages == rhs.totalPages
        &&
        lhs.results == rhs.results
    }
}

extension Result: Equatable {
    static func == (lhs: Result, rhs: Result) -> Bool {
        lhs.urls.full == rhs.urls.full
    }
}

extension URLS: Equatable {
    static func == (lhs: URLS, rhs: URLS) -> Bool {
        lhs.small == rhs.small
        &&
        lhs.full == rhs.full
    }
}

extension ProfileImage: Equatable {
    static func == (lhs: ProfileImage, rhs: ProfileImage) -> Bool {
        lhs.medium == rhs.medium
    }
}

extension Links: Equatable {
    static func == (lhs: Links, rhs: Links) -> Bool {
        lhs.html == rhs.html
    }
}

extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.name == rhs.name
        &&
        lhs.profileImage == rhs.profileImage
        &&
        lhs.links == rhs.links
    }
}
