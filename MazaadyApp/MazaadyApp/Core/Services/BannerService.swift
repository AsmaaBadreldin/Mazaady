//
//  BannerService.swift
//  MazaadyApp
//
//  Created by asmaa badreldin on 13/04/2025.
//

import Foundation

final class BannerService {
    static let shared = BannerService()
    private init() {}

    func fetchAdvertisements(completion: @escaping (Result<[Advertisement], Error>) -> Void) {
        let url = APIEnvironment.baseURL.appendingPathComponent("advertisements")

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
                let response = try JSONDecoder().decode(AdvertisementsResponse.self, from: data)
                completion(.success(response.advertisements))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

private struct AdvertisementsResponse: Decodable {
    let advertisements: [Advertisement]
}
