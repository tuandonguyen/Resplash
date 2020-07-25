//
//  TextField.swift
//  Resplash
//
//  Created by Tuan Nguyen on 7/24/20.
//  Copyright © 2020 Tuan Nguyen. All rights reserved.
//

import UIKit

class TextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        //These are all UITextField properties we can change.
        //corner is the edge.
        layer.cornerRadius = 1
        //border is the border around the edge.
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray6.cgColor
        textColor = .label
        tintColor = .label
        textAlignment = .center
        //dynamic type
        font = UIFont.preferredFont(forTextStyle: .body)
        //font will shrink to fit inside textfield.
        adjustsFontSizeToFitWidth = true
        //stops shrinking font at 12pt font.
        minimumFontSize = 9
        alpha = 0.1
        backgroundColor = .systemGray
        autocorrectionType = .no
        //keyboardType allows keyboard type to be changed.
        returnKeyType = .go
        //adds in 'x' to clear text field.
        clearButtonMode = .whileEditing
        
    }
}
