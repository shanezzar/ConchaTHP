//
//  Extension.swift
//  ConchaTHP
//
//  Created by Shanezzar Sharon on 30/03/2022.
//

import SwiftUI

extension Color {
    
    // MARK: - Properties
    
    static var titleColor = Color("title-color")
    
    static var appYellow = Color("app-yellow")
}

extension UIWindow {
    
    // MARK: - Methods
    
    static var keyWindow: UIWindow? {
        return Array(UIApplication.shared.connectedScenes)
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first(where: { $0.isKeyWindow })
    }
    
    static var keyWindows: [UIWindow]? {
        return UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .first(where: { $0 is UIWindowScene })
            .flatMap({ $0 as? UIWindowScene })?.windows
    }
}

extension View {
    
    // MARK: - Methods
    
    func haptic(_ style: UIImpactFeedbackGenerator.FeedbackStyle = .light) {
        let impactMed = UIImpactFeedbackGenerator(style: style)
        impactMed.impactOccurred()
    }
}

// MARK: - URLSession response handlers
extension URLSession {
    
    // MARK: - Methods
    
    fileprivate func codableTask<T: Codable>(with request: URLRequest, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? self.newJSONDecoder().decode(T.self, from: data), response, nil)
        }
    }
    
    func conchaTask(with url: URL, jsonData: Data?, completionHandler: @escaping (Concha?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        return self.codableTask(with: request, completionHandler: completionHandler)
    }
    
    // MARK: - Helper functions for creating encoders and decoders
    func newJSONDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
            decoder.dateDecodingStrategy = .iso8601
        }
        return decoder
    }

    func newJSONEncoder() -> JSONEncoder {
        let encoder = JSONEncoder()
        if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
            encoder.dateEncodingStrategy = .iso8601
        }
        return encoder
    }
}
