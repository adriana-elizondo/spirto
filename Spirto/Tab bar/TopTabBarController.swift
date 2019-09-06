//
//  TopTabBarController.swift
//  TopTabBarController
//
//  Created by Adriana Elizondo on 2019/8/20.
//  Copyright © 2019 adriana. All rights reserved.
//

import Foundation
import UIKit

class ItemTapGesture: UITapGestureRecognizer {
    var indexOfItem = 0
}

protocol TopTabBarContainable where Self: UIView {
    var viewcontroller: UIViewController? { get set }
    func selectedState()
    func unSelectedState()
}

protocol TopTabBarDelegate: class {
    func didSelect(item: TopTabBarContainable)
    func updatedHeight(to newHeight: CGFloat)
}

class TopTabBar: UIView {
    weak var delegate: TopTabBarDelegate?
    var items = [TopTabBarContainable]()
    private var currentHeight: CGFloat = 0
    func setHeight(to newHeight: CGFloat) {
        if newHeight > 0 { currentHeight = newHeight }
        var currentFrame = frame
        currentFrame.size.height = newHeight
        frame = currentFrame
        delegate?.updatedHeight(to: newHeight)
    }
    func setItems(items: [TopTabBarContainable]) {
        let itemWidth = (bounds.width / CGFloat(items.count))
        for (index, item) in items.enumerated() {
            item.frame = CGRect(x: itemWidth * CGFloat(index), y: 0, width: itemWidth, height: bounds.height)
            let tapgesture = ItemTapGesture(target: self, action: #selector(tappedItem(sender:)))
            tapgesture.indexOfItem = index
            item.addGestureRecognizer(tapgesture)
            addSubview(item)
        }
    }
    func reloadViews() {
        setItems(items: items)
    }
    func addNewItem(item: TopTabBarContainable) {
        items.append(item)
        setItems(items: items)
    }
    func item(at index: Int) -> TopTabBarContainable? {
        return items[index]
    }
    func hideMe(hide: Bool) {
        setHeight(to: hide ? 0 : currentHeight)
    }
    func selectItem(at index: Int) {
        guard items.count > index else { return }
        items[index].selectedState()
        delegate?.didSelect(item: items[index])
    }
    @objc private func tappedItem(sender: ItemTapGesture) {
        guard items.count > sender.indexOfItem else { return }
        for (index, item) in items.enumerated() {
            if index == sender.indexOfItem {
                item.selectedState()
            } else {
                item.unSelectedState()
            }
        }
        delegate?.didSelect(item: items[sender.indexOfItem])
    }
}

class TopTabBarController: UIViewController, TopTabBarDelegate {
    //Public properties
    var tabBar: TopTabBar?
    //Private properties
    private(set) var viewcontrollers: [UIViewController]?
    private var childController: UIViewController?
    private let tabBarDefaultHeight: CGFloat = 120
    private var currentHeight: CGFloat = 120
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar = TopTabBar(frame: CGRect(x: 0, y: 0,
                                         width: view.bounds.width,
                                         height: tabBarDefaultHeight))
        tabBar?.setHeight(to: tabBarDefaultHeight)
        tabBar?.delegate = self
        self.view.addSubview(tabBar!)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tabBar?.frame = CGRect(x: 0, y: 0,
                              width: view.bounds.width,
                              height: currentHeight)
        tabBar?.reloadViews()
    }
    private func addChildController(with viewController: UIViewController?) {
        guard viewController != nil else { return }
        childController = viewController
        let tabbarHeight = (tabBar?.frame.size.height ?? 0) + (tabBar?.frame.origin.y ?? 0)
        childController?.view.frame = CGRect(x: 0,
                                             y: tabbarHeight,
                                             width: view.bounds.width,
                                             height: view.bounds.height - tabbarHeight)
        view.addSubview(childController!.view)
        addChild(childController!)
        childController?.didMove(toParent: self)
    }
    //Tabbar delegate
    func didSelect(item: TopTabBarContainable) {
        guard childController != nil else {
            addChildController(with: item.viewcontroller)
            return
        }
        childController?.willMove(toParent: nil)
        childController?.removeFromParent()
        childController?.view.removeFromSuperview()
        addChildController(with: item.viewcontroller)
    }
    func updatedHeight(to newHeight: CGFloat) {
        let newChildControllerHeight = view.bounds.height - newHeight
        currentHeight = newHeight
        childController?.view.frame = CGRect(x: 0,
                                             y: newHeight,
                                             width: view.bounds.width,
                                             height: newChildControllerHeight)
    }
}
