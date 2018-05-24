//
//  TempAdjFormula.swift
//  GravityMeter
//
//  Created by Alexey Gain on 5/18/18.
//  Copyright © 2018 Alexey Gain. All rights reserved.
//

import Foundation

func sgRatio(temp: Double) -> Double {
    let sgRatio = 1.00130346 - 0.000134722124 * temp + 0.00000204052596 * temp * temp - 0.00000000232820948 * temp * temp * temp
    return sgRatio
}
