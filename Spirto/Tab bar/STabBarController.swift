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
    func selectedState() {}
    func unSelectedState() {}
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
        homeNavigationController.navigationBar.isTranslucent = false
        homeNavigationController.isNavigationBarHidden = true
        let homeController = HomeViewController(name: nil)
        homeNavigationController.viewControllers = [homeController]
        if let tabItem = Bundle.main.loadNibNamed("TabBarItem", owner: nil, options: nil)?.first as? STabBarItem {
            tabItem.itemImageView.image = #imageLiteral(resourceName: "coffe_cup")
            tabItem.viewcontroller = homeNavigationController
            tabBar?.addNewItem(item: tabItem)
        }
        //profile
        let profileViewController = ProfileViewController(name: nil)
        if let tabItem = Bundle.main.loadNibNamed("TabBarItem", owner: nil, options: nil)?.first as? STabBarItem {
            tabItem.itemImageView.image = #imageLiteral(resourceName: "profile")
            tabItem.viewcontroller = profileViewController
            tabBar?.addNewItem(item: tabItem)
        }
        tabBar?.backgroundColor = UIColor.spirtoColor()
        //        viewControllers = [homeNavigationController, profileViewController]
        //        tabBar.backgroundColor = UIColor.spirtoColor()
        //        tabBar.tintColor = UIColor.white
        //        tabBar.barTintColor = UIColor.spirtoColor()
        //        tabBar.isTranslucent = false
        //        tabBar.unselectedItemTintColor = UIColor.gray
    }
}
