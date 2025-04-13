//
//  ProductGridPresenter.swift
//  MazaadyApp
//
//  Created by asmaa badreldin on 13/04/2025.
//

import Foundation

protocol ProductGridViewProtocol: AnyObject {
    func reloadData()
    func showError(_ message: String)
}

final class ProductGridPresenter {
    weak var view: ProductGridViewProtocol?
    private var products: [Product] = []

    init(view: ProductGridViewProtocol) {
        self.view = view
    }

    func viewDidLoad() {
        ProductService.shared.fetchProducts { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let products):
                    self?.products = products
                    self?.view?.reloadData()
                case .failure(let error):
                    self?.view?.showError(error.localizedDescription)
                }
            }
        }
    }

    func numberOfItems() -> Int {
        return products.count
    }

    func product(at index: Int) -> Product {
        return products[index]
    }
    
    var allProducts: [Product] {
        return products
    }
}
