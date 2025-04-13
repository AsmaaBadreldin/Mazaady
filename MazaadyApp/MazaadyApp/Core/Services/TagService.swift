//
//  TagService.swift
//  MazaadyApp
//
//  Created by asmaa badreldin on 13/04/2025.
//

import Foundation

final class TagService {
    static let shared = TagService()
    private init() {}

    func fetchTags(completion: @escaping (Result<[Tag], Error>) -> Void) {
        let url = APIEnvironment.baseURL.appendingPathComponent("tags")

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 404)))
                return
            }

            do {
                let response = try JSONDecoder().decode(TagsResponse.self, from: data)
                completion(.success(response.tags))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

private struct TagsResponse: Decodable {
    let tags: [Tag]
}
