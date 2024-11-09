//
//  SortType.swift
//  PixNest
//
//  Created by Andrea Bottino on 29/10/2024.
//

import Foundation

enum SortType: String, CaseIterable {
    case relevant
    case latest

    var displayName: String {
        switch self {
        case .relevant:
            return "Most relevant"
        case .latest:
            return "Newest"
        }
    }
}
