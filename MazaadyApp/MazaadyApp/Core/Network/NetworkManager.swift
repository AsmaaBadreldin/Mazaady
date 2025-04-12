//
//  NetworkManager.swift
//  MazaadyApp
//
//  Created by asmaa badreldin on 12/04/2025.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}

    func fetchProfileData(completion: @escaping (Result<ProfileModel, Error>) -> Void) {
        // Use baseURL from your centralized environment
        let url = APIEnvironment.baseURL.appendingPathComponent("user")

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 404)))
                return
            }

            do {
                let decoder = JSONDecoder()
                let profile = try decoder.decode(ProfileModel.self, from: data)
                completion(.success(profile))
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }
}
