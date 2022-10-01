//
//  RequestManager.swift
//  levelShoesTest
//
//  Created by Macbook Pro on 01/10/2022.
//

import Foundation
import Combine
import MobileCoreServices
import SwiftUI
enum HTTPMethod {
    case post
    case get
}

class RequestManager {
    public init() {}
    func getUrl(from: String) -> URL? {
        guard let url = URL(string: from) else {
            return nil
        }
        return url
    }
    func buildRequest(url: String, method: HTTPMethod, bodyRequest: [String: Any], headers: [String: String], withToken: Bool = false) -> AnyPublisher<URLRequest, Error> {
        
        return self.request(url: url, method: method, bodyRequest: bodyRequest, headers: headers)
                .eraseToAnyPublisher()
        

    }
    func request(url: String, method: HTTPMethod, bodyRequest: [String: Any], headers: [String: String], token: String = "") -> AnyPublisher<URLRequest, Error> {
        var headersArr = headers
        if token != "" {
            headersArr["Authorization"] = "Bearer \(token)"
        }
        switch method {
        case .post:
            return Future<URLRequest, Error> { promise in

                guard let url = URL(string: url) else {
                    return promise(.failure(APIFailureCondition.invalidUrl))
                }
                var request = URLRequest(url: url)
                for (key, value) in headersArr {
                    request.setValue(value, forHTTPHeaderField: key)
                }
                do {
                    let bodyData = try JSONSerialization.data(
                        withJSONObject: bodyRequest,
                        options: []
                    )
                    request.httpMethod = "POST"
                    request.httpBody = bodyData

                    return promise(.success(request))
                } catch {
                    return promise(.failure(APIFailureCondition.invalidBodyParams))
                }
            }
            .eraseToAnyPublisher()

        case .get:
            return Future<URLRequest, Error> { promise in
                var urlWithParams = url + "?"
                for (key, val) in bodyRequest {
                    urlWithParams += String(describing: "\(key)=\(val)&")
                }
                urlWithParams = urlWithParams.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed) ?? urlWithParams
                guard let url = URL(string: urlWithParams) else {
                    return promise(.failure(APIFailureCondition.invalidUrl))
                }
                var request = URLRequest(url: url)
                for (key, value) in headersArr {
                    request.setValue(value, forHTTPHeaderField: key)
                }
                return promise(.success(request))
            }
            .eraseToAnyPublisher()
        }

    }
    

   

}

extension Data {
    mutating func append(_ string: String, using encoding: String.Encoding = .utf8) {
        if let data = string.data(using: encoding) {
            append(data)
        }
    }
}
