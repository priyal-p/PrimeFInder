//
//  WolframAlphaResponse.swift
//  StateManagement
//
//  Created by Priyal PORWAL on 13/11/22.
//

import Foundation

struct WolframAlphaResponse: Decodable {
    let queryresult: QueryResult?

    struct QueryResult: Decodable {
        let pods: [Pod]?

        struct Pod: Decodable {
            let primary: Bool?
            let subpods: [SubPod]?

            struct SubPod: Decodable {
                let plaintext: String?
            }
        }
    }
}

struct WolframAlphaClient {
    let wolframAlphaApiKey = ""
    func wolframAlpha(query: String,
                      callback: @escaping (WolframAlphaResponse?) -> Void) {
        if var components = URLComponents(string: "https://api.wolframalpha.com/v2/query") {
            components.queryItems = [URLQueryItem(name: "input", value: query),
            URLQueryItem(name: "format", value: "plaintext"),
            URLQueryItem(name: "output", value: "JSON"),
            URLQueryItem(name: "appid", value: wolframAlphaApiKey)]

            URLSession.shared.dataTask(with: components.url(relativeTo: nil)!) { data, response, error in
                print(formattedResponse(data: data, response: response as? HTTPURLResponse, error: error))
                callback(data.flatMap { response in
                    do {
                        return try JSONDecoder().decode(WolframAlphaResponse.self,
                                                        from: response)
                    } catch let DecodingError.dataCorrupted(context) {
                        print(context)
                    } catch let DecodingError.keyNotFound(key, context) {
                        print("Key '\(key)' not found:", context.debugDescription)
                    } catch let DecodingError.valueNotFound(value, context) {
                        print("Value '\(value)' not found", context.debugDescription)
                    } catch let DecodingError.typeMismatch(type, context) {
                        print("Type '\(type)' mismatch:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                    } catch {
                        print("error:", error)
                    }
                    return nil
                })
            }.resume()
        }
    }

    func formattedResponse(data: Data?,
                           response: HTTPURLResponse?,
                           error: Error?) -> String {
        let urlString = response?.url?.absoluteString
        let components = NSURLComponents(string: urlString ?? "")
        let path = "\(components?.path ?? "")"
        let query = "\(components?.query ?? "")"

        var responseLog: [String] = []
        if let urlString = urlString {
            responseLog.append("\(urlString)")
        }

        if let statusCode = response?.statusCode {
            if statusCode == 200 {
                responseLog.append("✅ HTTP \(statusCode) \(path)?\(query)")
            } else {
                responseLog.append("🚨 HTTP \(statusCode) \(path)?\(query)")
            }
        }

        if let host = components?.host {
            responseLog.append("Host: \(host)")
        }

        for (key, value) in response?.allHeaderFields ?? [:] {
            responseLog.append("\(key): \(value)")
        }
        if let body = data,
            let bodyString = NSString(data: body,
                                      encoding: String.Encoding.utf8.rawValue) {
            responseLog.append("\(bodyString)")
        }

        if let error = error {
            responseLog.append("💀 Error: \(error.localizedDescription)")
        }

        return responseLog.joined(separator: "\n")
    }
}
