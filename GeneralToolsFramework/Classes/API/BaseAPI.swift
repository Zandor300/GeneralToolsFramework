//
//  BaseAPI.swift
//  GeneralToolsFramework
//
//  Created by Zandor Smith on 10/12/2018.
//

import Foundation
import Connectivity

open class BaseAPI {

    private var baseUrl: String
    private var apiName: String
    public var printResponses: Bool = false

    private let connectivity = Connectivity()

    public init(baseUrl: String, name: String) {
        self.baseUrl = baseUrl
        self.apiName = name

        connectivity.framework = .network

        self.addConnectivityCheckURL(URL(string: "https://web3.zsnode.com/success.html")!)
        self.addConnectivityCheckURL(URL(string: "https://web4.zsnode.com/success.html")!)

        connectivity.startNotifier()
        printWithPrefix("Started connectivity notifier")
    }

    open func setBaseUrl(_ baseUrl: String) {
        self.baseUrl = baseUrl
    }

    open func addConnectivityCheckURL(_ url: URL) {
        connectivity.connectivityURLs.append(url)
        printWithPrefix(String(connectivity.connectivityURLs.count) + " connectivity urls currently added.")
    }

    open func forceConnectivityCheck(_ onCompletion: @escaping () -> Void) {
        connectivity.checkConnectivity { _ in
            onCompletion()
        }
    }

    public func doGetApiCall(_ url: String, onCompletion: @escaping (Data) -> Void, onError: @escaping (APICallError) -> Void) {
        self.doGetApiCall(url, httpHeaderFields: [:], onCompletion: onCompletion, onError: onError)
    }

    public func doGetApiCall(_ url: String, httpHeaderFields: [String: String?], onCompletion: @escaping (Data) -> Void, onError: @escaping (APICallError) -> Void) {
        if !connectivity.isConnected {
            onError(.noInternet)
            return
        }

        NetworkActivityHandler.pushNetworkActivity()

        printWithPrefix("Performing GET api call to url: " + baseUrl + url)

        var request = URLRequest(url: URL(string: baseUrl + url)!)
        request.httpMethod = "GET"
        for (key, value) in httpHeaderFields {
            request.setValue(value, forHTTPHeaderField: key)
        }

        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            self.handleDataTask(data: data, response: response, error: error, onCompletion: { (data) in
                onCompletion(data)
            }, onError: { (error) in
                onError(error)
            })
        }).resume()
    }

    public func doPostApiCall(_ url: String, postContent: [String: String], onCompletion: @escaping (Data) -> Void, onError: @escaping (APICallError) -> Void) {
        self.doPostApiCall(url, postContent: postContent, httpHeaderFields: [:], onCompletion: onCompletion, onError: onError)
    }

    public func doPostApiCall(_ url: String, postContent: [String: String], httpHeaderFields: [String: String?], onCompletion: @escaping (Data) -> Void, onError: @escaping (APICallError) -> Void) {
        if !connectivity.isConnected {
            onError(.noInternet)
            return
        }

        NetworkActivityHandler.pushNetworkActivity()

        printWithPrefix("Performing POST api call to url: " + baseUrl + url)

        let postContentString = generatePostContentString(postContent: postContent)
        if postContentString == nil {
            onError(.postContentInvalid)
            return
        }

        var request = URLRequest(url: URL(string: baseUrl + url)!)
        request.httpMethod = "POST"
        request.httpBody = postContentString!.data(using: .utf8)
        for (key, value) in httpHeaderFields {
            request.setValue(value, forHTTPHeaderField: key)
        }

        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            self.handleDataTask(data: data, response: response, error: error, onCompletion: { (data) in
                onCompletion(data)
            }, onError: { (error) in
                onError(error)
            })
        }).resume()
    }

    public func doPostUploadApiCall(_ url: String, upload: Upload, postContent: [String: String], onCompletion: @escaping (Data) -> Void, onError: @escaping (APICallError) -> Void) {
        if !connectivity.isConnected {
            onError(.noInternet)
            return
        }

        NetworkActivityHandler.pushNetworkActivity()

        printWithPrefix("Performing POST UPLOAD api call to url: " + baseUrl + url)

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

        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            self.handleDataTask(data: data, response: response, error: error, onCompletion: { (data) in
                onCompletion(data)
            }, onError: { (error) in
                onError(error)
            })
        }).resume()
    }

    private func handleDataTask(data: Data?, response: URLResponse?, error: Error?, onCompletion: @escaping (Data) -> Void, onError: @escaping (APICallError) -> Void) {
        if data != nil && error != nil {
            printWithPrefix("Network error.")
            printWithPrefix("error=\(String(describing: error))")
            NetworkActivityHandler.popNetworkActivity()
            onError(.serverUnavailable)
            return
        }

        if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
            printWithPrefix("Invalid http status code.")
            printWithPrefix("statusCode should be 200, but is \(httpStatus.statusCode)")
            printWithPrefix("response = \(String(describing: response))")
            NetworkActivityHandler.popNetworkActivity()
            onError(.serverUnavailable)
            return
        }

        if data == nil {
            NetworkActivityHandler.popNetworkActivity()
            onError(.serverUnavailable)
            return
        }

        let contents = String(data: data!, encoding: .utf8)

        if contents == nil {
            NetworkActivityHandler.popNetworkActivity()
            onError(.serverUnavailable)
            return
        }

        if printResponses {
            printWithPrefix(contents!)
        }
        NetworkActivityHandler.popNetworkActivity()
        onCompletion(data!)
    }

    private func generatePostContentString(postContent: [String: String]) -> String? {
        var string: String?
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

    func printWithPrefix(_ string: String) {
        print("[" + self.apiName + "] " + string)
    }

}
