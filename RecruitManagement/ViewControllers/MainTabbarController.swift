//
//  MainTabbarController.swift
//  RecuruitManagement
//
//  Created by Kai on 2021/06/27.
//

import UIKit

class MainTabbarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var viewControllers: [UIViewController] = []
        
        let listInstance = UIStoryboard(name: String(describing: RecruitListViewController.self), bundle: nil)
        if let RecuruitListViewController = listInstance.instantiateInitialViewController() {
            RecuruitListViewController.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarItem.SystemItem.mostRecent, tag: 1)
            viewControllers.append(RecuruitListViewController)
        }
        
//        firstViewController.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.MostRecent, tag: 1)
//        viewControllers.append(firstViewController)
//
//        let secondViewController = SecondViewController()
//        secondViewController.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.MostViewed, tag: 2)
//        viewControllers.append(secondViewController)
//
//        let thirdViewController = ThirdViewController()
//        thirdViewController.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.Contacts, tag: 3)
//        viewControllers.append(thirdViewController)
        
        self.setViewControllers(viewControllers, animated: false)
        
        
        // なぜか0だけだと選択されないので1にしてから0に
//        self.selectedIndex = 1
//        self.selectedIndex = 0
    }
}
