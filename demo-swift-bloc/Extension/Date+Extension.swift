//
//  Date+Extension.swift
//  demo-swift-bloc
//
//  Created by duy.phan on 18/4/24.
//

import Foundation

extension Date {
    func age(now: Calendar = Calendar.current) -> Int { now.dateComponents([.year], from: self, to: Date()).year! }
}

