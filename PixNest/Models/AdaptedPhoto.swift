//
//  AdaptedPhoto.swift
//  PixNest
//
//  Created by Andrea Bottino on 8/11/24.
//

import Foundation

struct AdaptedPhoto: Identifiable, ImageURLsProvider {
    let id: Date
    var urls: URLS
}
