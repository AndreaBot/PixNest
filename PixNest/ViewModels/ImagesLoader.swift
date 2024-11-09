//
//  ImageLoader.swift
//  PixNest
//
//  Created by Andrea Bottino on 9/11/24.
//

import UIKit

@Observable
final class ImagesLoader {
    
    var loadingIsComplete = false
    
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
    
    func loadCoreDataImages(from photoArray: [SavedPhoto]) async -> ([UIImage], Bool) {
        var images: [UIImage] = []
        var completionTrackerResult = false
        
        for photo in photoArray {
            guard let photoUrl = photo.lowResUrl else {
                return (images, completionTrackerResult)
            }
            if let imageData = await loadImage(urlString: photoUrl) {
                if let uiImage = UIImage(data: imageData) {
                    images.append(uiImage)
                }
            }
        }
        
        completionTrackerResult = true
        return (images, completionTrackerResult)
    }
    
    func loadAPIImages(from photoArray: [Result]) async -> ([UIImage], Bool) {
        var images: [UIImage] = []
        var completionTrackerResult = false
        
        for photo in photoArray {
            if let imageData = await loadImage(urlString: photo.urls.small) {
                if let uiImage = UIImage(data: imageData) {
                    images.append(uiImage)
                }
            }
        }
        
        completionTrackerResult = true
        return (images, completionTrackerResult)
    }
}
