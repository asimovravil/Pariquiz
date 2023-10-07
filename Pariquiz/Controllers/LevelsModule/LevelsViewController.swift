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
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LevelsTableViewCell.reuseID, for: indexPath) as? LevelsTableViewCell else {
            fatalError("Could not cast to LevelsTableViewCell")
        }
        switch indexPath.row {
        case 0:
            cell.configure(with: AppImage.footballImage.rawValue , localizedName: "Football")
        case 1:
            cell.configure(with: AppImage.goalkeeperImage.rawValue , localizedName: "Goalkeeper")
        case 2:
            cell.configure(with: AppImage.footballImage.rawValue , localizedName: "Example 1")
        case 3:
            cell.configure(with: AppImage.goalkeeperImage.rawValue , localizedName: "Example 2")
        case 4:
            cell.configure(with: AppImage.footballImage.rawValue , localizedName: "Example 3")
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





