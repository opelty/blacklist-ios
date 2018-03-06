//
//  CircleLockLayout.swift
//  blacklist
//
//  Created by Santiago Carmona Gonzalez on 3/6/18.
//  Copyright © 2018 Opelty's Open Source Projects. All rights reserved.
//

import UIKit

class CircleLockLayout: UICollectionViewLayout {

    // MARK: - Vars & Constants

    private var center: CGPoint!
    private var itemSize: CGSize!
    private var radius: CGFloat!
    private var numberOfItems: Int!

    override var collectionViewContentSize: CGSize {
        return collectionView!.bounds.size
    }

    override func prepare() {
        super.prepare()

        guard let collectionView = collectionView else {
            return
        }

        center = CGPoint(x: collectionView.bounds.midX, y: collectionView.bounds.midY)

        let shortestAxisLength = min(collectionView.bounds.width, collectionView.bounds.height)

        itemSize = CGSize(width: shortestAxisLength * 0.2, height: shortestAxisLength * 0.2)
        radius = shortestAxisLength * 0.3
        numberOfItems = collectionView.numberOfItems(inSection: 0)
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)

        let angle = 2 * .pi * CGFloat(indexPath.item) / CGFloat(numberOfItems)

        attributes.center = CGPoint(x: center.x + radius * cos(angle), y: center.y + radius * sin(angle))
        attributes.size = itemSize

        return attributes
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return (0 ..< collectionView!.numberOfItems(inSection: 0)).flatMap { item -> UICollectionViewLayoutAttributes? in
            self.layoutAttributesForItem(at: IndexPath(item: item, section: 0))
        }
    }
}
