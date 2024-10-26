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
    var searchResults = [Result]()
    
    func fetchImages(searchKey: String) async -> ([Result], Int) {
        let baseUrl = "https://api.unsplash.com/search/photos/?orientation=portrait"
        var results = [Result]()
        var totalPages = 0
        
        guard let encodedText = searchKey.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            fatalError("The search keywords could not be encoded")
        }
        
        guard let searchUrl = URL(string: "\(baseUrl)&query=\(encodedText)&page=\(pageNumber)&per_page=20&client_id=\(K.ImageSearch.apiKey)") else {
            fatalError("Invalid URL")
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: searchUrl)
            if let decodedData = try? JSONDecoder().decode(SearchResult.self, from: data) {
                results = decodedData.results
                totalPages = decodedData.total_pages
            }
        } catch {
            print(error.localizedDescription)
    }
        return (results, totalPages)
    }
}
