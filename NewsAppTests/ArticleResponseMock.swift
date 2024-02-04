//
//  ArticleResponseMock.swift
//  NewsAppTests
//
//  Created by amartek on 03/02/24.
//

import Foundation

struct ArticleResponseMock {
    static var successGetPage: String {
        "{\"status\":\"ok\",\"totalResults\":10,\"articles\":[{\"source\":{\"id\":\"ars-technica\",\"name\":\"Ars Technica\"},\"author\":\"Stephen Clark\",\"title\":\"Rocket Report: SpaceX at the service of a rival; Endeavour goes vertical\",\"description\":\"The US military appears interested in owning and operating its own fleet of Starships.\",\"url\":\"https://arstechnica.com/space/2024/02/rocket-report-spacex-at-the-service-of-a-rival-endeavourgoes-vertical/\",\"urlToImage\":\"https://cdn.arstechnica.net/wp-content/uploads/2024/02/GFNrsMPWIAAWxNw-760x380.jpeg\",\"publishedAt\":\"2024-02-02T12:00:25+00:00\",\"content\":\"Enlarge/ Space shuttle Endeavour, seen here in protective wrapping, was mounted on an external tank and inert solid rocket boosters at the California Science Center.\\r\\n18\\r\\nWelcome to Edition 6.29 of t… [+15373 chars]\"}]}"
    }
    
    static var successGetEmptyPage: String {
        "{\"status\":\"ok\",\"totalResults\":10,\"articles\":[]}"
    }
    
    static var failGetPage: String {
        "{\"status\":\"error\",\"code\":404,\"message\":\"Page Not Found\"}"
    }
}
