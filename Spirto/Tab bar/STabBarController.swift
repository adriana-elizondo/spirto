//
//  STabBarController.swift
//  Spirto
//
//  Created by Adriana Elizondo on 2019/7/28.
//  Copyright © 2019 adriana. All rights reserved.
//

import Foundation
import UIKit

class STabBarItem: UIView, TopTabBarContainable {
    @IBOutlet weak var itemImageView: UIImageView!
    var viewcontroller: UIViewController?
    func selectedState() {
        itemImageView.alpha = 1.0
    }
    func unSelectedState() {
        itemImageView.alpha = 0.5
    }
}

class STabBarController: TopTabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    private func setup() {
        //home
        let homeNavigationController = UINavigationController()
        homeNavigationController.navigationBar.barTintColor = UIColor.spirtoColor()
        homeNavigationController.navigationBar.tintColor = UIColor.white
        homeNavigationController.navigationBar.shadowImage = UIImage()
        homeNavigationController.navigationBar.isTranslucent = false
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.clear]
        UINavigationBar.appearance().titleTextAttributes = textAttributes
        let homeController = HomeViewController(name: nil)
        homeNavigationController.viewControllers = [homeController]
        if let tabItem = Bundle.main.loadNibNamed("TabBarItem", owner: nil, options: nil)?.first as? STabBarItem {
            tabItem.backgroundColor = UIColor.spirtoColor()
            tabItem.itemImageView.image = #imageLiteral(resourceName: "coffe_cup")
            tabItem.itemImageView.setImageColor(color: UIColor.white)
            tabItem.viewcontroller = homeNavigationController
            tabBar?.addNewItem(item: tabItem)
        }
        //profile
        let profileNavigationController = UINavigationController()
        profileNavigationController.navigationBar.barTintColor = UIColor.spirtoColor()
        profileNavigationController.navigationBar.tintColor = UIColor.white
        profileNavigationController.navigationBar.shadowImage = UIImage()
        profileNavigationController.navigationBar.isTranslucent = false
        UINavigationBar.appearance().titleTextAttributes = textAttributes
        let profileViewController = ProfileViewController(name: nil)
        profileNavigationController.viewControllers = [profileViewController]
        if let tabItem = Bundle.main.loadNibNamed("TabBarItem", owner: nil, options: nil)?.first as? STabBarItem {
            tabItem.backgroundColor = UIColor.spirtoColor()
            tabItem.itemImageView.image = #imageLiteral(resourceName: "profile")
            tabItem.itemImageView.setImageColor(color: UIColor.white)
            tabItem.viewcontroller = profileNavigationController
            tabBar?.addNewItem(item: tabItem)
        }
        tabBar?.backgroundColor = UIColor.spirtoColor()
        tabBar?.selectItem(at: 0)
    }
}
