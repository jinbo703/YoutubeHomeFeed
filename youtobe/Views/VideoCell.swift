//
//  VideoCell.swift
//  youtobe
//
//  Created by John Nik on 10/10/17.
//  Copyright © 2017 johnik703. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    @objc func setupViews() {
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class VideoCell: BaseCell {
    
    @objc var video: Video? {
        didSet {
            
            setupThumbnailImage()
            setupProfileImage()
            
            if let title = video?.title {
                titleLabel.text = title
                
                let size = CGSize(width: frame.width - 15 - 44 - 9 - 16, height: 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)], context: nil)
                if estimatedRect.size.height > 20 {
                    titleLabelHeightConstraint?.constant = 44
                } else {
                    titleLabelHeightConstraint?.constant = 20
                }
                
            }
            
            
            
            if let channelName = video?.channel?.name, let numberOfViews = video?.number_of_views {
                
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                let viewsString = numberFormatter.string(from: numberOfViews)! as String
                
                let subTitleText = "\(channelName) - \(viewsString) - 2 years agao"
                
                subTitleTextView.text = subTitleText
            }
            
            
            
        }
    }
    
    @objc func setupProfileImage() {
        if let profileImageName = video?.channel?.profile_image_name {
            
            userProfileImageView.loadImageUsingUrlString(urlString: profileImageName)
        }
    }
    
    @objc func setupThumbnailImage() {
        if let thumbnailImageUrl = video?.thumbnail_image_name {
            thumbnailImageView.loadImageUsingUrlString(urlString: thumbnailImageUrl)
        }
    }
    
    @objc let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return view
    }()
    
    @objc let thumbnailImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.image = UIImage(named: "images (11)")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView 
    }()
    
    @objc let userProfileImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.image = UIImage(named: "images (3)")
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    @objc let titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    @objc let subTitleTextView: UITextView = {
        let tv = UITextView()
        tv.text = ""
        tv.isUserInteractionEnabled = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        tv.textColor = .gray
        return tv
    }()
    
    @objc var titleLabelHeightConstraint: NSLayoutConstraint?
    
    override func setupViews() {
        
        super.setupViews()
        
        addSubview(thumbnailImageView)
        addSubview(seperatorView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subTitleTextView)
        
        addConnstraintsWith(Format: "H:|-16-[v0]-16-|", views: thumbnailImageView)
        addConnstraintsWith(Format: "H:|[v0]|", views: seperatorView)
        addConnstraintsWith(Format: "H:|-16-[v0(44)]", views: userProfileImageView)
        
        addConnstraintsWith(Format: "V:|-16-[v0]-8-[v1(44)]-38-[v2(1)]|", views: thumbnailImageView, userProfileImageView, seperatorView)
        
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
        
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        
        titleLabelHeightConstraint = NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 44)
        addConstraint(titleLabelHeightConstraint!)
        
        
        addConstraint(NSLayoutConstraint(item: subTitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 8))
        
        addConstraint(NSLayoutConstraint(item: subTitleTextView, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 4))
        addConstraint(NSLayoutConstraint(item: subTitleTextView, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: subTitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
        
    }
}
