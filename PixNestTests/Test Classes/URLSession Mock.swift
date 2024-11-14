//
//  URLSession Mock.swift
//  PixNestTests
//
//  Created by Andrea Bottino on 14/11/24.
//

import Foundation
@testable import PixNest

class URLSessionMock: URLSessionProvider {
    let testData: Data
    
    init(testData: Data) {
        self.testData = testData
    }
    
    func data(from: URL) async throws -> (Data, URLResponse) {
        let testData = testData
        let response = URLResponse()
        return (testData, response)
    }
}
