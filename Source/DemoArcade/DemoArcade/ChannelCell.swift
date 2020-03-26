//
//  ChannelCell.swift
//  DemoArcade
//
//  Created by Jonathan Rasmusson Work Pro on 2020-03-24.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var channel: Channel? {
        didSet {
            guard let channel = channel else { return }
            channelImageView.image = UIImage(named: channel.imageName)
            nameLabel.text = channel.name
            priceLabel.text = channel.price
        }
    }

    let channelImageView: UIImageView = {
        let image = UIImage(named: "netflix")
        let imageView = UIImageView(image: image!)
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.text = "Name"

        return label
    }()

    let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.text = "Price"

        return label
    }()
    
    func layout() {
        addSubview(channelImageView)
        addSubview(nameLabel)
        addSubview(priceLabel)

        nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        channelImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        channelImageView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 3).isActive = true

        priceLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        trailingAnchor.constraint(equalToSystemSpacingAfter: priceLabel.trailingAnchor, multiplier: 3).isActive = true
    }

}

