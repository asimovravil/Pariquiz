//
//  LoseTableViewCell.swift
//  Pariquiz
//
//  Created by Ravil on 06.10.2023.
//

import UIKit
import SnapKit

final class LoseTableViewCell: UITableViewCell {

    static let reuseID = String(describing: LoseTableViewCell.self)
    weak var navigationController: UINavigationController?
    var userCorrectAnswers: Int = 0
    var tryAgainButtonTappedHandler: (() -> Void)?
    
    // MARK: - UI
    
    private lazy var loseView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.defeat.uiImage
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var tryAgainButton: UIButton = {
        let button = UIButton()
        button.setImage(AppImage.tryAgain.uiImage, for: .normal)
        button.addTarget(self, action: #selector(tryAgainButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "Your Score:"
        label.textColor = AppColor.whiteCustom.uiColor
        label.font = UIFont(name: "OpenSans-Bold", size: 32)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.text = "10/10"
        label.textColor = AppColor.whiteCustom.uiColor
        label.font = UIFont(name: "OpenSans-Bold", size: 32)
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
        calculateScore()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setupViews
    
    private func setupViews() {
        [loseView, scoreLabel, amountLabel, tryAgainButton].forEach() {
            contentView.addSubview($0)
        }
    }
    
    // MARK: - setupConstraints
    
    private func setupConstraints() {
        loseView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(-79)
            make.trailing.equalToSuperview().offset(79)
        }
        scoreLabel.snp.makeConstraints { make in
            make.top.equalTo(loseView.snp.bottom)
            make.leading.equalToSuperview().offset(24)
        }
        amountLabel.snp.makeConstraints { make in
            make.top.equalTo(loseView.snp.bottom)
            make.trailing.equalToSuperview().offset(-24)
        }
        tryAgainButton.snp.makeConstraints { make in
            make.top.equalTo(scoreLabel.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Actions
    
    @objc private func tryAgainButtonTapped() {
        tryAgainButtonTappedHandler?()
    }
    
    private func calculateScore() {
        let totalQuestions = 10
        amountLabel.text = "\(userCorrectAnswers)"
        
        _ = (Double(userCorrectAnswers) / Double(totalQuestions)) * 100.0
        
        amountLabel.text = "\(userCorrectAnswers)/\(totalQuestions)"
    }
    
    func configure() {
        calculateScore()
    }

}
