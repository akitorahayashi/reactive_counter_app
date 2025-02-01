//
//  RCVibrator.swift
//  reactive_counter_app
//
//  Created by 林 明虎 on 2025/01/13.
//

import UIKit

class RCVibrator {
    static func vibrate() {
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
        feedbackGenerator.prepare()
        feedbackGenerator.impactOccurred()
    }
}
