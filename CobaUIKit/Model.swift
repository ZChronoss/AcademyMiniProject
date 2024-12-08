//
//  Model.swift
//  CobaUIKit
//
//  Created by Renaldi Antonio on 15/08/24.
//

import Foundation

struct UsersResponse: Codable {
    let data: [PersonResponse]
}

struct PersonResponse: Codable {
    let email: String
    let firstName: String
    let lastName: String
}
