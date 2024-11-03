//
//  AlertsManager.swift
//  PixNest
//
//  Created by Andrea Bottino on 2/11/24.
//

import Foundation

@Observable
final class AlertsManager {
    
    var triggerType: AlertTriggerType = .imageDownloader
    var alertTitle = ""
    var alertMessage = ""
    var isShowingAlert = false
    
    func showError(_ error: Error) {
        alertTitle = "❌ Error"
        alertMessage = error.localizedDescription
        isShowingAlert = true
    }
    
    func showDownloadConfirmation() {
        triggerType = .imageDownloader
        alertTitle = "✅ Success!"
        alertMessage = "Image successfully saved to your Photos"
        isShowingAlert = true
    }
    
    func showAddingToFavouritesConfirmation() {
        triggerType = .coreDataManager
        alertTitle = "🧡 Saved!"
        alertMessage = "Image successfully added to your favourites"
        isShowingAlert = true
    }
}
