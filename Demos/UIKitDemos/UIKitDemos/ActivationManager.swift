//
//  ActivationManager.swift
//  UIKitDemos
//
//  Created by Jonathan Rasmusson (Contractor) on 2020-01-27.
//  Copyright © 2020 Jonathan Rasmusson. All rights reserved.
//

enum ActivationError: Error {
    case failure
}

struct ActivationManager {

    static func activateAndPoll(completion: @escaping (Result<Void, Error>) -> Void) {
        // comment in to simulate different functionality
        //        completion(Result.success(()))
        completion(Result.failure(ActivationError.failure))
    }

}
