import Foundation
import UIKit

class WelcomeBodyView: UIView {
    // Components
    private let seeHowItWorksLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.textMD
        label.numberOfLines = 0
        label.textColor = Colors.gray500
        label.text = "Veja como funciona:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let tipsStackView: UIStackView = {
        let tip1 = WelcomeTipsView(
            icon: UIImage(named: "map-pin") ?? UIImage(),
            title: "Encontre estabelecimentos",
            description: "Veja locais perto de você que são parceiros Nearby"
        )

        let tip2 = WelcomeTipsView(
            icon: UIImage(named: "qrcode") ?? UIImage(),
            title: "Ative o cupom com QR Code",
            description:
                "Escaneie o código no estabelecimento para usar o benefício"
        )

        let tip3 = WelcomeTipsView(
            icon: UIImage(named: "ticket") ?? UIImage(),
            title: "Garanta vantagens perto de você",
            description:
                "Ative os cupons onde estiver, em diferentes tipos de estabelecimento"
        )

        let stack = UIStackView(arrangedSubviews: [tip1, tip2, tip3])
        stack.axis = .vertical
        stack.spacing = 24
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    let startButton: UIButton = {
        let titleFont = AttributeContainer([.font: Typography.action])
        let title = "Começar"

        var config = UIButton.Configuration.filled()
        config.attributedTitle = AttributedString(
            title,
            attributes: titleFont
        )
        config.background.cornerRadius = 12
        config.baseBackgroundColor = Colors.greenBase
        config.baseForegroundColor = Colors.gray100

        let button = UIButton()
        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubview(seeHowItWorksLabel)
        addSubview(tipsStackView)
        addSubview(startButton)
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            seeHowItWorksLabel.topAnchor.constraint(equalTo: topAnchor),
            seeHowItWorksLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor
            ),
            seeHowItWorksLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor
            ),
        ])
        NSLayoutConstraint.activate([
            tipsStackView.topAnchor.constraint(
                equalTo: seeHowItWorksLabel.bottomAnchor,
                constant: 24
            ),
            tipsStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tipsStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        NSLayoutConstraint.activate([
            startButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            startButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            startButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            startButton.heightAnchor.constraint(equalToConstant: 56),
        ])
    }
}
