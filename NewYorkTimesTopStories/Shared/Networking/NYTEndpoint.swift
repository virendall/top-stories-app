//
//  NYTEndpoint.swift
//  NewYorkTimesTopStories
//
//  Created by Mahika on 15/06/2022.
//

import Foundation

enum NYTEndpoint {
    case getTopStories(GetTopStories)
}

extension NYTEndpoint {
    private var baseURL: String { "https://api.nytimes.com" }
    private var apiKey: String { "0La0hbqYYk03yAjIRMzjDkyvkDUOMp20" }
    private var path: String {
        switch self {
        case .getTopStories(let getTopStories):
            return "/svc/topstories/v2/\(getTopStories.section).json"
        }
    }
    
    private var parameters: [String: Any] {
        switch self {
        case .getTopStories(_):
            return ["api-key": apiKey]
        }
    }
    
    private var requestURL: URL {
        var components = URLComponents(string: baseURL + path)
        components?.queryItems = parameters.map { (key, value) in
            URLQueryItem(name: key, value: "\(value)")
        }
        return components?.url ?? URL(string: baseURL + path)!
    }
    
    var httpRequest: URLRequest {
        var urlRequest = URLRequest(url: requestURL)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        return urlRequest
    }
}
