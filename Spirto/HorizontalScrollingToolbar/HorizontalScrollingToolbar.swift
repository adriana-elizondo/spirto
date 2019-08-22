//
//  HorizontalScrollingToolbar.swift
//  Spirto
//
//  Created by Adriana Elizondo on 2019/7/29.
//  Copyright © 2019 adriana. All rights reserved.
//

import Foundation
import UIKit

public typealias SToolbarItem = (title: String, reuseIdentifier: String)
public typealias CellData = (nibName: String, reuseIdentifier: String)

protocol ScrollingToolBarHandler: class {
    func didTap(item: SToolbarItem)
}

class HorizontalScrollingToolbar: UIView {
    private lazy var itemsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10.0
        layout.minimumLineSpacing = 10.0
        let collection = UICollectionView(frame:
            CGRect(x: 0, y: 0, width: frame.size.width,
                   height: frame.size.height), collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        collection.isScrollEnabled = true
        collection.dataSource = self
        collection.delegate = self
        return collection
    }()
    private var items = [SToolbarItem]()
    private var elementWidth: CGFloat = 0
    private var cellData = [CellData]()
    private weak var handler: ScrollingToolBarHandler?
    func loadData(with items: [SToolbarItem], cellData: [CellData],
                  handler: ScrollingToolBarHandler?, width: CGFloat? = 100) {
        self.items = items
        self.elementWidth = width ?? 0
        self.cellData = cellData
        self.handler = handler
        backgroundColor = UIColor.clear
        registerCells()
    }
    func setCollectionViewBgcolor(color: UIColor) {
        itemsCollectionView.backgroundColor = color
    }
    private func registerCells() {
        for item in cellData {
            itemsCollectionView.register(UINib(nibName: item.nibName, bundle: nil),
                                         forCellWithReuseIdentifier: item.reuseIdentifier)
        }
        itemsCollectionView.reloadData()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubview(itemsCollectionView)
    }
}
protocol HorizontalScrollbarContainable where Self: UICollectionViewCell {
    func setup(with title: String)
}
extension HorizontalScrollingToolbar: UICollectionViewDataSource,
UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = items[indexPath.row]
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
            item.reuseIdentifier, for: indexPath) as? HorizontalScrollbarContainable {
            cell.setup(with: items[indexPath.row].title)
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat(elementWidth), height: bounds.size.height)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset = (collectionView.bounds.size.width / 2.0) - (elementWidth / 2.0)
        return UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
    }
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        selectCell(at: indexPath)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offsetx = scrollView.center.x + scrollView.contentOffset.x
        if let indexpath = itemsCollectionView.indexPathForItem(at: CGPoint(x: offsetx, y: 0)) {
            selectCell(at: indexpath)
        }
    }
    private func selectCell(at indexpath: IndexPath) {
        itemsCollectionView.scrollToItem(at: indexpath, at: .centeredHorizontally, animated: true)
        UISelectionFeedbackGenerator().selectionChanged()
        handler?.didTap(item: items[indexpath.row])
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
