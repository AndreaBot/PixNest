//
//  ImageLoader.swift
//  PixNest
//
//  Created by Andrea Bottino on 9/11/24.
//

import UIKit

@Observable
class ImagesLoader {
    
    var loadingState: LoadingState = .loading
    
    func loadImage(urlString: String, URLSessionProvider: URLSessionProvider = URLSession.shared) async -> Data? {
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        do {
            let (data, _) = try await URLSessionProvider.data(from: url)
            return data
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    func loadCoreDataImages(from photoArray: [SavedPhoto]) async -> [UIImage] {
        var images: [UIImage] = []
        loadingState = .loading
        
        for photo in photoArray {
            guard let photoUrl = photo.lowResUrl else {
                return images
            }
            if let imageData = await loadImage(urlString: photoUrl) {
                if let uiImage = UIImage(data: imageData) {
                    images.append(uiImage)
                }
            }
        }
        
        loadingState = .loaded
        return images
    }
    
    func loadAPIImages(from photoArray: [Result]) async -> [UIImage] {
        var images: [UIImage] = []
        loadingState = .loading
        
        for photo in photoArray {
            if let imageData = await loadImage(urlString: photo.urls.small) {
                if let uiImage = UIImage(data: imageData) {
                    images.append(uiImage)
                }
            }
        }
        
        loadingState = .loaded
        return images
    }
}
