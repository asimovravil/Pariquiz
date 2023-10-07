//
//  LevelsViewController.swift
//  Pariquiz
//
//  Created by Ravil on 05.10.2023.
//

import UIKit
import SnapKit

final class LevelsViewController: UIViewController {

    // MARK: - UI
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(LevelsTableViewCell.self, forCellReuseIdentifier: LevelsTableViewCell.reuseID)
        tableView.layer.cornerRadius = 26
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = AppColor.colorTabCustom.uiColor
        tableView.rowHeight = 282
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        return tableView
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
        [coinWalletStackView, tableView].forEach {
            view.addSubview($0)
        }
    }

    // MARK: - setupConstraints
        
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: - setupNavigationBar
        
    private func setupNavigationBar() {
        let titleLabel = UILabel()
        titleLabel.text = "Levels"
        titleLabel.font = UIFont(name: "OpenSans-Bold", size: 24)
        titleLabel.textColor = AppColor.yellowCustom.uiColor
        titleLabel.sizeToFit()
        
        navigationItem.titleView = titleLabel
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        let coinWalletBarButtonItem = UIBarButtonItem(customView: coinWalletStackView)
        navigationItem.rightBarButtonItem = coinWalletBarButtonItem
    }
}

extension LevelsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LevelsTableViewCell.reuseID, for: indexPath) as? LevelsTableViewCell else {
            fatalError("Could not cast to LevelsTableViewCell")
        }
        switch indexPath.row {
        case 0:
            cell.configure(with: AppImage.footballImage.rawValue , localizedName: "Football")
            cell.playButton.setImage(AppImage.playButton.uiImage, for: .normal)
            cell.playButton.isEnabled = true
            cell.priceQuizImage.isHidden = true
        case 1, 2:
            cell.configure(with: indexPath.row == 1 ? AppImage.goalkeeperImage.rawValue : AppImage.question.rawValue , localizedName: indexPath.row == 1 ? "Goalkeeper" : "Guardian")
            cell.playButton.setImage(AppImage.buyButton.uiImage, for: .normal)
            cell.playButton.isEnabled = false
            cell.priceQuizImage.isHidden = false
        default:
            cell.imageName = nil
            cell.localizedName = nil
        }
        cell.playButtonTappedHandler = {
            let controller = ModeViewController()
            self.navigationController?.pushViewController(controller, animated: true)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}





