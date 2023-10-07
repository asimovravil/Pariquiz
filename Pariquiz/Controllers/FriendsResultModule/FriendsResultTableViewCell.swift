//
//  FriendsResultTableViewCell.swift
//  Pariquiz
//
//  Created by Ravil on 06.10.2023.
//

import UIKit
import SnapKit

final class FriendsResultTableViewCell: UITableViewCell {

    static let reuseID = String(describing: FriendsResultTableViewCell.self)
    weak var navigationController: UINavigationController?
    var firstPlayerName: String?
    var secondPlayerName: String?
    var firstPlayerCorrectAnswers: Int = 0
    var secondPlayerCorrectAnswers: Int = 0
    var homeButtonTappedHandler: (() -> Void)?
    
    // MARK: - UI
    
    private lazy var drawView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.draw.uiImage
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
    
    private lazy var homeButton: UIButton = {
        let button = UIButton()
        button.setImage(AppImage.home.uiImage, for: .normal)
        button.addTarget(self, action: #selector(homeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.text = "Friends"
        label.textColor = AppColor.whiteCustom.uiColor
        label.font = UIFont(name: "OpenSans-Bold", size: 64)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var firstScoreLabel: UILabel = {
        let label = UILabel()
        label.text = "First Score:"
        label.textColor = AppColor.whiteCustom.uiColor
        label.font = UIFont(name: "OpenSans-Bold", size: 32)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var secondScoreLabel: UILabel = {
        let label = UILabel()
        label.text = "Second Score:"
        label.textColor = AppColor.whiteCustom.uiColor
        label.font = UIFont(name: "OpenSans-Bold", size: 32)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var firstAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "0/5"
        label.textColor = AppColor.whiteCustom.uiColor
        label.font = UIFont(name: "OpenSans-Bold", size: 32)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var secondAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "0/5"
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
        [victoryDopView, drawView, resultLabel,  firstScoreLabel, secondScoreLabel, firstAmountLabel, secondAmountLabel, homeButton].forEach() {
            contentView.addSubview($0)
        }
    }
    
    // MARK: - setupConstraints
    
    private func setupConstraints() {
        victoryDopView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        drawView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(-79)
            make.trailing.equalToSuperview().offset(79)
        }
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(drawView.snp.bottom).offset(-250)
            make.centerX.equalToSuperview()
        }
        firstScoreLabel.snp.makeConstraints { make in
            make.top.equalTo(drawView.snp.bottom)
            make.leading.equalToSuperview().offset(24)
        }
        secondScoreLabel.snp.makeConstraints { make in
            make.top.equalTo(firstScoreLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(24)
        }
        firstAmountLabel.snp.makeConstraints { make in
            make.top.equalTo(drawView.snp.bottom)
            make.trailing.equalToSuperview().offset(-24)
        }
        secondAmountLabel.snp.makeConstraints { make in
            make.top.equalTo(firstAmountLabel.snp.bottom).offset(10)
            make.trailing.equalToSuperview().offset(-24)
        }
        homeButton.snp.makeConstraints { make in
            make.top.equalTo(secondScoreLabel.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Actions
    
    @objc private func homeButtonTapped() {
        homeButtonTappedHandler?()
    }
    
    private func calculateScore() {
        let totalQuestions = 5

        firstAmountLabel.text = "\(firstPlayerCorrectAnswers)/\(totalQuestions)"
        secondAmountLabel.text = "\(secondPlayerCorrectAnswers)/\(totalQuestions)"

        firstScoreLabel.text = "\(firstPlayerName ?? "Player 1"): "
        secondScoreLabel.text = "\(secondPlayerName ?? "Player 2"): "
    }
    
    func configure() {
        calculateScore()
    }

}
