//
//  SearchView-ViewModel-Tests.swift
//  PixNestTests
//
//  Created by Andrea Bottino on 12/11/24.
//

import XCTest
@testable import PixNest

final class SearchView_ViewModel_Tests: XCTestCase {
    
    var searchViewModel: SearchViewModel!
    
    
    //MARK: - SETUP AND TEARDOWN
    override func setUpWithError() throws {
        searchViewModel = SearchViewModel()
    }
    
    override func tearDownWithError() throws {
        searchViewModel = nil
    }
    
    
    //MARK: - SUPPORT FUNCTIONS
    
    func fetchTestImages() async -> SearchResult {
        await searchViewModel.fetchImages(searchKey: "tree", URLSessionProvider: URLSessionMock(testData: Data(SupportData.testJSON.utf8)))
    }
    
    
    //MARK: - TESTS
    
    func test_searchKeyword_startsEmpty() {
        XCTAssertEqual(searchViewModel.searchKeyword, "", "The searchKeyword does not start emoty")
    }
    
    func test_pageNumber_startsAtOne() {
        XCTAssertEqual(searchViewModel.pageNumber, 1, "The initial page number is not 1")
    }
    
    func test_searchResults_startsEmpty() {
        let emptySearchResults = SearchResult(total: 0, totalPages: 0, results: [])
        XCTAssertEqual(searchViewModel.searchResults, emptySearchResults, "The initial search results are not empty")
    }
    
    func test_fetchImages_returnsOneResult() async {
        // WHEN
        let searchResults = await fetchTestImages()
        
        // THEN
        XCTAssertEqual(searchResults.results.count, 1, "Wrong number of results")
    }
    
    func test_fetchImages_decodesCorrectly() async {
        // WHEN
        let searchResults = await fetchTestImages()
        
        // THEN
        XCTAssertEqual(searchResults, SupportData.testSearchResult, "JSON decoding failed")
    }
    
    func test_URLS_decodesCorrectly() async {
        // WHEN
        let searchResults = await fetchTestImages()
        
        // THEN
        XCTAssertEqual(searchResults.results[0].urls, SupportData.testUrls, "The URLs do not match")
    }
    
    func test_User_decodesCorrectly() async {
        // WHEN
        let searchResults = await fetchTestImages()
        
        // THEN
        XCTAssertEqual(searchResults.results[0].user, SupportData.testUser, "The users do not match")
    }
    
    func test_emptyJSON_setLoadingStateToNoResults() async {
        // WHEN
        let _ = await searchViewModel.fetchImages(searchKey: "hexsjjri", URLSessionProvider: URLSessionMock(testData: Data(SupportData.emptyJSON.utf8)))
        
        // THEN
        XCTAssertEqual(searchViewModel.imagesLoader.loadingState, .noResults, "Te loading state does not get set correctly")
        
    }
    
}
