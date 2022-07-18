//
//  ViewModel.swift
//  easyplay1
//
//  Created by jrasmusson on 2022-07-18.
//

import Foundation

class ViewModel: ObservableObject {
    var foodItems: [FoodItem] = load("foodData.json")
}
