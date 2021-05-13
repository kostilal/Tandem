//
//  Album.swift
//  Tandem
//
//  Created by Илья Костюкевич on 13.05.2021.
//

import Foundation

struct Album: Decodable {
    let id: Int
    let userId: Int
    let title: String
}
