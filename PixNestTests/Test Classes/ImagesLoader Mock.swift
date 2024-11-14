//
//  ImagesLoader Mock.swift
//  PixNestTests
//
//  Created by Andrea Bottino on 14/11/24.
//

import Foundation
@testable import PixNest

class ImagesLoaderMock: ImagesLoader {
    var onStageChange: ((LoadingState) -> Void)?
    
    override var loadingState: LoadingState {
        didSet {
            onStageChange?(loadingState)
        }
    }
}
