import Foundation
import UIKit

class WelcomeView: UIView {
    var goToHome: (() -> Void?)?

    @objc
    private func didTapButton() { goToHome?() }

    // Components
    private let headerView: WelcomeHeaderView = {
        let view = WelcomeHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let bodyView: WelcomeBodyView = {
        let view = WelcomeBodyView()
        view.startButton.addTarget(
            self,
            action: #selector(didTapButton),
            for: .touchUpInside
        )
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubview(headerView)
        addSubview(bodyView)
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor,
                constant: 24
            ),
            headerView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 24
            ),
            headerView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -24
            ),
        ])
        NSLayoutConstraint.activate([
            bodyView.topAnchor.constraint(
                equalTo: headerView.bottomAnchor,
                constant: 40
            ),
            bodyView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 24
            ),
            bodyView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -24
            ),
            bodyView.bottomAnchor.constraint(
                equalTo: safeAreaLayoutGuide.bottomAnchor,
                constant: -24
            ),
        ])
    }
}
