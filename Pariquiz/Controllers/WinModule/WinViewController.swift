//
//  WinViewController.swift
//  Pariquiz
//
//  Created by Ravil on 06.10.2023.
//

import UIKit
import SnapKit

final class WinViewController: UIViewController {

    var userCorrectAnswers: Int = 0
    var score: Int {
        get {
            return UserDefaults.standard.integer(forKey: "score")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "score")
            coinWalletLabel.text = "\(newValue)"
        }
    }
    
    // MARK: - UI
    
    private lazy var coinWalletImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.soloCoin.uiImage
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    public lazy var coinWalletStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [coinWalletLabel, coinWalletImage])
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
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(WinTableViewCell.self, forCellReuseIdentifier: WinTableViewCell.reuseID)
        tableView.layer.cornerRadius = 26
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.rowHeight = 800
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
    }
    
    // MARK: - setupViews
    
    private func setupViews() {
        [tableView].forEach {
            view.addSubview($0)
        }
        view.backgroundColor = AppColor.blackCustom.uiColor
    }
    
    // MARK: - setupConstraints
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}

extension WinViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WinTableViewCell.reuseID, for: indexPath) as? WinTableViewCell else {
            fatalError("Could not cast to WinTableViewCell")
        }
        cell.navigationController = self.navigationController
        cell.userCorrectAnswers = userCorrectAnswers
        cell.configure()
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.awesomeButtonTappedHandler = {
            let controller = TabBarController()
            self.score += 20
            controller.navigationItem.hidesBackButton = true
            self.navigationController?.pushViewController(controller, animated: true)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
