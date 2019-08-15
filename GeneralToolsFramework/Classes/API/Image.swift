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
    private var image: UIImage?

    public var downloaded: Bool {
        return image != nil
    }

    public init(url: String) {
        self.url = url
    }

    public func removeCachedImage() {
        self.image = nil
    }

    open func getImage(available: @escaping (UIImage) -> Void, onError: @escaping (APICallError) -> Void) {
        if self.downloading {
            self.getCallbacks.append(available)
            return
        }
        if self.downloaded, let image = self.image {
            DispatchQueue.main.async {
                available(image)
            }
        } else if let image = PINCache.shared().object(forKey: self.url) as? UIImage {
            DispatchQueue.main.async {
                available(image)
            }
        } else {
            self.downloadImage(onCompletion: {
                if let image = self.image {
                    PINCache.shared().setObject(image, forKey: self.url)
                    DispatchQueue.main.async {
                        available(image)
                        for callback in self.getCallbacks {
                            callback(image)
                        }
                    }
                    self.getCallbacks.removeAll()
                }
            }, onError: onError)
        }
    }

    private func downloadImage(onCompletion: @escaping () -> Void, onError: @escaping (APICallError) -> Void) {
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

            if let data = data {
                NetworkActivityHandler.popNetworkActivity()
                self.image = UIImage(data: data)
                self.downloading = false
                onCompletion()
            } else {
                NetworkActivityHandler.popNetworkActivity()
                self.downloading = false
                onError(.serverUnavailable)
            }
        }).resume()
    }

}
