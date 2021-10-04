//
//  PlcaeModel.swift
//  MyPlaces
//
//  Created by Демьян on 02.10.2021.
//

import UIKit

struct Place {
    
    var name: String
    var location: String?
    var type: String?
    var image: UIImage?
    var restaurantImage: String?
    
    
   static let restaurantNames = ["Alaturka", "Yun",  "Mons", "Greegos", "SHUM", "Atalier"]
    
    
    static func getPlaces () -> [Place]{
        
        var places = [Place]()
        
        for place in restaurantNames{
            places.append(Place(name: place, location: "Odessa", type: "Restaurant",image: nil,  restaurantImage: place))
        }
        
        
        return places
    }
    
    
}
