//
//  RewardsTableViewCell.swift
//  Pariquiz
//
//  Created by Ravil on 06.10.2023.
//

import UIKit
import SnapKit

final class RewardsTableViewCell: UITableViewCell {

    static let reuseID = String(describing: RewardsTableViewCell.self)
    
    // MARK: - UI
    
    private lazy var rewardsLabel: UILabel = {
        let label = UILabel()
        label.text = "Rewards"
        label.font = UIFont(name: "OpenSans-SemiBold", size: 32)
        label.textColor = AppColor.yellowCustom.uiColor
        return label
    }()
    
    private lazy var rewardsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.rewardsCell.uiImage
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setupViews
    
    private func setupViews() {
        [rewardsLabel, rewardsImage].forEach() {
            contentView.addSubview($0)
        }
    }
    
    // MARK: - setupConstraints
    
    private func setupConstraints() {
        rewardsLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(24)
        }
        rewardsImage.snp.makeConstraints { make in
            make.top.equalTo(rewardsLabel.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
        }
    }
}
