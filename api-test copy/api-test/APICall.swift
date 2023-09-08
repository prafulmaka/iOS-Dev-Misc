//
//  APICall.swift
//  api-test
//
//  Created by Praful Maka on 8/18/23.
//

import Foundation

func fetchFromAPI() {
    
    
    var url = URLRequest(url: URL(string: "https://adb-1074186372755222.2.azuredatabricks.net/api/2.1/jobs/run-now")!)
    
    url.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    url.setValue("application/json", forHTTPHeaderField: "Accept")
    url.httpMethod = "POST"
    
    url.allHTTPHeaderFields = ["Authorization": "Bearer "]
    
    let json: [String: Any] = ["job_id": 1112480374427870, "notebook_params": ["userid": "mY8u0bJwZleDt24qfkf2sqq83ex1"]]
    
    let jsonData = try? JSONSerialization.data(withJSONObject: json)
    
    url.httpBody = jsonData
    
    let task = URLSession.shared.dataTask(with: url) {
        data, response, error in
        
        if let data = data, let string = String(data: data, encoding: .utf8),
           let response = response {
            print(string)
            print(response)
        }
    }
    
    
    task.resume()
}
//    let decoded = JSONDecoder().decode(Response.self, from: data)
//
//    return decoded.IP
