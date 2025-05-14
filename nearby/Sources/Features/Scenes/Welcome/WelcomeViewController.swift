import Foundation
import UIKit

class WelcomeViewController: UIViewController {
    private let contentView = WelcomeView()

    weak var flowDelegate: WelcomeFlowDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = contentView
        self.view.backgroundColor = Colors.gray100
        contentView.goToHome = {
            [weak self] in
            self?.flowDelegate?.goToHome()
        }
    }
}
