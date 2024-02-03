//
//  SourceEntity.swift
//  NewsApp
//
//  Created by amartek on 02/02/24.
//

import Foundation

struct SourceResponse: Decodable {
    let status: String
    let sources: [SourceEntity]
}

struct SourceEntity: Decodable {
    let id: String
    let name: String
    let description: String
    let flag: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case language
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        description = try container.decode(String.self, forKey: .description)
        let language = try container.decode(String.self, forKey: .language)
        
        func getFlag(lan: String) -> String {
            let dict: [String: String] = [
                "ar": "🇸🇦", // Arabic
                "de": "🇩🇪", // German
                "en": "🇬🇧", // English
                "es": "🇪🇸", // Spanish
                "fr": "🇫🇷", // French
                "he": "🇮🇱", // Hebrew
                "it": "🇮🇹", // Italian
                "nl": "🇳🇱", // Dutch
                "no": "🇳🇴", // Norwegian
                "pt": "🇵🇹", // Portuguese
                "ru": "🇷🇺", // Russian
                "sv": "🇸🇪", // Swedish
                "ud": "🇵🇰", // Urdu
                "zh": "🇨🇳"  // Chinese
            ]
            return dict[lan] ?? ""}
            
        flag = getFlag(lan: language)
    }
}
