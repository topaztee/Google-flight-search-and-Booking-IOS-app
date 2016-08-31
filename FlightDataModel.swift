//
//  FlightDataModel.swift
//  Assignment2_UG
//
//  Created by topaz t on 6/05/2015.
//  Copyright (c) 2015 topaz turkenitz. All rights reserved.
//

import Foundation

class FlightDataModel {
    var carrier: String
    var price: String
    
    //override var description: String {
    //    return "carrier: \(carrier), price: \(price)\n"
    //}
    
    init(carrier: String?, price: String?) {
        self.carrier = carrier! 
        self.price = price!
    }
}