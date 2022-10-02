//
//  ServiceManager.swift
//  levelShoesTest
//
//  Created by Macbook Pro on 01/10/2022.
//

import Foundation
import Combine
import SwiftUI

enum APIFailureCondition: Error, LocalizedError {
    case invalidServerResponse
    case invalidParsing
    case invalidUrl
    case invalidBodyParams
    case apiError(reason: String,code:Int)
    case notfound
    var errorDescription: String? {
        switch self {
        case .invalidServerResponse:
            return "Unknown error"
        case .apiError(let reason, _):
            return reason
        case .invalidUrl:
            return "the url is invalid"
        case .invalidBodyParams:
            return "cann't parse the body parameters"
        case .invalidParsing:
            return "cann't parse the model data"
        case .notfound:
            return "404"
        }
    }
}

struct Response<T> {
    let value: T
    let response: URLResponse
}
struct ErrorReposnse: Codable {
    let statusCode: Int?
    let message: String?
}

let APIManager = ServiceManager.shared

class ServiceManager {
    var baseUrl: String
    static let shared = ServiceManager()
    internal let requestManager = RequestManager()
    init(baseUrl: String = ApiConstants.baseUrl) {
        self.baseUrl = baseUrl + "/%@"
    }
    func post<T: Decodable>(_ path: String,
                            params: [String: Any],
                            authorization: Bool = true) -> AnyPublisher<Response<T>, Error> {
        let headers = self.generateHeaders()
        let url = String(format: baseUrl, path)
        let request = requestManager.buildRequest(url: url, method: .post,
                                                  bodyRequest: params,
                                                  headers: headers,
                                                  withToken: authorization)
        return request.flatMap { URLRequest in
            self.callApi(urlRequest: URLRequest)
        }
        .eraseToAnyPublisher()
    }
    func get<T: Decodable>(_ path: String,
                           params: [String: Any],
                           authorization: Bool = true) -> AnyPublisher<Response<T>, Error> {
        let headers = self.generateHeaders()
        let url = String(format: baseUrl, path)
        let request = requestManager.buildRequest(url: url,
                                                  method: .get,
                                                  bodyRequest: params,
                                                  headers: headers,
                                                  withToken: authorization)
        return request.flatMap { URLRequest in
            self.callApi(urlRequest: URLRequest)
        }
        .eraseToAnyPublisher()
    }
    
    private func callApi<T: Decodable>(urlRequest: URLRequest) -> AnyPublisher<Response<T>, Error> {
        let publisher = URLSession.shared.dataTaskPublisher(for: urlRequest)
        return
            publisher.tryMap { result -> Response<T> in
                ApiLogger().log(request: urlRequest)
                print("status code for api response : \((result.response as? HTTPURLResponse)?.statusCode ?? 200)")
                guard let httpResponse = result.response as? HTTPURLResponse,
                      200..<300 ~=  httpResponse.statusCode else {
                    print("status code for api response : \((result.response as? HTTPURLResponse)?.statusCode ?? 200)")
                    let data = result.data
                    let response = result.response as? HTTPURLResponse
                    let error = APIFailureCondition.invalidServerResponse
                    ApiLogger().log(data: data, response: response, error: error)
                    if let code = result.response as? HTTPURLResponse,code.statusCode == 404 {
                        throw APIFailureCondition.notfound
                    }
                    else {
                        let decoder = JSONDecoder()
                        let value = try decoder.decode(ErrorReposnse.self, from: data)
                        if let msg = value.message, let code = value.statusCode {
                            throw APIFailureCondition.apiError(reason: msg,code: code)
                        }
                        else {
                            throw APIFailureCondition.invalidServerResponse
                        }
                    }

                }
                ApiLogger().log(data: result.data, response: result.response as? HTTPURLResponse, error: nil)
                let decoder = JSONDecoder()
                let value = try decoder.decode(T.self, from: result.data)
                return Response(value: value, response: result.response)
            }
            .mapError({ error in
                ApiLogger().log(data: nil, response: nil, error: error)
                if let error = error as? APIFailureCondition {
                    return error
                } else {
                    return APIFailureCondition.apiError(reason: error.localizedDescription,code: 500)
                }
            })
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    private func generateHeaders() -> [String: String] {
        var headers = [String: String]()
        headers["Content-Type"] = "application/json"
        return headers
    }
}
