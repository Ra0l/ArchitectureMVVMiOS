//
//  HomeView.swift
//  ArchitectureMVVM
//
//  Created by Raul Kevin Aliaga Shapiama on 3/22/24.
//

import Foundation
import UIKit

class HomeView: UIViewController {
    
    private let messageLabel: UILabel = {
       let label = UILabel()
        label.text = "Home"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
        
        view.addSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            messageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
