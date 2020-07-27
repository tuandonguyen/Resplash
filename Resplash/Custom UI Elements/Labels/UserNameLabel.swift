//
//  UserNameLabel.swift
//  Resplash
//
//  Created by Tuan Nguyen on 7/24/20.
//  Copyright © 2020 Tuan Nguyen. All rights reserved.
//

import UIKit

class UserNameLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //to call: myLabel = UserNameLabel(textAlignment: .left, fontSize: 8)
    convenience init(textAlignment: NSTextAlignment) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
    }
    
    private func configure() {
        font = UIFont.preferredFont(forTextStyle: .subheadline)
        textColor = .label
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
}
