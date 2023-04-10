//
//  Project: TheVeggie
//  Colors.swift
//
//
//  Created by Jessica Ernst on 02.11.22
//
/// Copyright © 2022 Jessica Ernst. All rights reserved.
//


import Foundation
import SwiftUI

let backgroundGradient = LinearGradient(
    colors: [Color.green.opacity(0.4), Color.yellow.opacity(0.2), Color.orange.opacity(0.2)],
    startPoint: .topLeading, endPoint: .bottomTrailing)

struct CustomColor {
    static let forestGreen = Color("ForestGreen")
    static let lightGray = Color("LightGray")
}
