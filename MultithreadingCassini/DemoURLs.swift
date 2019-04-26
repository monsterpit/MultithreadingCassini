//
//  DemoURLs.swift
//  Cassini
//
//  Created by Boppo on 25/04/19.
//  Copyright © 2019 MB. All rights reserved.
//

import Foundation

struct DemoURLs{
    
    static let standford = Bundle.main.url(forResource: "oval", withExtension: "jpg")
    
    static let standfordNetwork = URL(string: "https://upload.wikimedia.org/wikipedia/commons/5/55/Stanford_Oval_September_2013_panorama.jpg")
    
    static var NASA : Dictionary<String,URL> = {
        let NASAURLStrings = [
            "Cassini" : "https://www.jpl.nasa.gov/images/cassini/20090202/pia03883-full.jpg",
            "Earth" : "https://www.nasa.gov/sites/default/files/wave_earth_mosaic_3.jpg",
            "Saturn" : "https://www.nasa.gov/sites/default/files/saturn_collage.jpg"
        ]
        var urls = [String:URL]()
        for (key,value) in NASAURLStrings {
            urls[key] = URL(string: value)
        }
        return urls
    }()
}
