//
//  SettingsViewController.swift
//  Pariquiz
//
//  Created by Ravil on 06.10.2023.
//

import UIKit
import SnapKit

final class SettingsViewController: UIViewController {

    private var isVibratorActive = false
    
    // MARK: - UI
    
    private lazy var settingsLabel: UILabel = {
        let label = UILabel()
        label.text = "Settings"
        label.font = UIFont(name: "OpenSans-SemiBold", size: 32)
        label.textColor = AppColor.yellowCustom.uiColor
        return label
    }()
    
    private lazy var notificationButton: UIButton = {
        let button = UIButton()
        button.setImage(AppImage.notification.uiImage, for: .normal)
        button.addTarget(self, action: #selector(notificationButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var rateUsButton: UIButton = {
        let button = UIButton()
        button.setImage(AppImage.rateUs.uiImage, for: .normal)
        button.addTarget(self, action: #selector(rateUsButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var shareAppButton: UIButton = {
        let button = UIButton()
        button.setImage(AppImage.shareApp.uiImage, for: .normal)
        button.addTarget(self, action: #selector(shareAppButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var privacyPolicyButton: UIButton = {
        let button = UIButton()
        button.setImage(AppImage.privacyPolicy.uiImage, for: .normal)
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
        [settingsLabel, notificationButton, rateUsButton, shareAppButton, privacyPolicyButton].forEach {
            view.addSubview($0)
        }
        updateNotificationButtonImage()
        view.backgroundColor = AppColor.blackCustom.uiColor
    }
    
    // MARK: - setupConstraints
    
    private func setupConstraints() {
        settingsLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.leading.equalToSuperview().offset(24)
        }
        notificationButton.snp.makeConstraints { make in
            make.top.equalTo(settingsLabel.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
            make.height.equalTo(48)
        }
        rateUsButton.snp.makeConstraints { make in
            make.top.equalTo(notificationButton.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(48)
        }
        shareAppButton.snp.makeConstraints { make in
            make.top.equalTo(rateUsButton.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(48)
        }
        privacyPolicyButton.snp.makeConstraints { make in
            make.top.equalTo(shareAppButton.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(48)
        }
    }
    
    // MARK: - notificationButtonTapped
    
    @objc private func notificationButtonTapped() {
        isVibratorActive.toggle()
        updateNotificationButtonImage()
    }

    private func updateNotificationButtonImage() {
        let image = isVibratorActive ? AppImage.notificationOn.uiImage : AppImage.notification.uiImage
        notificationButton.setImage(image, for: .normal)
    }
    
    // MARK: - shareAppButtonTapped
    
    @objc private func shareAppButtonTapped() {
        let actionSheet = UIAlertController(title: nil, message: "Share App", preferredStyle: .actionSheet)
        let messageAction = UIAlertAction(title: "Share via Message", style: .default) { [weak self] _ in
            self?.shareAppViaMessage()
        }

        let otherAppsAction = UIAlertAction(title: "Share via Other Apps", style: .default) { [weak self] _ in
            self?.shareAppViaOtherApps()
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        actionSheet.addAction(messageAction)
        actionSheet.addAction(otherAppsAction)
        actionSheet.addAction(cancelAction)

        present(actionSheet, animated: true, completion: nil)
    }
    
    private func shareAppViaMessage() {
    }

    private func shareAppViaOtherApps() {
        let textToShare = "Check out this awesome app!"
        let appURL = URL(string: "https://www.yourappstorelink.com")!

        let activityViewController = UIActivityViewController(activityItems: [textToShare, appURL], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
    
    // MARK: - rateUsButtonTapped
    
    @objc private func rateUsButtonTapped() {
        let appName = "Moony Journey"

        if let url = URL(string: "https://itunes.apple.com/search?term=\(appName)&entity=software") {
            let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    return
                }
                if let data = data {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                           let results = json["results"] as? [[String: Any]],
                           let firstResult = results.first,
                           let appID = firstResult["trackId"] as? Int {
                            self.openAppStorePage(for: appID)
                        }
                    } catch {
                        print("JSON parsing error: \(error.localizedDescription)")
                    }
                }
            }
            task.resume()
        }
    }

    private func openAppStorePage(for appID: Int) {
        let appStoreURL = URL(string: "itms-apps://itunes.apple.com/app/id\(appID)?action=write-review")!

        if UIApplication.shared.canOpenURL(appStoreURL) {
            UIApplication.shared.open(appStoreURL, options: [:], completionHandler: nil)
        } else {
            print("Unable to open App Store URL")
        }
    }
}
