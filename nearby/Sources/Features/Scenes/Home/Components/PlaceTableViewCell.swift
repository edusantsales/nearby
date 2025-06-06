import Foundation
import UIKit

class PlaceTableViewCell: UITableViewCell {
    static let identifier = "PlaceTableViewCell"

    var itemImageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = Colors.gray200
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 8
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.titleSM
        label.textColor = Colors.gray600
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.textXS.withSize(10)
        label.textColor = Colors.gray500
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let ticketIconView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "ticketIcon")
        image.tintColor = Colors.redBase
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    let ticketLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.textXS.withSize(10)
        label.textColor = Colors.gray400
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.gray100
        view.layer.borderWidth = 1
        view.layer.borderColor = Colors.gray200.cgColor
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // Set UITableViewCell Background Color
        self.backgroundColor = .clear
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        addSubview(containerView)
        containerView.addSubview(itemImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(ticketIconView)
        containerView.addSubview(ticketLabel)
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6),
            
            itemImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            itemImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            itemImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
            itemImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            itemImageView.heightAnchor.constraint(equalToConstant: 104),
            itemImageView.widthAnchor.constraint(equalToConstant: 116),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            
            ticketIconView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            ticketIconView.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 16),
            ticketIconView.heightAnchor.constraint(equalToConstant: 16),
            ticketIconView.widthAnchor.constraint(equalToConstant: 16),
            
            ticketLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            ticketLabel.centerYAnchor.constraint(equalTo: ticketIconView.centerYAnchor),
            ticketLabel.leadingAnchor.constraint(equalTo: ticketIconView.trailingAnchor, constant: 4),
        ])
    }

    func configure(with place: Place) {
        if let url = URL(string: place.cover) {
            URLSession.shared.dataTask(with: url) {
                data, _, _ in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.itemImageView.image = image
                    }
                } else {
                    DispatchQueue.main.async {
                        self.itemImageView.image = UIImage(named: "logoImage")
                    }
                }
            }.resume()
        }
        titleLabel.text = place.name
        descriptionLabel.text = place.description
        if place.coupons == 0 {
            ticketIconView.tintColor = Colors.gray400
        }
        ticketLabel.text = "\(place.coupons) cupons disponíveis"
    }
}
