//
//  RootViewController.swift
//  TooSenior
//
//  Created by Vladyslav Krut on 3/5/25.
//

import UIKit

final class RootViewController: UIViewController {
    private let centerLabel: UILabel = {
        let label = UILabel()
        label.text = "TooSenior"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubview(centerLabel)

        NSLayoutConstraint.activate([
            centerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
