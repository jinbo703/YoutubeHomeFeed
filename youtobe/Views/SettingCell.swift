//
//  SettingCell.swift
//  youtobe
//
//  Created by John Nik on 10/20/17.
//  Copyright © 2017 johnik703. All rights reserved.
//

import UIKit

class SettingCell: BaseCell {
    
    override var isHighlighted: Bool {
        didSet {
            
            backgroundColor = isHighlighted ? UIColor.darkGray : UIColor.white
            nameLabel.textColor = isHighlighted ? UIColor.white : UIColor.black
            iconImageView.tintColor = isHighlighted ? UIColor.white : UIColor.darkGray
            
        }
    }
    
    var setting: Setting? {
        didSet {
            
            nameLabel.text = setting?.name.rawValue
            if let iconImageName = setting?.imageName {
                self.iconImageView.image = UIImage(named: iconImageName)?.withRenderingMode(.alwaysTemplate)
                self.iconImageView.tintColor = .darkGray
            }
            
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "setting"
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "success")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(nameLabel)
        addSubview(iconImageView)
        
        addConnstraintsWith(Format: "H:|-16-[v0(30)]-8-[v1]|", views: iconImageView, nameLabel)
        addConnstraintsWith(Format: "V:|[v0]|", views: nameLabel)
        addConnstraintsWith(Format: "V:[v0(30)]", views: iconImageView)
        
        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
    
    
}
