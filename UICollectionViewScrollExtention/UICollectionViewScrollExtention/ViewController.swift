//
//  ViewController.swift
//  UICollectionViewScrollExtention
//
//  Created by QuangLoc on 5/26/20.
//  Copyright © 2020 kieuquangloc. All rights reserved.
//

import UIKit

class MyCell: UICollectionViewCell {
    @IBOutlet weak var lbl: UILabel!
}

class ViewController: UIViewController {
    
    @IBOutlet weak var clv: UICollectionView!
    
    var items = 100

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.clv.delegate = self
        self.clv.dataSource = self
    }
    
    
    @IBAction func onBtnShow(){
        print("onBtnShow")
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        
        let index = IndexPath.init(item: 58, section: 0)
        self.clv.scrollToItem(at: index, at: .centeredVertically) { [weak self] (finish) in
            
            guard let `self` = self else { return }
            
            // Change color temporarily
            if let cell = self.clv.cellForItem(at: index) as? MyCell {
                cell.backgroundColor = .yellow
                cell.lbl.textColor = .red
            }
            
            
            // Reset
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.clv.reloadData()
            }
        }
    }


}

extension ViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    func setupCollection(){
        self.clv.delegate = self
        self.clv.dataSource = self
        self.clv.reloadData()
        self.clv.contentInsetAdjustmentBehavior = .never
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 100, height: 100)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! MyCell
        cell.backgroundColor = .red
        cell.lbl.text = "\(indexPath.row)"
        cell.lbl.textAlignment = .center
        return cell
    }

}
