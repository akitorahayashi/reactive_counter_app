//
//  CounterGridCell.swift
//  reactive_counter_app
//
//  Created by 林 明虎 on 2025/01/12.
//

import UIKit

class CounterGridCell: UICollectionViewCell {
    static let identifier = "CounterGridCell"

    private let counterLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.gray.cgColor
        contentView.layer.cornerRadius = 8

        counterLabel.textAlignment = .center
        counterLabel.font = UIFont.systemFont(ofSize: 16)
        counterLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(counterLabel)

        NSLayoutConstraint.activate([
            counterLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            counterLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    func configure(with counter: RCCounter) {
        counterLabel.text = "\(counter.value)"
    }
}
