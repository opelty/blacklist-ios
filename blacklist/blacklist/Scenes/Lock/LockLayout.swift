//
//  LockLayout.swift
//  blacklist
//
//  Created by Santiago Carmona Gonzalez on 3/6/18.
//  Copyright © 2018 Opelty's Open Source Projects. All rights reserved.
//

import UIKit

class LockLayout: UICollectionViewLayout {

    private var numberOfColumns = 3
    private var numberOfRows: CGFloat = 4
    private var cellPadding: CGFloat = 10

    // cache of attributes.
    private var cache = [UICollectionViewLayoutAttributes]()

    private var contentHeight: CGFloat = 0

    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }

    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }

    override func prepare() {

        guard cache.isEmpty, let collectionView = collectionView else {
            return
        }

        // Pre-Calculates the X Offset for every column and adds an array to increment the currently max Y Offset for each column
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        var xOffset = [CGFloat]()
        for column in 0 ..< numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth)
        }
        var column = 0
        var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)

        // Iterates through the list of items in the first section
        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {

            let indexPath = IndexPath(item: item, section: 0)

            // Calculates cell frame
            let buttonHeight: CGFloat = collectionView.frame.height / numberOfRows
            let height = buttonHeight - 2 * cellPadding

            var frame: CGRect!

            // looks if is the last item to center it
            if item == collectionView.numberOfItems(inSection: 0) - 1 {
                frame = CGRect(x: xOffset[1], y: yOffset[column], width: columnWidth, height: height)
            } else {
                frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
            }

            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)

            // Creates an UICollectionViewLayoutItem with the frame and add it to the cache
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)

            // Updates the collection view content height
            contentHeight = max(contentHeight, frame.maxY)
            yOffset[column] = yOffset[column] + height

            column = column < (numberOfColumns - 1) ? (column + 1) : 0
        }
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {

        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()

        // Loop through the cache and look for items in the rect
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
}
