//
//  TabBarController.swift
//  Pariquiz
//
//  Created by Ravil on 05.10.2023.
//

import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBar()
    }
    
    // MARK: - setupTabBar
    
    private func setupTabBar() {
        let mainViewController = MainViewController()
        let rewardsViewController = MainViewController()
        let settingViewController = MainViewController()
        
        self.tabBar.layer.cornerRadius = 30
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.tabBar.isTranslucent = true
        
        tabBar.backgroundColor = AppColor.colorTabCustom.uiColor
                
        mainViewController.tabBarItem = UITabBarItem(
            title: "Home", image: AppImage.homeTabInactive.uiImage,
            selectedImage: AppImage.homeTabActive.uiImage
        )
        mainViewController.tabBarItem.setTitleTextAttributes([.foregroundColor: AppColor.yellowCustom.uiColor], for: .normal)
        
        rewardsViewController.tabBarItem = UITabBarItem(
            title: "Rewards", image: AppImage.rewardsTabInactive.uiImage,
            selectedImage: AppImage.rewardsTabActive.uiImage
        )
        rewardsViewController.tabBarItem.setTitleTextAttributes([.foregroundColor: AppColor.yellowCustom.uiColor], for: .normal)
                
        settingViewController.tabBarItem = UITabBarItem(
            title: "Settings", image: AppImage.settingsTabInactive.uiImage,
            selectedImage: AppImage.settingsTabActive.uiImage
        )
        settingViewController.tabBarItem.setTitleTextAttributes([.foregroundColor: AppColor.yellowCustom.uiColor], for: .normal)
        
        viewControllers = [mainViewController, rewardsViewController, settingViewController]
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func generateViewController(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image?.withRenderingMode(.alwaysTemplate)
        return viewController
    }
}
