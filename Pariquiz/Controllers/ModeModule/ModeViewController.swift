//
//  ModeViewController.swift
//  Pariquiz
//
//  Created by Ravil on 06.10.2023.
//

import UIKit
import SnapKit

final class ModeViewController: UIViewController {

    // MARK: - UI
    
    public lazy var withFriendButton: UIButton = {
        let button = UIButton()
        button.setImage(AppImage.withFriend.uiImage, for: .normal)
        button.addTarget(self, action: #selector(withFriendButtonTapped), for: .touchUpInside)
        return button
    }()
    
    public lazy var forTimeButton: UIButton = {
        let button = UIButton()
        button.setImage(AppImage.forTime.uiImage, for: .normal)
        button.addTarget(self, action: #selector(forTimeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    public lazy var freeButton: UIButton = {
        let button = UIButton()
        button.setImage(AppImage.free.uiImage, for: .normal)
        button.addTarget(self, action: #selector(freeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var coinWalletImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.soloCoin.uiImage
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        return imageView
    }()
    
    public lazy var coinWalletStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [coinWalletImage, coinWalletLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var coinWalletLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont(name: "OpenSans-Bold", size: 24)
        label.textColor = AppColor.whiteCustom.uiColor
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let score = UserDefaults.standard.integer(forKey: "score")
        coinWalletLabel.text = "\(score)"
    }
    
    // MARK: - setupViews
    
    private func setupViews() {
        [withFriendButton, forTimeButton, freeButton, coinWalletStackView].forEach {
            view.addSubview($0)
        }
        view.backgroundColor = AppColor.blackCustom.uiColor
    }
    
    // MARK: - setupConstraints
    
    private func setupConstraints() {
        withFriendButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(200)
            make.centerX.equalToSuperview()
        }
        forTimeButton.snp.makeConstraints { make in
            make.top.equalTo(withFriendButton.snp.bottom).offset(60)
            make.centerX.equalToSuperview()
        }
        freeButton.snp.makeConstraints { make in
            make.top.equalTo(forTimeButton.snp.bottom).offset(60)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - setupNavigationBar
        
    private func setupNavigationBar() {
        let titleLabel = UILabel()
        titleLabel.text = "Mode"
        titleLabel.font = UIFont(name: "OpenSans-Bold", size: 24)
        titleLabel.textColor = AppColor.yellowCustom.uiColor
        titleLabel.sizeToFit()
        
        navigationItem.titleView = titleLabel
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        let coinWalletBarButtonItem = UIBarButtonItem(customView: coinWalletStackView)
        navigationItem.rightBarButtonItem = coinWalletBarButtonItem
    }
    
    // MARK: - Actions
    
    @objc func withFriendButtonTapped() {
        let quizViewController = WithFriendViewController()
        navigationController?.pushViewController(quizViewController, animated: true)
    }
    
    @objc func forTimeButtonTapped() {
        let quizViewController = QuizViewController()
        quizViewController.isTimeMode = true
        navigationController?.pushViewController(quizViewController, animated: true)
        quizViewController.navigationItem.hidesBackButton = true
    }
    
    @objc func freeButtonTapped() {
        let quizViewController = QuizViewController()
        navigationController?.pushViewController(quizViewController, animated: true)
    }
}
