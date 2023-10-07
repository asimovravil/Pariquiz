//
//  FriendsResultViewController.swift
//  Pariquiz
//
//  Created by Ravil on 06.10.2023.
//

import UIKit
import SnapKit

final class FriendsResultViewController: UIViewController {

    var firstPlayerName: String?
    var secondPlayerName: String?
    var firstPlayerCorrectAnswers: Int = 0
    var secondPlayerCorrectAnswers: Int = 0
    
    // MARK: - UI
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(FriendsResultTableViewCell.self, forCellReuseIdentifier: FriendsResultTableViewCell.reuseID)
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

extension FriendsResultViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FriendsResultTableViewCell.reuseID, for: indexPath) as? FriendsResultTableViewCell else {
            fatalError("Could not cast to FriendsResultTableViewCell")
        }
        cell.navigationController = self.navigationController
        cell.firstPlayerCorrectAnswers = firstPlayerCorrectAnswers
        cell.secondPlayerCorrectAnswers = secondPlayerCorrectAnswers
        cell.firstPlayerName = firstPlayerName
        cell.secondPlayerName = secondPlayerName
        cell.configure()
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.homeButtonTappedHandler = {
            let controller = TabBarController()
            controller.navigationItem.hidesBackButton = true
            self.navigationController?.pushViewController(controller, animated: true)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
