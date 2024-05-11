//
//  Planet.swift
//  NasaDataSet-Assignment
//
//  Created by Hsu Hua on 2024/4/25.
//

import Foundation

struct Planet: Codable {
    let description: String
    let copyright: String
    let title: String
    let url: URL
    let apodSite: URL
    var date: String
    let mediaType: String
    var hdurl: URL
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        if let date = formatter.date(from: date) {
            formatter.dateFormat = "yyyy MMM. dd"
            return formatter.string(from: date)
        } else {
            return date
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case description = "description"
        case copyright = "copyright"
        case title = "title"
        case url = "url"
        case apodSite = "apod_site"
        case date = "date"
        case mediaType = "media_type"
        case hdurl = "hdurl"
    }
}
