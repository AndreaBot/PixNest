//
//  Constants.swift
//  PixNest
//
//  Created by Andrea Bottino on 26/10/2024.
//

import Foundation
import DeveloperToolsSupport

struct K {
    
    struct General {
        static let appName = "PixNest"
        static let allCategories = [
            MyResource(name: "Cars", keyword: "car", asset: .cars),
            MyResource(name: "Cities", keyword: "city", asset: .cities),
            MyResource(name: "Animals", keyword: "animal", asset: .animals),
            MyResource(name: "Nature", keyword: "nature", asset: .nature),
            MyResource(name: "Space", keyword: "universe", asset: .space),
            MyResource(name: "Abstract", keyword: "abstract", asset: .abstract),
            MyResource(name: "B&W", keyword: "black and white", asset: .B_W),
            MyResource(name: "Sketches", keyword: "illustration", asset: .illustrations)
        ]
    }
    
    struct Icons {
        static let search = "magnifyingglass.circle"
        static let prevPage = "chevron.left.circle.fill"
        static let nextPage = "chevron.right.circle.fill"
        static let sort = "arrow.up.arrow.down"
        static let pixnest = "photo.on.rectangle.angled"
        static let favourites = "heart.fill"
    }
    
    struct ImageSearch {
        static let apiKey = "GKREyJQ1MCESHa8rBNmBC_70ZcKWVOsmeU1U--edAv4"
    }
}
