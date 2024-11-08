//
//  CoreDataAdapter.swift
//  PixNest
//
//  Created by Andrea Bottino on 8/11/24.
//

import SwiftUI

@Observable
final class CoreDataAdapter {
    
    var convertedData: [AdaptedPhoto] = []
    
    func convertData(from coreDataEntities: [SavedPhoto]){
        convertedData = []
        for entity in coreDataEntities {
            if let savedPhotoId = entity.id, let savedPhotoLowRes = entity.lowResLink, let savedPhotoHighRes = entity.highResLink {
                let urls = URLS(small: savedPhotoLowRes, full: savedPhotoHighRes)
                let convertedPhoto = AdaptedPhoto(id: savedPhotoId, urls: urls)
                convertedData.append(convertedPhoto)
            }
        }
    }
}
