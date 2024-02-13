//
//  APIManager.swift
//  MovieDemo
//
//  Created by Sandeep on 12/02/24.
//

import Foundation
import Alamofire
import Combine

enum APIManagerType: Int {
    case get, post, delete, upload, download, put

    func method() -> HTTPMethod {
        switch self {
        case .get:
            return .get
        case .post:
            return .post
        case .delete:
            return .delete
        case .upload:
            return .post
        case .download:
            return .get
        case .put:
            return .put
        }
    }
}

struct APIManager {
    static let get = APIManager(type: .get)
    static let post = APIManager(type: .post)
    static let delete = APIManager(type: .delete)
    static let upload = APIManager(type: .upload)
    static let download = APIManager(type: .download)
    static let put = APIManager(type: .put)

    static var shared: [APIManager] = [get, post, delete, upload, download, put]

    var type: APIManagerType
    
    var method: HTTPMethod {
        return self.type.method()
    }

    var manager: Alamofire.Session

    init(type: APIManagerType) {
        self.type = type
        var timeout: Double = 180
        switch type {
        case .get:
            timeout = 180
        case .post:
            timeout = 30
        case .delete:
            timeout = 30
        case .upload:
            timeout = 180
        case .download:
            timeout = 180
        case .put:
            timeout = 30
        }

        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = timeout // seconds
        configuration.timeoutIntervalForResource = timeout
        manager = Alamofire.Session(configuration: configuration)
    }

    func request(url: String, parameters: [String: Any]? = nil, overrideEncoding: ParameterEncoding? = nil, overrideContentType: String? = nil, overrideHeaders: [String: String]? = nil, interceptor: RequestInterceptor? = nil) -> AnyPublisher<Data, Error> {
        guard let requestURL = URL(string: url) else {
            return Fail(error: AFError.invalidURL(url: url)).eraseToAnyPublisher()
        }

        var encoding: ParameterEncoding = method == .get ? URLEncoding.default : JSONEncoding.default
        encoding = overrideEncoding ?? encoding

        var headers = HTTPHeaders()
        headers["Accept"] = "*/*"
        headers["Content-Type"] = overrideContentType ?? "application/json"

        if let overrideHeaders = overrideHeaders {
            headers = HTTPHeaders(overrideHeaders)
        }

        return manager.request(requestURL, method: self.method, parameters: parameters, headers: headers, interceptor: interceptor)
            .validate(statusCode: 200..<300)
            .publishData(emptyResponseCodes: Set(200..<300))
            .tryMap { dataResponse in
                if let error = dataResponse.error {
                    throw error
                } else {
                    return dataResponse.data ?? Data()
                }
            }
            .eraseToAnyPublisher()
    }

}
