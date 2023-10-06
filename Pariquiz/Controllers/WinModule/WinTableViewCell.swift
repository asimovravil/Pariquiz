//
//  WinTableViewCell.swift
//  Pariquiz
//
//  Created by Ravil on 06.10.2023.
//

import UIKit
import SnapKit

final class WinTableViewCell: UITableViewCell {

    static let reuseID = String(describing: WinTableViewCell.self)
    weak var navigationController: UINavigationController?
    var userCorrectAnswers: Int = 0
    var awesomeButtonTappedHandler: (() -> Void)?
    
    // MARK: - UI
    
    private lazy var victoryView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.victory.uiImage
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var victoryDopView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.victoryDop.uiImage
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var coinWinView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.coinWin.uiImage
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var awesomeButton: UIButton = {
        let button = UIButton()
        button.setImage(AppImage.awesome.uiImage, for: .normal)
        button.addTarget(self, action: #selector(awesomeButtonTapped), for: .touchUpInside)
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
        [victoryDopView, victoryView, coinWinView, scoreLabel, amountLabel, awesomeButton].forEach() {
            contentView.addSubview($0)
        }
    }
    
    // MARK: - setupConstraints
    
    private func setupConstraints() {
        victoryDopView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        victoryView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(-79)
            make.trailing.equalToSuperview().offset(79)
        }
        coinWinView.snp.makeConstraints { make in
            make.bottom.equalTo(victoryView.snp.bottom).offset(-70)
            make.centerX.equalToSuperview()
        }
        scoreLabel.snp.makeConstraints { make in
            make.top.equalTo(victoryView.snp.bottom)
            make.leading.equalToSuperview().offset(24)
        }
        amountLabel.snp.makeConstraints { make in
            make.top.equalTo(victoryView.snp.bottom)
            make.trailing.equalToSuperview().offset(-24)
        }
        awesomeButton.snp.makeConstraints { make in
            make.top.equalTo(scoreLabel.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Actions
    
    @objc private func awesomeButtonTapped() {
        awesomeButtonTappedHandler?()
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

