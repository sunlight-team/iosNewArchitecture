//
//  ViewController.swift
//  SunlightNewArchitectureIOS
//
//  Created by lorenc_D_K on 14.05.2025.
//

import UIKit

class StartViewController: UIViewController {
    
    private let startButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureUI()
    }
    
    private func configureUI() {
        view.addSubview(startButton)
        startButton.setTitle("Open productCard", for: .normal)
        startButton.setTitleColor(.label, for: .normal)
        startButton.backgroundColor = .green
        startButton.addTarget(nil, action: #selector(openProductCard), for: .touchUpInside)
        startButton.layer.cornerRadius = 15
        setupConstraints()
    }
    
    private func setupConstraints() {
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        startButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        startButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    @objc private func openProductCard() {
        let input = ProductCardInput(article: "123456")
        let viewController = Builder<ProductCard>.build(input: input)
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }
    
}
