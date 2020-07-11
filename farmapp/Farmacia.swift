//
//  Farmacia.swift
//  farmapp
//
//  Created by Fede Beron on 09/07/2020.
//  Copyright © 2020 Fede Beron. All rights reserved.
//

import UIKit

struct Farmacia: Codable {

    var name: String?
    var img: String?
    var lat: Double?
    var lng: Double?
    var address: String?
    var phoneNumber: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case img
        case lat
        case lng
        case address
        case phoneNumber
    }
}


