//
//  QuizViewController.swift
//  Pariquiz
//
//  Created by Ravil on 07.10.2023.
//

import UIKit
import SnapKit

final class QuizViewController: UIViewController {
    
    var isTimeMode: Bool = false
    var timer: Timer? 
    var remainingTime = 300
    var firstPlayerName: String = ""
    var secondPlayerName: String = ""
    var currentQuestionNumber: Int = 0
    var isFriendMode: Bool = false
    var firstPlayerCorrectAnswers: Int = 0
    var secondPlayerCorrectAnswers: Int = 0
    
    // MARK: - UI
    
    public lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSans-Bold", size: 24)
        label.text = "03:00"
        label.textColor = AppColor.whiteCustom.uiColor
        label.textAlignment = .right
        return label
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
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(QuizTableViewCell.self, forCellReuseIdentifier: QuizTableViewCell.reuseID)
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
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let score = UserDefaults.standard.integer(forKey: "score")
        coinWalletLabel.text = "\(score)"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if isTimeMode {
            startTimer()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer?.invalidate()
    }

    func startTimer() {
        timer = Timer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
        timer?.fire()
    }

    @objc func updateTimer() {
        if remainingTime > 0 {
            remainingTime -= 1
            let minutes = remainingTime / 60
            let seconds = remainingTime % 60
            
            DispatchQueue.main.async { [weak self] in
                self?.timerLabel.text = String(format: "%02d:%02d", minutes, seconds)
            }
        } else {
            timer?.invalidate()
            DispatchQueue.main.async { [weak self] in
                let loseViewController = LoseViewController()
                self?.navigationController?.pushViewController(loseViewController, animated: true)
            }
        }
    }
    
    // MARK: - setupViews
    
    private func setupViews() {
        [timerLabel, tableView, coinWalletStackView].forEach() {
            view.addSubview($0)
        }
        view.backgroundColor = AppColor.blackCustom.uiColor
    }
    
    // MARK: - setupConstraints
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: - setupNavigationBar
    
    private func setupNavigationBar() {
        let titleLabel = UILabel()
        titleLabel.font = UIFont(name: "OpenSans-Bold", size: 24)
        titleLabel.textColor = AppColor.yellowCustom.uiColor
        titleLabel.sizeToFit()

        if isFriendMode {
            let currentPlayerName = currentQuestionNumber % 2 == 0 ? firstPlayerName : secondPlayerName
            titleLabel.text = currentPlayerName
        } else {
            titleLabel.text = "Game"
        }

        navigationItem.titleView = titleLabel
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        if isTimeMode {
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: timerLabel)
        } else {
            let coinWalletBarButtonItem = UIBarButtonItem(customView: coinWalletStackView)
            navigationItem.rightBarButtonItem = coinWalletBarButtonItem
        }
    }
    
    func moveToNextQuestion() {
        currentQuestionNumber += 1
        setupNavigationBar()
    }
}

extension QuizViewController: QuestionDelegate {
    func didUpdateQuestionNumber(to questionNumber: Int) {
        currentQuestionNumber = questionNumber
        setupNavigationBar()
    }
}

extension QuizViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: QuizTableViewCell.reuseID, for: indexPath) as? QuizTableViewCell else {
            fatalError("Could not cast to QuizTableViewCell")
        }
        cell.isFriendMode = isFriendMode
        cell.questionDelegate = self
        cell.navigationController = self.navigationController
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

