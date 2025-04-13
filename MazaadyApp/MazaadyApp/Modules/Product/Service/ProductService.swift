//
//  ProductService.swift
//  MazaadyApp
//
//  Created by asmaa badreldin on 12/04/2025.
//

import Foundation

final class ProductService {
    static let shared = ProductService()
    private init() {}

    func fetchProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        let url = APIEnvironment.baseURL.appendingPathComponent("products")

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
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
                let products = try decoder.decode([Product].self, from: data)
                completion(.success(products))
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }
}
