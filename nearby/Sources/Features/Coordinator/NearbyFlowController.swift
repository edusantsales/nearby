//
//  NearbyFlowController.swift
//  Nearby
//
//  Created by Eduardo Sant Ana Sales on 25/02/25.
//
//  Class responsible for coordinating navigation between app screens
//

import Foundation
import UIKit

class NearbyFlowController {
    private var navigationController: UINavigationController?
    
    public init() {}
    
    func start() -> UINavigationController? {
        let contentView = SplashView()
        let startViewController = SplashViewController(contentView: contentView)
        self.navigationController = UINavigationController(rootViewController: startViewController)
        return navigationController
    }
}
