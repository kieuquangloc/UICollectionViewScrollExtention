//
//  UICollectionView.swift
//  UICollectionViewScrollExtention
//
//  Created by QuangLoc on 5/26/20.
//  Copyright © 2020 kieuquangloc. All rights reserved.
//

import UIKit

typealias SwagScrollCallback = (_ finish: Bool) -> Void

class UICollectionViewBase: NSObject, UICollectionViewDelegate {
    static var shared = UICollectionViewBase()
    
    var tempDelegate: UIScrollViewDelegate?
    var callback: SwagScrollCallback?
    
    func startCheckScrollAnimation(scroll: UIScrollView, callback: SwagScrollCallback?){
        if let dele = scroll.delegate {
            self.tempDelegate = dele
        }
        self.callback = callback
        scroll.delegate = self
    }
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        callback?(true)
        if let dele = self.tempDelegate {
            scrollView.delegate = dele
            tempDelegate = nil
        }
    }
}

extension UICollectionView {
    
    func scrollToItem(at indexPath: IndexPath, at scrollPosition: UICollectionView.ScrollPosition, _ callback: SwagScrollCallback?){
        UICollectionViewBase.shared.startCheckScrollAnimation(scroll: self, callback: callback)
        self.scrollToItem(at: indexPath, at: scrollPosition, animated: true)
    }
    
}

