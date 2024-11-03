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
    
    var alertsManager: AlertsManager?
    
    var showingDownloadAlert = false
    var downloadAlertTitle = ""
    var downloadAlertMessage = ""
    
    var downloadIsSuccessful = false
    
    init(alertsManager: AlertsManager? = nil) {
        self.alertsManager = alertsManager
    }
    
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
            alertsManager?.showError(error)
        } else {
            downloadIsSuccessful = true
            alertsManager?.showDownloadConfirmation()
        }
    }
}
