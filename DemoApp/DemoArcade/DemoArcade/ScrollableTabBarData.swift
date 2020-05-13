//
//  ScrollableTabBarData.swift
//  DemoArcade
//
//  Created by Jonathan Rasmusson Work Pro on 2020-05-03.
//  Copyright © 2020 Rasmusson Software Consulting. All rights reserved.
//

import Foundation

enum Category: Int, CustomStringConvertible, CaseIterable {
    case games = 0
    case music
    case movies
    case books
    case hotels
    case cars
    case shopping
    case restuarants

    var description : String {
      switch self {
      case .games: return "Games"
      case .music: return "Music"
      case .movies: return "Movies"
      case .books: return "Books"
      case .hotels: return "Hotels"
      case .cars: return "Cars"
      case .shopping: return "Shopping"
      case .restuarants: return "Restuarants"
        }
    }
}

struct Offer {
    let name: String
    let category: Category
}

var offers: [Offer] {
    var myOffers: [Offer] = []
    
    myOffers.append(Offer(name: "Pacman", category: .games))
    myOffers.append(Offer(name: "Galaga", category: .games))
    myOffers.append(Offer(name: "Frogger", category: .games))
    
    myOffers.append(Offer(name: "Owner of a Lonely Heart", category: .music))
    myOffers.append(Offer(name: "Tom Sawyer", category: .music))
    myOffers.append(Offer(name: "Hotel California", category: .music))
    
    myOffers.append(Offer(name: "Ready Player1", category: .movies))
    myOffers.append(Offer(name: "Tron", category: .movies))
    myOffers.append(Offer(name: "Aliens", category: .movies))

    myOffers.append(Offer(name: "Fellowship of the Ring", category: .books))
    myOffers.append(Offer(name: "Two Towers", category: .books))
    myOffers.append(Offer(name: "Return of the King", category: .books))

    myOffers.append(Offer(name: "Hilton", category: .hotels))
    myOffers.append(Offer(name: "Flea Bag Inn", category: .hotels))
    myOffers.append(Offer(name: "Mariott", category: .hotels))
    
    myOffers.append(Offer(name: "Model 3", category: .cars))
    myOffers.append(Offer(name: "Model Y", category: .cars))
    myOffers.append(Offer(name: "Model X", category: .cars))

    myOffers.append(Offer(name: "Starcourt Mall", category: .shopping))
    myOffers.append(Offer(name: "Cross Iron Mill", category: .shopping))
    myOffers.append(Offer(name: "Farmers Market", category: .shopping))

    myOffers.append(Offer(name: "Fergus & Bix", category: .restuarants))
    myOffers.append(Offer(name: "A&W", category: .restuarants))
    myOffers.append(Offer(name: "Boston Pizza", category: .restuarants))

    return myOffers
}


