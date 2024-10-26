//
//  ResultsView.swift
//  PixNest
//
//  Created by Andrea Bottino on 26/10/2024.
//

import SwiftUI

struct ResultsView: View {
    
    @Binding var searchViewModel: SearchViewModel
    @State private var images = [Image]()
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                ImagesGrid(searchViewModel: $searchViewModel, screen: proxy.size, images: $images)
                    .padding(.horizontal)
                
                Spacer()
                
                PageNavigator(currentPage: $searchViewModel.pageNumber, totalPages: $searchViewModel.searchResults.total_pages)
            }
            .navigationTitle(searchViewModel.searchKeyword.capitalized)
            .navigationBarTitleDisplayMode(.inline)
            .task {
                searchViewModel.searchResults =  await searchViewModel.fetchImages(searchKey: searchViewModel.searchKeyword)
                for result in searchViewModel.searchResults.results {
                    if let imageData =  await searchViewModel.loadImage(urlString: result.urls.small) {
                        let UIImage = UIImage(data: imageData)
                        images.append(Image(uiImage: UIImage!))
                    }
                }
            }
        }
    }
}

//#Preview {
//    ResultsView(searchViewModel: .constant(SearchViewModel()))
//}
