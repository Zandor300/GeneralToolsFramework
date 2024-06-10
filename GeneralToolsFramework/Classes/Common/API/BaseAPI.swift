//
//  BaseAPI.swift
//  GeneralToolsFramework
//
//  Created by Zandor Smith on 10/12/2018.
//

import Foundation
#if canImport(ZSConnectivity)
import ZSConnectivity
#endif

open class BaseAPI {

    private var baseUrl: String
    private var apiName: String
    
    public var printResponses: Bool = false
    public var requireConnectivity: Bool = true {
        didSet {
            #if canImport(ZSConnectivity)
            if self.requireConnectivity {
                self.connectivity.startNotifier()
            } else {
                self.connectivity.stopNotifier()
            }
            #endif
        }
    }

    #if canImport(ZSConnectivity)
    private let connectivity = Connectivity()
    #endif

    public init(baseUrl: String, name: String) {
        self.baseUrl = baseUrl
        self.apiName = name

        #if canImport(ZSConnectivity)
        connectivity.framework = .network

        self.addConnectivityCheckURL(URL(string: "https://web3.zsnode.com/success.html")!)
        self.addConnectivityCheckURL(URL(string: "https://web4.zsnode.com/success.html")!)

        connectivity.startNotifier()
        printWithPrefix("Started connectivity notifier")
        #endif
    }

    open func setBaseUrl(_ baseUrl: String) {
        self.baseUrl = baseUrl
    }

    #if canImport(ZSConnectivity)
    open func addConnectivityCheckURL(_ url: URL) {
        connectivity.connectivityURLs.append(url)
        printWithPrefix(String(connectivity.connectivityURLs.count) + " connectivity urls currently added.")
    }
    #endif

    open func forceConnectivityCheck(_ onCompletion: @escaping () -> Void) {
        #if canImport(ZSConnectivity)
        connectivity.checkConnectivity { _ in
            onCompletion()
        }
        #else
        onCompletion()
        #endif
    }

    public func doGetApiCall(_ url: String, onCompletion: @escaping (Data) -> Void, onError: @escaping (APICallError) -> Void) {
        self.doGetApiCall(url, httpHeaderFields: [:], onCompletion: onCompletion, onError: onError)
    }

    public func doGetApiCall(_ url: String, httpHeaderFields: [String: String?], onCompletion: @escaping (Data) -> Void, onError: @escaping (APICallError) -> Void) {
        #if canImport(ZSConnectivity)
        if !connectivity.isConnected && self.requireConnectivity {
            onError(.noInternet)
            return
        }
        #endif

        #if os(iOS)
        NetworkActivityHandler.pushNetworkActivity()
        #endif

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
        #if canImport(ZSConnectivity)
        if !connectivity.isConnected && self.requireConnectivity {
            onError(.noInternet)
            return
        }
        #endif

        #if os(iOS)
        NetworkActivityHandler.pushNetworkActivity()
        #endif

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
        self.doPostUploadApiCall(url, upload: upload, postContent: postContent, httpHeaderFields: [:], onCompletion: onCompletion, onError: onError)
    }

    public func doPostUploadApiCall(_ url: String, upload: Upload, postContent: [String: String], httpHeaderFields: [String: String?], onCompletion: @escaping (Data) -> Void, onError: @escaping (APICallError) -> Void) {
        #if canImport(ZSConnectivity)
        if !connectivity.isConnected && self.requireConnectivity {
            onError(.noInternet)
            return
        }
        #endif

        #if os(iOS)
        NetworkActivityHandler.pushNetworkActivity()
        #endif

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

    private func handleDataTask(data: Data?, response: URLResponse?, error: Error?, onCompletion: @escaping (Data) -> Void, onError: @escaping (APICallError) -> Void) {
        if let error = error as NSError? {
            printWithPrefix("Network error.")
            printWithPrefix("error=\(String(describing: error))")
            #if os(iOS)
            NetworkActivityHandler.popNetworkActivity()
            #endif
            if error.domain == NSURLErrorDomain {
                switch error.code {
                case NSURLErrorNotConnectedToInternet:
                    onError(.noInternet)
                case NSURLErrorServerCertificateHasBadDate:
                    onError(.sslCertificateExpired)
                case NSURLErrorServerCertificateUntrusted, NSURLErrorServerCertificateNotYetValid, NSURLErrorServerCertificateHasUnknownRoot, NSURLErrorClientCertificateRejected, NSURLErrorClientCertificateRequired:
                    onError(.sslCertificateError)
                case NSURLErrorTimedOut:
                    onError(.serverTimeout)
                case NSURLErrorInternationalRoamingOff:
                    onError(.roamingDisabled)
                default:
                    onError(.networkError)
                }
            } else {
                onError(.networkError)
            }
            return
        }

        if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
            printWithPrefix("Invalid http status code.")
            printWithPrefix("statusCode should be 200, but is \(httpStatus.statusCode)")
            printWithPrefix("response = \(String(describing: response))")
            #if os(iOS)
            NetworkActivityHandler.popNetworkActivity()
            #endif
            onError(.serverUnavailable)
            return
        }

        guard let data = data else {
            #if os(iOS)
            NetworkActivityHandler.popNetworkActivity()
            #endif
            onError(.serverUnavailable)
            return
        }

        if printResponses, let contents = String(data: data, encoding: .utf8) {
            printWithPrefix(contents)
        }

        #if os(iOS)
        NetworkActivityHandler.popNetworkActivity()
        #endif
        onCompletion(data)
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
