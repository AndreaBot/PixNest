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
            MyResource(name: "Cars", asset: .cars),
            MyResource(name: "Cities", asset: .cities),
            MyResource(name: "Animals", asset: .animals),
            MyResource(name: "Nature", asset: .nature),
            MyResource(name: "Space", asset: .space),
            MyResource(name: "Abstract", asset: .abstract),
            MyResource(name: "B&W", asset: .B_W),
            MyResource(name: "Graphics", asset: .illustrations)
        ]
    }
    
    struct Icons {
        static let search = "magnifyingglass.circle"
    }
    
    struct ImageSearch {
        static let apiKey = "GKREyJQ1MCESHa8rBNmBC_70ZcKWVOsmeU1U--edAv4"
    }
}
