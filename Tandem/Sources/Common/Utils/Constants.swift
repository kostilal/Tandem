//
//  Constants.swift
//  Tandem
//
//  Created by Илья Костюкевич on 13.05.2021.
//

import UIKit

enum Constants {
    enum Durations {
        static let loadingBlurEffect: CGFloat = 0.3
        static let blurEffectPropertyAnimatorDuration: TimeInterval = 1
        static let timerTimeInterval: TimeInterval = 60
    }
    
    enum API {
        static let baseUrl = "https://jsonplaceholder.typicode.com"
        static let albums = "/albums"
        static let photos = "/photos"
    }
}
