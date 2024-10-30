//
//  Extension - EnvironmentValues.swift
//  PixNest
//
//  Created by Andrea Bottino on 30/10/24.
//

import Foundation
import SwiftUI

extension EnvironmentValues {
    var coreDataManager: CoreDataManager {
        get { CoreDataManager.shared }
        set { }
    }
}
