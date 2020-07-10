//
//  Farmacia.swift
//  farmapp
//
//  Created by Fede Beron on 09/07/2020.
//  Copyright © 2020 Fede Beron. All rights reserved.
//

import UIKit

struct Farmacia: Codable {

    let name: String?
    let img: String?
    let lat: String?
    let lng: String?
    let address: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case img
        case lat
        case lng
        case address
    }
}


