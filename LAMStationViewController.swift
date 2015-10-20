//
//  LAMStationViewController.swift
//  TrafficInfo
//
//  Created by Tuukka Tallgren on 20/10/15.
//  Copyright © 2015 omenafarmari. All rights reserved.
//

import UIKit

class LAMStationViewController: UIViewController {
    
    var data = LAMStation()

    @IBOutlet weak var lblRoadLon: UILabel!
    @IBOutlet weak var lblRoadLat: UILabel!
    @IBOutlet weak var lblRoadTsaY: UILabel!
    @IBOutlet weak var lblRoadTsaX: UILabel!
    @IBOutlet weak var lblRoadPart: UILabel!
    @IBOutlet weak var lblRoad: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblCounty: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        lblName.text = data.name_en
        lblRoad.text = data.road
        lblRoadPart.text = data.road_part
        lblRoadTsaX.text = data.tsa_cord_x
        lblRoadTsaY.text = data.tsa_cord_y
        lblCounty.text = data.county
        lblRoadLat.text = data.lat
        lblRoadLon.text = data.long_dec
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
