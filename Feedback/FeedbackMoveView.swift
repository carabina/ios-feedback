//
//  FeedbackMoveView.swift
//  Feedback
//
//  Created by Dylan Gyesbreghs on 12/07/16.
//  Copyright © 2016 Dylan Gyesbreghs. All rights reserved.
//

import UIKit

class FeedbackMoveView: FeedbackSubview {

    override func setupView() {
        super.setupView()
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(FeedbackMoveView.drag(_:)))
        addGestureRecognizer(gesture)
    }
    func drag(panGestureRecognizer:UIPanGestureRecognizer) {
        let touchlocation = panGestureRecognizer.locationInView(superview)
        if touchlocation.x >= 40 {
            center.x = touchlocation.x
        }
    }
}
