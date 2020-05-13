//
//  WIFIController.swift
//  DemoArcade
//
//  Created by Jonathan Rasmusson Work Pro on 2020-04-07.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

/*
Abstract:
   Controller object which notifies our application when availalbe Wi-Fi APs are available
*/

import Foundation

class WIFIController {

    private let allNetworks = [ Network(name: "AirSpace1"),
                                Network(name: "Living Room"),
                                Network(name: "Courage"),
                                Network(name: "Nacho WiFi"),
                                Network(name: "FBI Surveillance Van"),
                                Network(name: "Peacock-Swagger"),
                                Network(name: "GingerGymnist"),
                                Network(name: "Second Floor"),
                                Network(name: "Evergreen"),
                                Network(name: "__hidden_in_plain__sight__"),
                                Network(name: "MarketingDropBox"),
                                Network(name: "HamiltonVille"),
                                Network(name: "404NotFound"),
                                Network(name: "SNAGVille"),
                                Network(name: "Overland101"),
                                Network(name: "TheRoomWiFi"),
                                Network(name: "PrivateSpace")
    ]

    private var _availableNetworks = Set<Network>()
    var availableNetworks: Set<Network> {
        return _availableNetworks
    }

    typealias UpdateHandler = (WIFIController) -> Void
    private let updateHandler: UpdateHandler
    
    init(updateHandler: @escaping UpdateHandler) {
        self.updateHandler = updateHandler
        updateAvailableNetworks(allNetworks)
        performRandomUpdate()
    }

    private func updateAvailableNetworks(_ networks: [Network]) {
        _availableNetworks = Set<Network> (networks)
    }

    private func performRandomUpdate() {
        var updatedNetworks = Array(_availableNetworks)
        
        if updatedNetworks.isEmpty {
            _availableNetworks = Set<Network>(allNetworks)
        } else {
            randomlyRemove(from: &updatedNetworks)
            randomlyAdd(from: &updatedNetworks)
            updateAvailableNetworks(updatedNetworks)
            
            updateHandler(self) // notify
        }
        
        let deadline = DispatchTime.now() + DispatchTimeInterval.milliseconds(1000)
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            self.performRandomUpdate()
        }
    }
    
    private func randomlyRemove(from updatedNetworks: inout [Network]) {
        let shouldRemove = Int.random(in: 0..<3) == 0
        if shouldRemove {
            let removeCount = Int.random(in: 0..<updatedNetworks.count)
            for _ in 0..<removeCount {
                let removeIndex = Int.random(in: 0..<updatedNetworks.count)
                updatedNetworks.remove(at: removeIndex)
            }
        }
    }
    
    private func randomlyAdd(from updatedNetworks: inout [Network]) {
        let shouldAdd = Int.random(in: 0..<3) == 0
        if shouldAdd {
            let allNetworksSet = Set<Network>(allNetworks)
            var updatedNetworksSet = Set<Network>(updatedNetworks)
            let notPresentNetworksSet = allNetworksSet.subtracting(updatedNetworksSet)
            
            if !notPresentNetworksSet.isEmpty {
                let addCount = Int.random(in: 0..<notPresentNetworksSet.count)
                var notPresentNetworks = [Network](notPresentNetworksSet)
                
                for _ in 0..<addCount {
                    let removeIndex = Int.random(in: 0..<notPresentNetworks.count)
                    let networkToAdd = notPresentNetworks[removeIndex]
                    notPresentNetworks.remove(at: removeIndex)
                    updatedNetworksSet.insert(networkToAdd)
                }
            }
            updatedNetworks = [Network](updatedNetworksSet)
        }
    }
}

