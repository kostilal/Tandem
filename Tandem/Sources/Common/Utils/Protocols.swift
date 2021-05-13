//
//  Constants.swift
//  Tandem
//
//  Created by Илья Костюкевич on 13.05.2021.
//

import Foundation

public protocol ConfigurableView {
    associatedtype Data

    func configure(with data: Data)
}

protocol BasePresenterProtocol: class {
    func onViewDidLoad()
}
