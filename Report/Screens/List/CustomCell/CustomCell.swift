//
//  CustomCell.swift
//  Report
//
//  Created by HoangNguyen on 7/2/20.
//  Copyright © 2020 HoangNguyen. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    var headerLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 24)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        return label
    }()
    var totalLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .lightGray
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    var clickableImageView: UIImageView = {
        let imageV = UIImageView(frame: .zero)
        imageV.clipsToBounds = true
        imageV.layer.cornerRadius = 10
        imageV.image = UIImage(named: "ic_arrow_down")
        return imageV
    }()
    var displayItem: DisplayItem? {
        didSet {
            if let displayItem = displayItem {
                headerLabel.text = "Year: \(displayItem.year)"
                totalLabel.text = "Total volume of mobile data: \(displayItem.volumeOfYear) (Petabytes)"
                clickableImageView.isHidden = !displayItem.decrease
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        backgroundColor = .systemBackground
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        addSubview(headerLabel)
        addSubview(totalLabel)
        let labelStackView = UIStackView()
        addSubview(labelStackView)
        labelStackView.addArrangedSubview(headerLabel)
        labelStackView.addArrangedSubview(totalLabel)
        labelStackView.axis = .vertical

        labelStackView.edgesToSuperview(excluding: .top, insets: .left(5))
    }
}
