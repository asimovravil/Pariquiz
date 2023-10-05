//
//  MainViewController.swift
//  Pariquiz
//
//  Created by Ravil on 05.10.2023.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {

    private lazy var pariquizLogoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.pariquizLogo.uiImage
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var startQuizButton: UIButton = {
        let button = UIButton()
        button.setImage(AppImage.startQuizButton.uiImage, for: .normal)
        button.addTarget(self, action: #selector(startQuizButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
    }
    
    // MARK: - setupViews
    
    private func setupViews() {
        [pariquizLogoImage, startQuizButton].forEach() {
            view.addSubview($0)
        }
        view.backgroundColor = AppColor.blackCustom.uiColor
    }

    private func setupConstraints() {
        pariquizLogoImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(-59)
            make.trailing.equalToSuperview().offset(12)
        }
        startQuizButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-156)
        }
    }
        
    // MARK: - Actions
    
    @objc private func startQuizButtonTapped() {

    }
}
