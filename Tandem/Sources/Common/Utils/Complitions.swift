//
//  Constants.swift
//  Tandem
//
//  Created by Илья Костюкевич on 13.05.2021.
//

import Foundation

typealias EmptyCompletion = () -> ()
typealias Completion<T> = (T) -> ()

func async(completion: @escaping () -> Void) {
    DispatchQueue.main.async {
        completion()
    }
}

func delay(seconds: Double, completion: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
        completion()
    }
}
