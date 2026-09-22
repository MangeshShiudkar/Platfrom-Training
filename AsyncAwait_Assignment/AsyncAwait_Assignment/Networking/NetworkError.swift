import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case http(status: Int, data: Data)
    case decoding(DecodingError)
    case transport(URLError)
}
