//
//  Environment.swift
//  MazaadyApp
//
//  Created by asmaa badreldin on 12/04/2025.
//

import Foundation

enum APIEnvironment {
    enum Environment {
        case staging
        case production
    }

    // 👇 This is the new computed variable
    static var current: Environment {
        #if DEBUG
        return .staging
        #else
        return .production
        #endif
    }

    static var baseURL: URL {
        switch current {
        case .staging:
            return URL(string: "https://stagingapi.mazaady.com/api/interview-tasks")!
        case .production:
            return URL(string: "https://api.mazaady.com/api/interview-tasks")! // Replace with real prod URL
        }
    }
}

