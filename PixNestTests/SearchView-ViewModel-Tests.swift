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

    override func setUpWithError() throws {
        searchViewModel = SearchViewModel()
    }

    override func tearDownWithError() throws {
        searchViewModel = nil
    }

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

}
