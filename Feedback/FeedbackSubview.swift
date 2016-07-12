//
//  FeedbackSubview.swift
//  Feedback
//
//  Created by Dylan Gyesbreghs on 12/07/16.
//  Copyright © 2016 Dylan Gyesbreghs. All rights reserved.
//

import UIKit
import PureLayout

enum FeedbackSubviewType {
    case Bad
    case Okay
    case Good
    case Great
}

protocol FeedbackSubViewDatasource {
    func title(forType type : FeedbackSubviewType) -> String
    func image(forType type : FeedbackSubviewType) -> UIImage
}

class FeedbackSubview: UIView {
    var datasource : FeedbackSubViewDatasource?
    
    var itemLabel = UILabel.newAutoLayoutView()
    var logoImageView = UIImageView.newAutoLayoutView()
    
    private var heightConstraint : NSLayoutConstraint?
    private var widthConstraint : NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraint()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupView() {
        addSubview(itemLabel)
        addSubview(logoImageView)
        
        logoImageView.layer.cornerRadius = 49 / 2
        logoImageView.layer.masksToBounds = true
        logoImageView.backgroundColor = UIColor.cyanColor()
    }
    
    func setupView(withType type : FeedbackSubviewType) {
        if let datasource = datasource {
            itemLabel.text = datasource.title(forType: type)
            logoImageView.image = datasource.image(forType: type)
        }
    }
    
    func setupConstraint() {
        heightConstraint = logoImageView.autoSetDimension(.Height, toSize: 49)
        widthConstraint = logoImageView.autoSetDimension(.Width, toSize: 49)
        logoImageView.autoAlignAxisToSuperviewAxis(.Horizontal)
        logoImageView.autoAlignAxisToSuperviewAxis(.Vertical)
        
        itemLabel.autoAlignAxis(.Vertical, toSameAxisOfView: logoImageView)
        itemLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: logoImageView, withOffset: 12)
    }
}
