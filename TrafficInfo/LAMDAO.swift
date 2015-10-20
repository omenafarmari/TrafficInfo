//
//  LAMDAO.swift
//  TrafficInfo
//
//  Created by Tuukka Tallgren on 20/10/15.
//  Copyright © 2015 omenafarmari. All rights reserved.
//

import UIKit
import RealmSwift
import CSwiftV

class LAMDAO: Object {
    
    func saveLAMStation (lamStation: LAMStation) {
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(lamStation)
        }
        
    }
    
    func saveMultipleLAMStations(lamStations: [LAMStation]) {
        for lamStation in lamStations {
            self.saveLAMStation(lamStation)
        }
    }
    
    func getLAMStations() -> [LAMStation] {
        
        let lamStationResults = try! Realm().objects(LAMStation)
        var lamStations = [LAMStation]()
        
        if lamStationResults.count > 0 {
            for dbLamStation in lamStationResults {
                let lamStation = dbLamStation as LAMStation
                lamStations.append(lamStation)
            }
            
        }
        
        return lamStations
    }
    
    func readFromDocumentsFile(fileName:String) -> String {

        let path = NSBundle.mainBundle().pathForResource("lams", ofType: "txt")
        let text = try! NSString(contentsOfFile: path!, encoding: NSUTF8StringEncoding) as String
        return text
    }
    
    func findStationById (stationId: NSString) ->NSString {
        let realm = try! Realm()
        let predicate = NSPredicate(format: "lam_station_id= %@", stationId)
        let result = realm.objects(LAMStation).filter(predicate)
        
        let station = result[0] as LAMStation
        
        return station.tsa_name
        
    }
    
    func readLAMStations() {
        

        let text = readFromDocumentsFile("lams.csv")
        let csv = CSwiftV(String: text as String)
        let rows = csv.rows
        
        var lamStations = [LAMStation]()
        for row in rows {
            let lam = LAMStation()
            lam.tsa_number = row[0]
            lam.lam_station_id = row[1]
            lam.tsa_name = row[2]
            lam.name_fi =  row[3]
            lam.name_se = row[4]
            lam.name_en = row[5]
            lam.road = row[6]
            lam.road_part = row[7]
            lam.distance = row[8]
            lam.tsa_cord_y = row[9]
            lam.tsa_cord_x = row[10]
            lam.tsa_height = row[11]
            lam.county = row[12]
            lam.lat = row[13]
            lam.lat_min = row[14]
            lam.lat_sec = row[15]
            lam.long_dec = row[16]
            lam.long_min = row[17]
            lam.long_sec = row[18]
            
            lamStations.append(lam)
        }
        
        self.saveMultipleLAMStations(lamStations)
        
        
  
    }

}
