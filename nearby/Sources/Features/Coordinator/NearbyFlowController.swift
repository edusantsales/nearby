import Foundation
import UIKit

class NearbyFlowController {
    private var navigationController: UINavigationController?

    func start() -> UINavigationController? {
        let startViewController = SplashViewController()
        startViewController.flowDelegate = self
        self.navigationController = UINavigationController(
            rootViewController: startViewController
        )
        return navigationController
    }
}

extension NearbyFlowController: SplashFlowDelegate {
    func goToWelcome() {
        let welcomeViewController = WelcomeViewController()
        welcomeViewController.flowDelegate = self
        navigationController?.pushViewController(
            welcomeViewController,
            animated: true
        )
    }
}

extension NearbyFlowController: WelcomeFlowDelegate {
    func goToHome() {
        let homeViewController = HomeViewController()
        navigationController?.pushViewController(
            homeViewController,
            animated: true
        )
    }
}
