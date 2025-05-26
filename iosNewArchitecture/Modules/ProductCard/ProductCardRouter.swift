//
//  ProductCardRouter.swift
//  Products
//
//  Created by lorenc_D_K on 11.03.2025.
//

import UIKit

final class ProductCardRouter: RouterProtocol {
    
    // MARK: - Services
    
    weak var parentViewController: UIViewController?
    var screenName: String?
    
    // MARK: - Public methods
    
    func dismiss() {
        if let presentingViewController = parentViewController?.presentingViewController {
            presentingViewController.dismiss(animated: true)
            return
        } else if let navigationViewController = parentViewController?.navigationController {
            navigationViewController.popViewController(animated: true)
        }
    }
}

