//
//  Image.swift
//  GeneralToolsFramework
//
//  Created by Zandor Smith on 06/05/2019.
//

import Foundation
import PINCache

open class Image {

    public static var customizeRequest: ((Image, inout URLRequest) -> Void)?

    public let url: String

    private var downloading: Bool = false
    private var getCallbacks: [(UIImage) -> Void] = []

    public var downloaded: Bool {
        return PINCache.shared().containsObject(forKey: self.url)
    }

    public init(url: String) {
        self.url = url
    }

    public func removeCachedImage() {
        PINCache.shared().removeObject(forKey: self.url)
    }

    private func getImageFromCache() -> UIImage? {
        if let data = PINCache.shared().object(forKey: self.url) as? NSData {
            return UIImage(data: data as Data)
        }
        return nil
    }

    open func getImage(available: @escaping (UIImage) -> Void, onError: @escaping (APICallError) -> Void) {
        if let image = self.getImageFromCache() {
            DispatchQueue.main.async {
                available(image)
            }
            return
        }

        self.getCallbacks.append(available)
        if self.downloading {
            return
        }

        self.downloadImage(onCompletion: { data in
            if let image = UIImage(data: data as Data) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                    for callback in self.getCallbacks {
                        callback(image)
                    }
                    self.getCallbacks.removeAll()
                }
            }
        }, onError: onError)
    }

    private func downloadImage(onCompletion: @escaping (NSData) -> Void, onError: @escaping (APICallError) -> Void) {
        print("[Image] Downloading image from \(self.url)")

        self.downloading = true

        let url = URL(string: self.url)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        if let customizeRequest = Image.customizeRequest {
            customizeRequest(self, &request)
        }

        NetworkActivityHandler.pushNetworkActivity()
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if data != nil && error != nil {
                print("[Image] Network error.")
                print("[Image] error=\(String(describing: error))")
                NetworkActivityHandler.popNetworkActivity()
                self.downloading = false
                onError(.serverUnavailable)
                return
            }

            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("[Image] Invalid http status code.")
                print("[Image] statusCode should be 200, but is \(httpStatus.statusCode)")
                print("[Image] response = \(String(describing: response))")
                NetworkActivityHandler.popNetworkActivity()
                self.downloading = false
                onError(.serverUnavailable)
                return
            }

            if let data = data as NSData? {
                NetworkActivityHandler.popNetworkActivity()
                PINCache.shared().setObject(data, forKey: self.url)
                self.downloading = false
                onCompletion(data)
            } else {
                NetworkActivityHandler.popNetworkActivity()
                self.downloading = false
                onError(.serverUnavailable)
            }
        }).resume()
    }

}
