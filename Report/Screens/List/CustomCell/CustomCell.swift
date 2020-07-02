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
        label.font = .systemFont(ofSize: 20)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        return label
    }()
    var totalLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .lightGray
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    var clickableImageView: UIImageView = {
        let imageV = UIImageView(frame: .zero)
        imageV.clipsToBounds = true
        imageV.image = UIImage(named: "ic_arrow_down")
        return imageV
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
extension UILabel {

    func highlight(searchedText: String?..., color: UIColor = .red) {
        guard let txtLabel = self.text else { return }

        let attributeTxt = NSMutableAttributedString(string: txtLabel)

        searchedText.forEach {
            if let searchedText = $0?.lowercased() {
                let range: NSRange = attributeTxt.mutableString.range(of: searchedText, options: .caseInsensitive)

                attributeTxt.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
                attributeTxt.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: self.font.pointSize), range: range)
            }
        }

        self.attributedText = attributeTxt
    }

}
