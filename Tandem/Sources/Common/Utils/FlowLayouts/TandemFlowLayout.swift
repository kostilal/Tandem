//
//  TandemFlowLayout.swift
//  Tandem
//
//  Created by Ilya Kostyukevich on 14.05.2021.
//

import UIKit

class TandemFlowLayout: UICollectionViewFlowLayout {
    private let spacing: CGFloat = 10
    private let estimatedItemHeight: CGFloat = 100
    private var cache = [IndexPath: UICollectionViewLayoutAttributes]()
    private var maxYPos: CGFloat = 0
    private var itemWidth: CGFloat = 0
    
    override func prepare() {
        guard let collectionView = self.collectionView, cache.isEmpty else { return }
        let section = 0
        
        for i in 0..<collectionView.numberOfItems(inSection: section) {
            let indexPath = IndexPath(row: i, section: section)
            let itemAttributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            itemAttributes.frame = frameForItemAtIndexPath(indexPath)
            if itemAttributes.frame.origin.y > maxYPos {
                maxYPos = itemAttributes.frame.origin.y
            }
            
            cache[indexPath] = itemAttributes
        }
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath]
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributes = [UICollectionViewLayoutAttributes]()
        
        cache.forEach { (attribute) in
            if rect.intersects(attribute.value.frame) {
                attributes.append(attribute.value)
            }
        }
      
        return attributes
    }

    override var collectionViewContentSize: CGSize {
        guard let collectionView = self.collectionView else { return .zero }
        let contentHeight: CGFloat = maxYPos + itemWidth
      
        return CGSize(width: collectionView.frame.width, height: contentHeight)
    }
}

private extension TandemFlowLayout {
    func frameForItemAtIndexPath(_ indexPath: IndexPath) -> CGRect {
        guard let collectionView = self.collectionView else { return .zero }
        
        let maxWidth = collectionView.frame.width
        let numRows = floor(maxWidth / estimatedItemHeight)
        
        let currentColumn = floor(CGFloat(indexPath.row) / numRows)
        let currentRow = CGFloat(indexPath.row).truncatingRemainder(dividingBy: numRows)
        
        itemWidth = maxWidth / numRows
        let xPos = currentRow * itemWidth
        let yPos = currentColumn * itemWidth

        return CGRect(x: xPos, y: yPos, width: itemWidth, height: itemWidth)
    }
}
