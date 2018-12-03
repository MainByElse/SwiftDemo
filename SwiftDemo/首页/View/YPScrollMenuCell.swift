//
//  YPScrollMenuCell.swift
//  SwiftDemo
//
//  Created by Else丶 on 2018/10/2.
//  Copyright © 2018 Else丶. All rights reserved.
//

import UIKit

class YPScrollMenuCell: UITableViewCell {

    let itemWH = (ScreenWidth-3)/4.0
    let itemSum = 9
    
    var _colView:UICollectionView?
    @IBOutlet weak var colView: UICollectionView!
//        {
//        didSet{
//            _colView = colView
//            _colView?.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenWidth)
//        }
//    }
    
//    private func configIdentifier(_ identifier: inout String) -> String {
//        var index = identifier.index(of: ".")
//        guard index != nil else { return identifier }
//        index = identifier.index(index!, offsetBy: 1)
//        identifier = String(identifier[index! ..< identifier.endIndex])
//        return identifier
//    }
//    public func cellWithTableView<T: YPScrollMenuCell>(_ tableView: UITableView) -> T {
//        var identifier = NSStringFromClass(T.self)
//        identifier = configIdentifier(&identifier)
//        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
//        if cell == nil {
//            cell = Bundle.main.loadNibNamed("YPScrollMenuCell", owner: nil, options: nil)?.last as! YPScrollMenuCell
//        }
//        return cell as! T
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        self.colView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenWidth)
        self.colView.backgroundColor = UIColor.orange
        self.colView.delegate = self as UICollectionViewDelegate
        self.colView.dataSource = self as UICollectionViewDataSource
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemWH, height: itemWH)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        
        self.colView.collectionViewLayout = layout
        
        self.colView.register(UINib.init(nibName: "YPScrollMenuColCell", bundle: nil), forCellWithReuseIdentifier: "YPScrollMenuColCell")
        
        self.colView.snp.updateConstraints { (make) in
            make.height.equalTo(itemWH*3.0)
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension YPScrollMenuCell : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemSum
    }
    
//    func collectionView(_ collectionView: UICollectionView, transitionLayoutForOldLayout fromLayout: UICollectionViewLayout, newLayout toLayout: UICollectionViewLayout) -> UICollectionViewTransitionLayout {
//        var layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: (ScreenWidth-3)/4.0, height: (ScreenWidth-3)/4.0)
//        layout.minimumLineSpacing = 1
//        layout.minimumInteritemSpacing = 1
//        return layout
//    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: YPScrollMenuColCell = collectionView.dequeueReusableCell(withReuseIdentifier: "YPScrollMenuColCell", for: indexPath) as! YPScrollMenuColCell
        cell.iconImgV.image = UIImage.init(named: "占位")
        cell.titleLabel.text = String(indexPath.item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
}

