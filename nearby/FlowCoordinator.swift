//
//  FlowCoordinator.swift
//  nearby
//
//  Created by Eduardo Sant Ana Sales on 25/02/25.
//

import Foundation
import UIKit

class FlowCoordinator {
    private var navigationController: UINavigationController?
    
    public init() {
        
    }
    
    func start() -> UINavigationController? {
        let startViewController = UIViewController()
        startViewController.view.backgroundColor = .red
        self.navigationController = UINavigationController(rootViewController: startViewController)
        return navigationController
    }
}
