//
//  LAMStation.swift
//  TrafficInfo
//
//  Created by Tuukka Tallgren on 20/10/15.
//  Copyright © 2015 omenafarmari. All rights reserved.
//

import UIKit
import RealmSwift

class LAMStation: Object {

    dynamic var tsa_number = ""
    dynamic var lam_station_id = ""
    dynamic var tsa_name = "asema"
    dynamic var name_fi = "station"
    dynamic var name_se = "station"
    dynamic var name_en = "station"
    dynamic var road = ""
    dynamic var road_part = ""
    dynamic var distance = ""
    dynamic var tsa_cord_y = ""
    dynamic var tsa_cord_x = ""
    dynamic var tsa_height = ""
    dynamic var county = "uusimaa"
    dynamic var lat = ""
    dynamic var lat_min = ""
    dynamic var lat_sec = ""
    dynamic var long_dec = ""
    dynamic var long_min = ""
    dynamic var long_sec = ""

}
