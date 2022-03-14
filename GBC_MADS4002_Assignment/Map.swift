//
//  Map.swift
//  GBC_MADS4002_Assignment
//
//  Created by Samarth Joshi on 2022-03-04.
//

import Foundation
class Map {

    
    // -Stored Properties
    let currentLocation: Location
    let roadsLeadingOut: [Road]
    var nextMapNode: Map?
    
    // -Declaring the default intializer
    init(currentLocation: Location, roadsLeadingOut: [Road]) {
        self.currentLocation = currentLocation
        self.roadsLeadingOut = roadsLeadingOut
        self.nextMapNode = nil;
    }
}
// -providing a custom respresentation of the instance to string
// equivalent of toString() in Java
extension Map: CustomStringConvertible {
    var description: String {
//        get {
//            return "\(self.currentLocation) \nNext Map Node: \(String(describing: self.nextMapNode))\n"
//        }
        get {
            return "\(self.currentLocation) \nroadsLeadingOut: \(self.roadsLeadingOut)\n"
        }
    }
}
