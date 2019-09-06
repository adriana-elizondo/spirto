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
        let profileViewController = ProfileViewController(name: nil)
        if let tabItem = Bundle.main.loadNibNamed("TabBarItem", owner: nil, options: nil)?.first as? STabBarItem {
            tabItem.backgroundColor = UIColor.spirtoColor()
            tabItem.itemImageView.image = #imageLiteral(resourceName: "profile")
            tabItem.itemImageView.setImageColor(color: UIColor.white)
            tabItem.viewcontroller = profileViewController
            tabBar?.addNewItem(item: tabItem)
        }
        tabBar?.backgroundColor = UIColor.spirtoColor()
        tabBar?.selectItem(at: 0)
    }
}
