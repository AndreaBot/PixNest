//
//  ImageDownloader.swift
//  PixNest
//
//  Created by Andrea Bottino on 28/10/2024.
//

import Foundation
import UIKit

@Observable
class ImageDownloader: NSObject {
    
    var showingDownloadAlert = false
    var downloadAlertTitle = ""
    var downloadAlertMessage = ""
    
    var downloadIsSuccessful = false
    
    func triggerDownloadCount(_ URLString: String) {
        guard let downloadLocation = URL(string: "\(URLString)&client_id=\(K.ImageSearch.apiKey)") else {
            return
        }
        URLSession.shared.dataTask(with: downloadLocation).resume()
    }
    
    func download(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveImage(_:error:context:)), nil)
    }
    
    @objc func saveImage(_ image: UIImage, error: Error?, context: UnsafeMutableRawPointer?) {
        if let error = error {
            downloadAlertTitle = "❌ Oops..."
            downloadAlertMessage = ("Error saving image: \(error)")
            showingDownloadAlert = true
        } else {
            downloadIsSuccessful = true
            downloadAlertTitle = "✅ Success!"
            downloadAlertMessage = ("Image successfully saved to your Photos")
            showingDownloadAlert = true
        }
    }
}
