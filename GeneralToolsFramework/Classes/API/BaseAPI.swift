//
//  BaseAPI.swift
//  GeneralToolsFramework
//
//  Created by Zandor Smith on 10/12/2018.
//

import Foundation

open class BaseAPI {
    
    private let baseUrl: String
    
    public init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    public func doGetApiCall(url: String, onCompletion: @escaping (Data) -> (), onError: @escaping () -> ()) {
        NetworkActivityHandler.pushNetworkActivity()
        
        URLSession.shared.dataTask(with: URL(string: baseUrl + url)!, completionHandler: {
            (data, response, error) in
            self.handleDataTask(data: data, response: response, error: error, onCompletion: { (data) in
                onCompletion(data)
            }, onError: {
                onError()
            })
        }).resume()
    }
    
    public func doGetApiCall(url: String, httpHeaderFields: [String: String?], onCompletion: @escaping (Data) -> (), onError: @escaping () -> ()) {
        NetworkActivityHandler.pushNetworkActivity()
        
        var request = URLRequest(url: URL(string: baseUrl + url)!)
        request.httpMethod = "GET"
        for (key, value) in httpHeaderFields {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        URLSession.shared.dataTask(with: request, completionHandler: {
            (data, response, error) in
            self.handleDataTask(data: data, response: response, error: error, onCompletion: { (data) in
                onCompletion(data)
            }, onError: {
                onError()
            })
        }).resume()
    }
    
    public func doPostApiCall(url: String, postContent: [String: String], onCompletion: @escaping (Data) -> (), onError: @escaping () -> ()) {
        NetworkActivityHandler.pushNetworkActivity()
        
        let postContentString = generatePostContentString(postContent: postContent)
        if postContentString == nil {
            onError()
            return
        }
        
        var request = URLRequest(url: URL(string: baseUrl + url)!)
        request.httpMethod = "POST"
        request.httpBody = postContentString!.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request, completionHandler: {
            (data, response, error) in
            self.handleDataTask(data: data, response: response, error: error, onCompletion: { (data) in
                onCompletion(data)
            }, onError: {
                onError()
            })
        }).resume()
    }
    
    public func doPostApiCall(url: String, postContent: [String: String], httpHeaderFields: [String: String?], onCompletion: @escaping (Data) -> (), onError: @escaping () -> ()) {
        NetworkActivityHandler.pushNetworkActivity()
        
        let postContentString = generatePostContentString(postContent: postContent)
        if postContentString == nil {
            onError()
            return
        }
        
        var request = URLRequest(url: URL(string: baseUrl + url)!)
        request.httpMethod = "POST"
        request.httpBody = postContentString!.data(using: .utf8)
        for (key, value) in httpHeaderFields {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        URLSession.shared.dataTask(with: request, completionHandler: {
            (data, response, error) in
            self.handleDataTask(data: data, response: response, error: error, onCompletion: { (data) in
                onCompletion(data)
            }, onError: {
                onError()
            })
        }).resume()
    }
    
    private func handleDataTask(data: Data?, response: URLResponse?, error: Error?, onCompletion: @escaping (Data) -> (), onError: @escaping () -> ()) {
        if let _ = data, error != nil {
            print("Network error.")
            print("error=\(String(describing: error))")
            NetworkActivityHandler.popNetworkActivity()
            onError()
            return
        }
        
        if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
            print("Invalid http status code.")
            print("statusCode should be 200, but is \(httpStatus.statusCode)")
            print("response = \(String(describing: response))")
            NetworkActivityHandler.popNetworkActivity()
            onError()
            return
        }
        
        if data == nil {
            NetworkActivityHandler.popNetworkActivity()
            onError()
            return
        }
        
        let contents = String(data: data!, encoding: .utf8)
        
        if contents == nil {
            NetworkActivityHandler.popNetworkActivity()
            onError()
            return
        }
        
        print(contents!)
        NetworkActivityHandler.popNetworkActivity()
        onCompletion(data!)
    }
    
    private func generatePostContentString(postContent: [String: String]) -> String? {
        var string: String? = nil
        for key in postContent.keys {
            let value = postContent[key]!
            let keyValuePair = key + "=" + value
            if string == nil {
                string = keyValuePair
            } else {
                string = string! + "&" + keyValuePair
            }
        }
        return string
    }
    
}
