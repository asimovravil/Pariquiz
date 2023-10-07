//
//  WithFriendViewController.swift
//  Pariquiz
//
//  Created by Ravil on 07.10.2023.
//

import UIKit
import SnapKit

protocol QuestionDelegate: AnyObject {
    func didUpdateQuestionNumber(to questionNumber: Int)
}

final class WithFriendViewController: UIViewController {

    // MARK: - UI
    
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
    
    private lazy var firstPlayerLabel: UILabel = {
        let label = UILabel()
        label.text = "1st Player"
        label.textColor = AppColor.yellowCustom.uiColor
        label.font = UIFont(name: "OpenSans-Bold", size: 24)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var secondPlayerLabel: UILabel = {
        let label = UILabel()
        label.text = "2nd Player"
        label.textColor = AppColor.yellowCustom.uiColor
        label.font = UIFont(name: "OpenSans-Bold", size: 24)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var firstTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Name"
        textField.font = UIFont(name: "OpenSans-Bold", size: 32)
        textField.textAlignment = .center
        textField.borderStyle = .none
        textField.textColor = AppColor.whiteCustom.uiColor
        textField.keyboardType = .default
        textField.backgroundColor = AppColor.colorTabCustom.uiColor
        textField.layer.cornerRadius = 26
        textField.leftViewMode = .always
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return textField
    }()
    
    private lazy var secondTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Name"
        textField.font = UIFont(name: "OpenSans-Bold", size: 32)
        textField.textAlignment = .center
        textField.borderStyle = .none
        textField.textColor = AppColor.whiteCustom.uiColor
        textField.keyboardType = .default
        textField.backgroundColor = AppColor.colorTabCustom.uiColor
        textField.layer.cornerRadius = 26
        textField.leftViewMode = .always
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return textField
    }()
    
    public lazy var startQuizButton: UIButton = {
        let button = UIButton()
        button.setImage(AppImage.startQuizButton.uiImage, for: .normal)
        button.addTarget(self, action: #selector(startQuizButtonTapped), for: .touchUpInside)
        return button
    }()
    
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
        [coinWalletStackView, firstPlayerLabel, firstTextField, secondPlayerLabel, secondTextField, startQuizButton].forEach {
            view.addSubview($0)
        }
        view.backgroundColor = AppColor.blackCustom.uiColor
    }
    
    // MARK: - setupConstraints
    
    private func setupConstraints() {
        firstPlayerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(135)
            make.centerX.equalToSuperview()
        }
        firstTextField.snp.makeConstraints { make in
            make.top.equalTo(firstPlayerLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(76)
        }
        secondPlayerLabel.snp.makeConstraints { make in
            make.top.equalTo(firstTextField.snp.bottom).offset(48)
            make.centerX.equalToSuperview()
        }
        secondTextField.snp.makeConstraints { make in
            make.top.equalTo(secondPlayerLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(76)
        }
        startQuizButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-75)
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
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        let isBothTextFieldsFilled = (firstTextField.text?.count ?? 0) >= 3 && (secondTextField.text?.count ?? 0) >= 3
        
        startQuizButton.setImage(isBothTextFieldsFilled ? AppImage.startQuizButton.uiImage : AppImage.startQuizInactiveButton.uiImage, for: .normal)
        
        startQuizButton.isEnabled = isBothTextFieldsFilled
    }

    @objc private func startQuizButtonTapped() {
        let controller = QuizViewController()
        controller.isFriendMode = true
        controller.firstPlayerName = firstTextField.text ?? "Player 1"
        controller.secondPlayerName = secondTextField.text ?? "Player 2"
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension WithFriendViewController: QuestionDelegate {
    func didUpdateQuestionNumber(to questionNumber: Int) {
        let currentPlayerName = (questionNumber + 1) % 2 == 0 ? secondTextField.text ?? "Player 2" : firstTextField.text ?? "Player 1"
        
        let titleLabel = UILabel()
        titleLabel.text = currentPlayerName
        titleLabel.font = UIFont(name: "OpenSans-Bold", size: 24)
        titleLabel.textColor = AppColor.yellowCustom.uiColor
        titleLabel.sizeToFit()
        
        navigationItem.titleView = titleLabel
    }
}
