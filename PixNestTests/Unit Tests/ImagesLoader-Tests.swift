//
//  ImagesLoader-Tests.swift
//  PixNestTests
//
//  Created by Andrea Bottino on 13/11/24.
//

import XCTest
@testable import PixNest

final class ImagesLoader_Tests: XCTestCase {
    
    var imagesLoader: ImagesLoader!
    
    
    //MARK: - SETUP AND TEARDOWN
    
    override func setUpWithError() throws {
        imagesLoader = ImagesLoader()
    }
    
    override func tearDownWithError() throws {
        imagesLoader = nil
    }
    
    
    //MARK: - Tests
    
    func test_loadImages_returnsNilWithInvalidURL() async {
        // GIVE
        let invalidURLString = "Invalid URL"
        
        // WHEN
        let data = await imagesLoader.loadImage(urlString: invalidURLString)
        
        // THEN
        XCTAssertNil(data, "The func passed the guard statement")
    }
    
    func test_loadImages_doesNotReturnNilWithValidURL() async {
        // GIVEN
        let validURLString = SupportData.testUrls.small
        let UrlSessionMock = URLSessionMock(testData: Data(validURLString.utf8))
        
        // WHEN
        let data = await imagesLoader.loadImage(urlString: validURLString, URLSessionProvider: UrlSessionMock)
        
        // THEN
        XCTAssertNotNil(data, "The valid URL did not return data")
    }
    
    func test_loadAPIImages_switchesLoadingStateAtStartAndEnd() async {
        // GIVEN
        let loadingExpectation = expectation(description: "state changed to .loading")
        let loadedExpectation = expectation(description: "state changed to .loaded")
        let imagesLoaderMock = ImagesLoaderMock()
        
        imagesLoaderMock.onStageChange = { state in
            if state == .loading {
                XCTAssertEqual(state, .loading, "Expected state to be .loading")
                loadingExpectation.fulfill()  // Only fulfill if state is .loading
            } else if state == .loaded {
                XCTAssertEqual(state, .loaded, "Expected state to be .loaded")
                loadedExpectation.fulfill()  // Only fulfill if state is .loading
            }
        }
        
        // WHEN
        let _ = await imagesLoaderMock.loadAPIImages(from: [])
        
        // THEN
        Task {
            await fulfillment(of: [loadingExpectation, loadedExpectation], timeout: 5)
        }
    }
    
    
}
