//
//  ProductCell.swift
//  BlueTracker
//
//  Created by Juan Navarro on 10/3/19.
//  Copyright © 2019 Juan Navarro. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {
    
    var product : Products? {
        didSet {
            productNameLabel.text = product?.productName
            productRSSILabel.text = product?.productRSSI
        }
    }
    private let productNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    
    private var productRSSILabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(productNameLabel)
        addSubview(productRSSILabel)
        
        productNameLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width, height: 0, enableInsets: false)
        productRSSILabel.anchor(top: productNameLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width / 2, height: 0, enableInsets: false)
        
    }
    
   
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
