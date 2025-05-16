import Foundation
import UIKit

class HomeHeaderView: UIView {
    private var categories: [Category] = []
    private var filterButtonAction: ((Category) -> Void)?
    private var filterButtonSelected: UIButton?

    @objc
    private func filterButtonTapped(_ sender: UIButton) {
        let selectedCategory = categories[sender.tag]
        updateFilterButtonSelection(button: sender)
        filterButtonAction?(selectedCategory)
    }

    // Components
    private let categoryFilterScrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.isUserInteractionEnabled = true
        scroll.showsHorizontalScrollIndicator = false
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()

    private let categoryFilterStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.isUserInteractionEnabled = true
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubview(categoryFilterScrollView)
        categoryFilterScrollView.addSubview(categoryFilterStackView)
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            categoryFilterScrollView.topAnchor.constraint(
                equalTo: topAnchor
            ),
            categoryFilterScrollView.leadingAnchor.constraint(
                equalTo: leadingAnchor
            ),
            categoryFilterScrollView.trailingAnchor.constraint(
                equalTo: trailingAnchor
            ),
            categoryFilterScrollView.bottomAnchor.constraint(
                equalTo: bottomAnchor
            ),
            categoryFilterScrollView.heightAnchor.constraint(
                equalToConstant: 36
            ),
        ])
        NSLayoutConstraint.activate([
            categoryFilterStackView.topAnchor.constraint(
                equalTo: categoryFilterScrollView.topAnchor
            ),
            categoryFilterStackView.leadingAnchor.constraint(
                equalTo: categoryFilterScrollView.leadingAnchor,
                constant: 24
            ),
            categoryFilterStackView.trailingAnchor.constraint(
                equalTo: categoryFilterScrollView.trailingAnchor,
                constant: -24
            ),
            categoryFilterStackView.bottomAnchor.constraint(
                equalTo: categoryFilterScrollView.bottomAnchor
            ),
            categoryFilterStackView.heightAnchor.constraint(
                equalTo: categoryFilterScrollView.heightAnchor
            ),
        ])
    }

    func updateFilterButtons(
        with categories: [Category],
        action: @escaping (Category) -> Void
    ) {
        let categoryIcons: [String: String] = [
            "Alimentação": "food",
            "Cinema": "movie",
            "Compras": "shopping-bag",
            "Hospedagem": "bed",
            "Padaria": "food",
        ]

        self.categories = categories
        self.filterButtonAction = action

        for (index, category) in categories.enumerated() {
            let iconName = categoryIcons[category.name] ?? "map-pin"

            let button = createFilterButton(
                title: category.name,
                iconName: iconName
            )
            button.tag = index
            button.addTarget(
                self,
                action: #selector(filterButtonTapped(_:)),
                for: .touchUpInside
            )

            if button.tag == 0 {
                updateFilterButtonSelection(button: button)
            }

            categoryFilterStackView.addArrangedSubview(button)
        }
    }

    private func createFilterButton(title: String, iconName: String) -> UIButton
    {
        let button = UIButton(type: .system)
        // Colors
        button.backgroundColor = Colors.gray100
        button.setTitleColor(Colors.gray600, for: .normal)
        button.tintColor = Colors.gray600

        // Decorations
        button.contentEdgeInsets = UIEdgeInsets(
            top: 10,
            left: 4,
            bottom: 10,
            right: 12
        )
        button.heightAnchor.constraint(equalToConstant: 36).isActive = true
        button.layer.cornerRadius = 8

        // Image
        button.setImage(UIImage(named: iconName), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageView?.heightAnchor.constraint(equalToConstant: 13)
            .isActive = true
        button.imageView?.widthAnchor.constraint(equalToConstant: 13).isActive =
            true

        // Title
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = Typography.textSM

        // Default
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }

    private func updateFilterButtonSelection(button: UIButton) {
        if let previousButton = filterButtonSelected {
            previousButton.backgroundColor = Colors.gray100
            previousButton.setTitleColor(Colors.gray600, for: .normal)
            previousButton.tintColor = Colors.gray600
        }

        button.backgroundColor = Colors.greenBase
        button.setTitleColor(Colors.gray100, for: .normal)
        button.tintColor = Colors.gray100

        filterButtonSelected = button
    }
}
