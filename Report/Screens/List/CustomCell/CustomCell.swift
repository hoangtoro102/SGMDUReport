//
//  CustomCell.swift
//  Report
//
//  Created by HoangNguyen on 7/2/20.
//  Copyright © 2020 HoangNguyen. All rights reserved.
//

import UIKit
import TinyConstraints

class CustomCell: UITableViewCell {
    
    var headerLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 20)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.accessibilityIdentifier = "headerLabel"
        return label
    }()
    var totalLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .lightGray
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 12)
        label.accessibilityIdentifier = "totalLabel"
        return label
    }()
    var clickableImageView: UIImageView = {
        let imageV = UIImageView(frame: .zero)
        imageV.clipsToBounds = true
        imageV.image = UIImage(named: "ic_arrow_down")
        return imageV
    }()
    var btnCover: UIButton = {
        let btn = UIButton(frame: .zero)
        btn.backgroundColor = .clear
        btn.isUserInteractionEnabled = true
        btn.isEnabled = true
        return btn
    }()
    var displayItem: DisplayItem? {
        didSet {
            if let displayItem = displayItem {
                headerLabel.text = "Year: \(displayItem.year)"
                let formatText = String(format: "%.5f", displayItem.volumeOfYear)
                totalLabel.text = "Total volume of mobile data: \(formatText) (Petabytes)"
                totalLabel.highlight(searchedText: formatText, color: .darkGray)
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

    @objc private func imageTapped() {
        print("Clickable image tapped")
    }
    
    private func setupViews() {
        selectionStyle = UITableViewCell.SelectionStyle.none
    
        addSubview(headerLabel)
        addSubview(totalLabel)
        addSubview(clickableImageView)
        addSubview(btnCover)
        
        btnCover.addTarget(self, action: #selector(imageTapped), for: .touchUpInside)
        
        let labelStackView = UIStackView()
        addSubview(labelStackView)
        labelStackView.addArrangedSubview(headerLabel)
        labelStackView.addArrangedSubview(totalLabel)
        labelStackView.axis = .vertical

        clickableImageView.height(18)
        clickableImageView.width(16)
        clickableImageView.centerYToSuperview()
        clickableImageView.edgesToSuperview(excluding: [.top, .bottom, .left], insets: .right(10))
        btnCover.edges(to: clickableImageView)
        
        labelStackView.edgesToSuperview(excluding: .bottom, insets: .top(10) + .left(10) + .right(40))
    }
}
