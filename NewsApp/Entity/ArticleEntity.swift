//
//  NewsEntity.swift
//  NewsApp
//
//  Created by amartek on 02/02/24.
//

import Foundation

struct ArticleResponse: Decodable {
    let status: String
    let totalResults: Int
    let articles: [ArticleEntity]
}

struct ArticleEntity: Decodable {
    let title: String
    let url: String
    let urlToImage: String?
    let publishedDate: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case url
        case urlToImage
        case publishedAt
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        url = try container.decode(String.self, forKey: .url)
        urlToImage = try container.decodeIfPresent(String.self, forKey: .urlToImage)
        let publishedAt = try container.decode(String.self, forKey: .publishedAt)
        
        func getDateFormat(_ dateString: String) -> String {
            let _dateString = dateString.split(separator: ".").map({String($0)}).first ?? ""
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            
            if let date = dateFormatter.date(from: _dateString) {
                let currentDate = Date()
                let calendar = Calendar.current
                
                if calendar.isDateInToday(date) {
                    let hoursAgo = calendar.dateComponents([.hour], from: date, to: currentDate).hour ?? 0
                    if hoursAgo > 1 {
                        return "\(hoursAgo) hours ago"
                    }
                    return "just now"
                } else if calendar.isDateInYesterday(date) {
                    return "yesterday"
                } else {
                    let daysAgo = calendar.dateComponents([.day], from: date, to: currentDate).day ?? 0
                    if daysAgo < 7 {
                        return "\(daysAgo) days ago"
                    }
                }
            }
            return _dateString.split(separator: "T").map({String($0)}).first ?? ""
        }
        publishedDate = getDateFormat(publishedAt)
    }
}


