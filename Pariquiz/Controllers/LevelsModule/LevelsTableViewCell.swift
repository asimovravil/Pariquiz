//
//  LevelsTableViewCell.swift
//  Pariquiz
//
//  Created by Ravil on 05.10.2023.
//

import UIKit
import SnapKit

final class LevelsTableViewCell: UITableViewCell {

    static let reuseID = String(describing: LevelsTableViewCell.self)
    var playButtonTappedHandler: (() -> Void)?
    var buyButtonTappedHandler: (() -> Void)?
    
    // MARK: - UI
    
    private lazy var cardQuiz: UIView = {
        let uiView = UIView()
        uiView.layer.cornerRadius = 24
        uiView.backgroundColor = AppColor.colorTabCustom.uiColor
        return uiView
    }()
    
    private lazy var quizImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.footballImage.uiImage
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    
    private lazy var quizLabel: UILabel = {
        let label = UILabel()
        label.text = "Football"
        label.font = UIFont(name: "OpenSans-Bold", size: 20)
        label.textColor = AppColor.whiteCustom.uiColor
        return label
    }()
    
    private lazy var questionsTimeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.questionsTime.uiImage
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    public lazy var playButton: UIButton = {
        let button = UIButton()
        button.setImage(AppImage.playButton.uiImage, for: .normal)
        button.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        return button
    }()
    
    public lazy var buyButton: UIButton = {
        let button = UIButton()
        button.setImage(AppImage.buyButton.uiImage, for: .normal)
        button.addTarget(self, action: #selector(buyButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Properties

    var imageName: UIImage? {
        didSet {
            quizImage.image = imageName
        }
    }

    var localizedName: String? {
        didSet {
            quizLabel.text = localizedName
        }
    }
        
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
        [cardQuiz, quizImage, quizLabel, questionsTimeImage, playButton].forEach {
            contentView.addSubview($0)
        }
    }
    
    // MARK: - setupConstraints
    
    private func setupConstraints() {
        cardQuiz.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.centerX.equalToSuperview()
            make.height.equalTo(258)
            make.width.equalTo(342)
        }
        quizImage.snp.makeConstraints { make in
            make.top.equalTo(cardQuiz.snp.top).offset(16)
            make.leading.equalTo(cardQuiz.snp.leading).offset(16)
            make.trailing.equalTo(cardQuiz.snp.trailing).offset(-16)
            make.height.equalTo(150)
        }
        quizLabel.snp.makeConstraints { make in
            make.top.equalTo(quizImage.snp.bottom).offset(10)
            make.leading.equalTo(cardQuiz.snp.leading).offset(16)
        }
        questionsTimeImage.snp.makeConstraints { make in
            make.top.equalTo(quizLabel.snp.bottom).offset(4)
            make.leading.equalTo(cardQuiz.snp.leading).offset(16)
        }
        playButton.snp.makeConstraints { make in
            make.top.equalTo(quizImage.snp.bottom).offset(20)
            make.trailing.equalTo(cardQuiz.snp.trailing).offset(-16)
        }
    }
    
    // MARK: - Actions
    
    @objc private func playButtonTapped() {
        playButtonTappedHandler?()
    }
    
    @objc private func buyButtonTapped() {
        buyButtonTappedHandler?()
    }
    
    // MARK: - Configure Cell

    func configure(with imageName: String, localizedName: String) {
        self.imageName = UIImage(named: imageName)
        self.localizedName = localizedName
    }
}
