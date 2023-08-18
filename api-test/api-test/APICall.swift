//
//  APICall.swift
//  api-test
//
//  Created by Praful Maka on 8/18/23.
//

import Foundation

func fetchFromAPI() async throws -> String {
    let url = URL(string: "https://maka-projects.com/api/ip/")!
    
    let (data, _) = try await URLSession.shared.data(from: url)
    
    let decoded = try JSONDecoder().decode(Response.self, from: data)
    
    return decoded.IP
}
