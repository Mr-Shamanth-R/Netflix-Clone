//
//  Extensions.swift
//  Netflix-Clone
//
//  Created by Shamanth R on 19/04/25.
//

import Foundation

extension String {
    func captializeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
