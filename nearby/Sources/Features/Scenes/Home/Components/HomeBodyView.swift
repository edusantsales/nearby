import Foundation
import UIKit

class HomeBodyView: UIView {
    // Components
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.gray100
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let dragIndicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.gray300
        view.layer.cornerRadius = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let explorePlacesLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.textMD
        label.textColor = Colors.gray600
        label.text = "Explore locais perto de você"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let placesTableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.register(
            PlaceTableViewCell.self,
            forCellReuseIdentifier: PlaceTableViewCell.identifier
        )
        table.separatorColor = .clear
        table.showsVerticalScrollIndicator = false
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubview(containerView)
        containerView.addSubview(dragIndicatorView)
        containerView.addSubview(explorePlacesLabel)
        containerView.addSubview(placesTableView)
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        NSLayoutConstraint.activate([
            dragIndicatorView.topAnchor.constraint(
                equalTo: containerView.topAnchor,
                constant: 12
            ),
            dragIndicatorView.centerXAnchor.constraint(
                equalTo: containerView.centerXAnchor
            ),
            dragIndicatorView.heightAnchor.constraint(equalToConstant: 4),
            dragIndicatorView.widthAnchor.constraint(equalToConstant: 80),
        ])
        NSLayoutConstraint.activate([
            explorePlacesLabel.topAnchor.constraint(
                equalTo: dragIndicatorView.bottomAnchor,
                constant: 24
            ),
            explorePlacesLabel.leadingAnchor.constraint(
                equalTo: containerView.leadingAnchor,
                constant: 24
            ),
            explorePlacesLabel.trailingAnchor.constraint(
                equalTo: containerView.trailingAnchor,
                constant: -24
            ),
        ])
        NSLayoutConstraint.activate([
            placesTableView.topAnchor.constraint(
                equalTo: explorePlacesLabel.bottomAnchor,
                constant: 16
            ),
            placesTableView.leadingAnchor.constraint(
                equalTo: containerView.leadingAnchor,
                constant: 24
            ),
            placesTableView.trailingAnchor.constraint(
                equalTo: containerView.trailingAnchor,
                constant: -24
            ),
            placesTableView.bottomAnchor.constraint(
                equalTo: containerView.bottomAnchor,
                constant: -16
            ),
        ])
    }

    func configureTableViewDelegate(
        _ delegate: UITableViewDelegate,
        dataSource: UITableViewDataSource
    ) {
        placesTableView.delegate = delegate
        placesTableView.dataSource = dataSource
    }

    func reloadTableViewData() {
        DispatchQueue.main.async {
            self.placesTableView.reloadData()
        }
    }

    func setupPanGesture(target: Any, action: Selector) {
        let panGesture = UIPanGestureRecognizer(
            target: target,
            action: action
        )
        containerView.addGestureRecognizer(panGesture)
    }
}
