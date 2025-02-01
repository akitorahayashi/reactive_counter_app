//
//  RCNavigationBarTitle.swift
//  reactive_counter_app
//
//  Created by 林 明虎 on 2025/01/12.
//

import UIKit

class RCNavigationBarTitle: UILabel {
    init(title: String) {
        super.init(frame: .zero)
        setupUI(title: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(title: String) {
        text = title
        font = UIFont.systemFont(ofSize: 20, weight: .bold)
        textAlignment = .center
        textColor = .accent
    }
}
