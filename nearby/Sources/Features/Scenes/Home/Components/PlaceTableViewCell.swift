import Foundation
import UIKit

class PlaceTableViewCell: UITableViewCell {
    static let identifier = "PlaceTableViewCell"

    // Components
    var placeImageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = Colors.gray200
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 8
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    let placeNameLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.titleSM
        label.numberOfLines = 0
        label.textColor = Colors.gray600
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let placeDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.textXS.withSize(10)
        label.numberOfLines = 0
        label.textColor = Colors.gray500
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let ticketImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "ticket")
        image.tintColor = Colors.redBase
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    let ticketLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.textXS.withSize(10)
        label.numberOfLines = 0
        label.textColor = Colors.gray400
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.gray100
        view.layer.borderColor = Colors.gray200.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // Set UITableViewCell Background Color
        self.backgroundColor = .clear
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubview(containerView)
        containerView.addSubview(placeImageView)
        containerView.addSubview(placeNameLabel)
        containerView.addSubview(placeDescriptionLabel)
        containerView.addSubview(ticketImageView)
        containerView.addSubview(ticketLabel)
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -6
            ),
        ])
        NSLayoutConstraint.activate([
            placeImageView.topAnchor.constraint(
                equalTo: containerView.topAnchor,
                constant: 8
            ),
            placeImageView.leadingAnchor.constraint(
                equalTo: containerView.leadingAnchor,
                constant: 8
            ),
            placeImageView.bottomAnchor.constraint(
                equalTo: containerView.bottomAnchor,
                constant: -8
            ),
            placeImageView.centerYAnchor.constraint(
                equalTo: containerView.centerYAnchor
            ),
            placeImageView.heightAnchor.constraint(equalToConstant: 104),
            placeImageView.widthAnchor.constraint(equalToConstant: 116),
        ])
        NSLayoutConstraint.activate([
            placeNameLabel.topAnchor.constraint(
                equalTo: containerView.topAnchor,
                constant: 10
            ),
            placeNameLabel.leadingAnchor.constraint(
                equalTo: placeImageView.trailingAnchor,
                constant: 16
            ),
            placeNameLabel.trailingAnchor.constraint(
                equalTo: containerView.trailingAnchor,
                constant: -8
            ),
        ])
        NSLayoutConstraint.activate([
            placeDescriptionLabel.topAnchor.constraint(
                equalTo: placeNameLabel.bottomAnchor,
                constant: 4
            ),
            placeDescriptionLabel.leadingAnchor.constraint(
                equalTo: placeImageView.trailingAnchor,
                constant: 16
            ),
            placeDescriptionLabel.trailingAnchor.constraint(
                equalTo: containerView.trailingAnchor,
                constant: -8
            ),
        ])
        NSLayoutConstraint.activate([
            ticketImageView.topAnchor.constraint(
                equalTo: placeDescriptionLabel.bottomAnchor,
                constant: 10
            ),
            ticketImageView.leadingAnchor.constraint(
                equalTo: placeImageView.trailingAnchor,
                constant: 16
            ),
            ticketImageView.heightAnchor.constraint(equalToConstant: 16),
            ticketImageView.widthAnchor.constraint(equalToConstant: 16),
        ])
        NSLayoutConstraint.activate([
            ticketLabel.topAnchor.constraint(
                equalTo: placeDescriptionLabel.bottomAnchor,
                constant: 8
            ),
            ticketLabel.leadingAnchor.constraint(
                equalTo: ticketImageView.trailingAnchor,
                constant: 4
            ),
            ticketLabel.centerYAnchor.constraint(
                equalTo: ticketImageView.centerYAnchor
            ),
        ])
    }

    func configure(with place: Place) {
        let networkService = NetworkService()
        networkService.getData(
            from: place.cover,
            transformTo: { UIImage(data: $0) }
        ) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.placeImageView.image = image
                }
            case .failure(let error):
                print(
                    "❌ Erro ao buscar as imagens dos estabelecimentos: \(error.localizedDescription)"
                )
                DispatchQueue.main.async {
                    self.placeImageView.image = UIImage(named: "logo-nearby")
                }
            }
        }
        placeNameLabel.text = place.name
        placeDescriptionLabel.text = place.description
        if place.coupons == 0 {
            ticketImageView.tintColor = Colors.gray400
        }
        ticketLabel.text = "\(place.coupons) cupons disponíveis"
    }
}
