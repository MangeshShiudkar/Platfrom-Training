import Foundation

protocol UserFetching {
    func fetchUsers() async throws -> [User]
}

struct LiveUserService: UserFetching {
    init() {
        
    }

    func fetchUsers() async throws -> [User] {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            throw NetworkError.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }
            guard (200..<300).contains(httpResponse.statusCode) else {
                throw NetworkError.http(status: httpResponse.statusCode, data: data)
            }
            do {
                return try JSONDecoder().decode([User].self, from: data)
            } catch let decodingError as DecodingError {
                throw NetworkError.decoding(decodingError)
            }
        } catch let urlError as URLError {
            throw NetworkError.transport(urlError)
        }
    }
}
