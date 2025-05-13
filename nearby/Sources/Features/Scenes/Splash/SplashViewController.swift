import Foundation
import UIKit

class SplashViewController: UIViewController {
    private let contentView = SplashView()

    weak var flowDelegate: SplashFlowDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewInit()
        goToWelcome()
    }

    private func viewInit() {
        self.navigationController?.navigationBar.isHidden = true
        self.view = contentView
        self.view.backgroundColor = Colors.greenLight
    }

    private func goToWelcome() {
        // Wait 3 seconds and go to  welcome screen
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            [weak self] in self?.flowDelegate?.goToWelcome()
        }
    }
}
