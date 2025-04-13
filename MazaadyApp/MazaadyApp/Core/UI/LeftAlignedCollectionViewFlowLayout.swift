//
//  LeftAlignedCollectionViewFlowLayout.swift
//  MazaadyApp
//
//  Created by asmaa badreldin on 13/04/2025.
//

import UIKit

final class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)

        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0

        attributes?.forEach {
            if $0.representedElementCategory == .cell {
                if $0.frame.origin.y >= maxY {
                    leftMargin = sectionInset.left
                }
                $0.frame.origin.x = leftMargin
                leftMargin += $0.frame.width + minimumInteritemSpacing
                maxY = max($0.frame.maxY, maxY)
            }
        }

        return attributes
    }
}
