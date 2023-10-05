//
//  ViewController.swift
//  Pariquiz
//
//  Created by Ravil on 05.10.2023.
//

import UIKit
import SnapKit

final class SplashViewController: UIViewController {
    
    private lazy var pariquizLogoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.pariquizLogo.uiImage
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var splashLoadingImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.splashLoading.uiImage
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
    }
    
    // MARK: - setupViews
    
    private func setupViews() {
        [pariquizLogoImage, splashLoadingImage].forEach() {
            view.addSubview($0)
        }
        view.backgroundColor = AppColor.blackCustom.uiColor
        startRotationAnimation()
    }

    private func setupConstraints() {
        pariquizLogoImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(-59)
            make.trailing.equalToSuperview().offset(12)
        }
        splashLoadingImage.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-114)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Action
    
    private func startRotationAnimation() {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: [.repeat, .curveLinear], animations: {
            self.splashLoadingImage.transform = self.splashLoadingImage.transform.rotated(by: .pi)
        }, completion: nil)
    }
}

