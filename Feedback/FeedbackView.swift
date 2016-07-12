//
//  FeedbackView.swift
//  Feedback
//
//  Created by Dylan Gyesbreghs on 12/07/16.
//  Copyright © 2016 Dylan Gyesbreghs. All rights reserved.
//

import UIKit
import PureLayout

class FeedbackView: UIView {
    private var badView = FeedbackSubview.newAutoLayoutView()
    private var okayView = FeedbackSubview.newAutoLayoutView()
    private var goodView = FeedbackSubview.newAutoLayoutView()
    private var greatView = FeedbackSubview.newAutoLayoutView()
    private var moveView = FeedbackMoveView.newAutoLayoutView()
    private var lineView = UIView.newAutoLayoutView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        setupConstraint()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraint()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupView() {
        addSubview(badView)
        addSubview(okayView)
        addSubview(goodView)
        addSubview(greatView)
        addSubview(lineView)
        addSubview(moveView)
        
        badView.datasource = self
        okayView.datasource = self
        goodView.datasource = self
        greatView.datasource = self
        
        moveView.logoImageView.backgroundColor = UIColor.brownColor()
        
        badView.setupView(withType: .Bad)
        okayView.setupView(withType: .Okay)
        goodView.setupView(withType: .Good)
        greatView.setupView(withType: .Great)
        
        lineView.backgroundColor = UIColor.grayColor()
        sendSubviewToBack(lineView)
    }
    
    func setupConstraint() {
        
        moveView.autoMatchDimension(.Height, toDimension: .Height, ofView: okayView)
        moveView.autoMatchDimension(.Width, toDimension: .Width, ofView: okayView)
        moveView.autoPinEdgeToSuperviewEdge(.Top)
        moveView.autoPinEdgeToSuperviewEdge(.Bottom)
        moveView.autoPinEdgeToSuperviewEdge(.Left)
        
        // BadView
        badView.autoMatchDimension(.Height, toDimension: .Height, ofView: okayView)
        badView.autoMatchDimension(.Width, toDimension: .Width, ofView: okayView)
        badView.autoPinEdgeToSuperviewEdge(.Top)
        badView.autoPinEdgeToSuperviewEdge(.Bottom)
        badView.autoPinEdgeToSuperviewEdge(.Left)
        
        // OkayView
        okayView.autoMatchDimension(.Height, toDimension: .Height, ofView: goodView)
        okayView.autoMatchDimension(.Width, toDimension: .Width, ofView: goodView)
        okayView.autoPinEdgeToSuperviewEdge(.Top)
        okayView.autoPinEdgeToSuperviewEdge(.Bottom)
        okayView.autoPinEdge(.Left, toEdge: .Right, ofView: badView)
        
        // GoodView
        goodView.autoMatchDimension(.Height, toDimension: .Height, ofView: greatView)
        goodView.autoMatchDimension(.Width, toDimension: .Width, ofView: greatView)
        goodView.autoPinEdgeToSuperviewEdge(.Top)
        goodView.autoPinEdgeToSuperviewEdge(.Bottom)
        goodView.autoPinEdge(.Left, toEdge: .Right, ofView: okayView)
        
        // GreatView
        greatView.autoPinEdgeToSuperviewEdge(.Top)
        greatView.autoPinEdgeToSuperviewEdge(.Bottom)
        greatView.autoPinEdgeToSuperviewEdge(.Right)
        greatView.autoPinEdge(.Left, toEdge: .Right, ofView: goodView)
        
        // LineView
        lineView.autoPinEdge(.Left, toEdge: .Left, ofView: badView.logoImageView)
        lineView.autoPinEdge(.Right, toEdge: .Right, ofView: greatView.logoImageView)
        lineView.autoSetDimension(.Height, toSize: 5)
        lineView.autoAlignAxisToSuperviewAxis(.Horizontal)
    }
}

extension FeedbackView : FeedbackSubViewDatasource {
    func image(forType type: FeedbackSubviewType) -> UIImage {
        switch type {
        case .Bad:
            return UIImage()
        case .Okay:
            return UIImage()
        case .Good:
            return UIImage()
        case .Great:
            return UIImage()
        }
    }
    
    func title(forType type: FeedbackSubviewType) -> String {
        switch type {
        case .Bad:
            return "Bad"
        case .Okay:
            return "Okay"
        case .Good:
            return "Good"
        case .Great:
            return "Great"
        }
    }
}
