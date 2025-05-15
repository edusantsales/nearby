import Foundation
import UIKit

class WelcomeHeaderView: UIView {
    // Components
    private let logoImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "logo-icon")
        image.tintColor = Colors.greenLight
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private let welcomeTitleLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.titleXL
        label.numberOfLines = 0
        label.textColor = Colors.gray600
        label.text = "Boas vindas ao Nearby!"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let welcomeSubtitleLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.textMD
        label.numberOfLines = 0
        label.textColor = Colors.gray500
        label.text =
            "Tenha cupons de vantagem para usar em seus estabelecimentos favoritos."
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubview(logoImageView)
        addSubview(welcomeTitleLabel)
        addSubview(welcomeSubtitleLabel)
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: topAnchor),
            logoImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 48),
            logoImageView.widthAnchor.constraint(equalToConstant: 48),
        ])
        NSLayoutConstraint.activate([
            welcomeTitleLabel.topAnchor.constraint(
                equalTo: logoImageView.bottomAnchor,
                constant: 28
            ),
            welcomeTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            welcomeTitleLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor
            ),
        ])
        NSLayoutConstraint.activate([
            welcomeSubtitleLabel.topAnchor.constraint(
                equalTo: welcomeTitleLabel.bottomAnchor,
                constant: 12
            ),
            welcomeSubtitleLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor
            ),
            welcomeSubtitleLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor
            ),
            welcomeSubtitleLabel.bottomAnchor.constraint(
                equalTo: bottomAnchor
            ),
        ])
    }
}
