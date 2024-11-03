//
//  SearchView-ViewModel.swift
//  PixNest
//
//  Created by Andrea Bottino on 26/10/2024.
//

import Foundation

@Observable
final class SearchViewModel {
    
    var searchKeyword = ""
    var pageNumber = 1
    var sortType: SortType = .relevant
    var searchResults = SearchResult(total: 0, total_pages: 0, results: [])
    
    var hasLoadedImages = false
    
    var selectedImage: Result?
    
    func fetchImages(searchKey: String) async -> SearchResult {
        let baseUrl = "https://api.unsplash.com/search/photos/?orientation=portrait"
        var results = SearchResult(total: 0, total_pages: 0, results: [])
        
        guard let encodedText = searchKey.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            fatalError("The search keywords could not be encoded")
        }
        
        guard let searchUrl = URL(string: "\(baseUrl)&query=\(encodedText)&page=\(pageNumber)&per_page=24&order_by=\(sortType.rawValue)&client_id=\(K.ImageSearch.apiKey)") else {
            fatalError("Invalid URL")
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: searchUrl)
            if let decodedData = try? JSONDecoder().decode(SearchResult.self, from: data) {
                results = decodedData
            }
        } catch {
            print(error.localizedDescription)
    }
        return results
    }
    
    func loadImage(urlString: String) async -> Data? {
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return data
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}
