//
//  GameView.swift
//  SimpleAppExtractViewController
//
//  Created by Jonathan Rasmusson (Contractor) on 2020-05-11.
//  Copyright © 2020 Jonathan Rasmusson. All rights reserved.
//

import UIKit

class GameView: UIView {

    var game: Game? {
        didSet {
            guard let game = game else { return }
            profileImage.image = UIImage(named: game.imageName)
            titleLabel.text = game.name
            bodyLabel.text = game.description
        }
    }

    lazy var profileImage: UIImageView = {
        return makeProfileImageView(withName: "space-invaders")
    }()

    lazy var titleLabel: UILabel = {
        return makeTitleLabel(withTitle: "Space Invaders")
    }()

    lazy var bodyLabel: UILabel = {
        return makeLabel(withTitle: "Space Invaders is a Japanese shooting video game released in 1978 by Taito. It was developed by Tomohiro Nishikado, who was inspired by other media: Breakout, The War of the Worlds, and Star Wars.")
    }()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)

        let stackView = makeVerticalStackView()

        addSubview(stackView)

        stackView.addArrangedSubview(profileImage)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(bodyLabel)

        profileImage.heightAnchor.constraint(equalToConstant: 100).isActive = true

        stackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 0).isActive = true
        stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 0).isActive = true
        trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 0).isActive = true
        bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 0).isActive = true
    }

}

