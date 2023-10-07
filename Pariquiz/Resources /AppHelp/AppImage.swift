//
//  AppImage.swift
//  Pariquiz
//
//  Created by Ravil on 05.10.2023.
//

import Foundation
import UIKit

protocol AppImageProtocol {
    var rawValue: String { get }
}

extension AppImageProtocol {

    var uiImage: UIImage? {
        guard let image = UIImage(named: rawValue) else {
            fatalError("Could not find image with name \(rawValue)")
        }
        return image
    }
    
    var systemImage: UIImage? {
        guard let image = UIImage(systemName: rawValue) else {
            fatalError("Could not find image with name \(rawValue)")
        }
        return image
    }
    
}

enum AppImage: String, AppImageProtocol {
    
    // MARK: - AppImage
    
    case soloCoin
    case pariquizLogo
    case splashLoading
    case startQuizButton
    case startQuizInactiveButton
    case rewardsCell
    
    // MARK: - TabBar
    
    case homeTabActive
    case rewardsTabActive
    case settingsTabActive
    
    case homeTabInactive
    case rewardsTabInactive
    case settingsTabInactive
    
    // MARK: - Levels
    
    case playButton
    case buyButton
    case footballImage
    case goalkeeperImage
    case priceQuiz
    case questionsTime
    
    // MARK: - Mode
    
    case withFriend
    case forTime
    case free
    
    // MARK: - Settings
    
    case notification
    case notificationOn
    case rateUs
    case shareApp
    case privacyPolicy
    
    // MARK: - Results
    
    case coinWin
    case defeat
    case victory
    case home
    case awesome
    case tryAgain
    case victoryDop
    case draw
}

