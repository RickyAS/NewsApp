//
//  SourceResponseMock.swift
//  NewsAppTests
//
//  Created by amartek on 03/02/24.
//

import Foundation

struct SourceResponseMock {
    static var successGetPage: String {
        "{\"status\":\"ok\",\"sources\":[{\"id\":\"ars-technica\",\"name\":\"Ars Technica\",\"description\":\"The PC enthusiast's resource. Power users and the tools they love, without computing religion.\",\"url\":\"https://arstechnica.com\",\"category\":\"technology\",\"language\":\"en\",\"country\":\"us\"}]}"
    }
    
    static var successGetEmptyPage: String {
        "{\"status\":\"ok\",\"sources\":[]}"
    }
    
    static var failGetPage: String {
        "{\"status\":\"error\",\"code\":404,\"message\":\"Page Not Found\"}"
    }
}
