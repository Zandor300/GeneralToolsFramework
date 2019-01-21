//
//  BaseAPI.swift
//  GeneralToolsFramework
//
//  Created by Zandor Smith on 10/12/2018.
//

import Foundation

open class BaseAPI {
    
    private var baseUrl: String
    
    public init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    public func setBaseUrl(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    public func doGetApiCall(url: String, onCompletion: @escaping (Data) -> (), onError: @escaping () -> ()) {
        NetworkActivityHandler.pushNetworkActivity()
        
        print("Performing GET api call to url: " + url)
        
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
        
        print("Performing GET api call to url: " + url)
        
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
        
        print("Performing POST api call to url: " + url)
        
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
    
    public func doPostUploadApiCall(url: String, upload: Upload, postContent: [String: String], onCompletion: @escaping (Data) -> (), onError: @escaping () -> ()) {
        NetworkActivityHandler.pushNetworkActivity()
        
        print("Performing POST UPLOAD api call to url: " + url)
        
        let boundary = "Boundary-\(NSUUID().uuidString)"
        
        var body = Data()
        
        for (key, value) in postContent {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(value)\r\n".data(using: .utf8)!)
        }
        
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Disposition:form-data; name=\"file\"; filename=\"\(upload.name)\"\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Type: \(upload.type.rawValue)\r\n\r\n".data(using: String.Encoding.utf8)!)
        body.append(upload.data)
        body.append("\r\n".data(using: String.Encoding.utf8)!)
        
        body.append("--\(boundary)--\r\n".data(using: String.Encoding.utf8)!)
        
        var request = URLRequest(url: URL(string: baseUrl + url)!)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.httpBody = body
        
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
        
        print("Performing POST api call to url: " + url)
        
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
