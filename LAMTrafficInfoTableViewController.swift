//
//  LAMTrafficInfoTableViewController.swift
//  TrafficInfo
//
//  Created by Tuukka Tallgren on 20/10/15.
//  Copyright © 2015 omenafarmari. All rights reserved.
//

import UIKit

class LAMTrafficInfoTableViewController: UITableViewController, NSXMLParserDelegate {

    var xmlParser: NSXMLParser!
    var entryTrafficVolume1: String!
    var entryAverageSpeed1: String!
    var entryLamID: String!
    var entryMeasurementTime: String!
    let lamDAO = LAMDAO()
    
    var currentParsedElement:String! = String()
    var entryDictionary: [String:String]! = Dictionary()
    
    var entriesArray:[Dictionary<String, String>]! = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let lamDAO = LAMDAO()
        if lamDAO.getLAMStations().count < 1 {
            print("1")
            lamDAO.readLAMStations()
            
        }
        
        let urlString = NSURL(string: "http://tie.digitraffic.fi/sujuvuus/ws/lamData")
        let rssUrlRequest:NSURLRequest = NSURLRequest(URL:urlString!)
        
        let queue:NSOperationQueue = NSOperationQueue()
        NSURLConnection.sendAsynchronousRequest(rssUrlRequest, queue: queue) {
            (response, data, error) -> Void in
            
            self.xmlParser = NSXMLParser(data: data!)
            self.xmlParser.delegate = self
            self.xmlParser.parse()
            
        }
        
    }
    
    //MARK: NSXMLParserDelegate
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        if elementName == "lamid"{
            entryLamID = String()
            currentParsedElement = "lamid"
        }
        if elementName == "trafficvolume1"{
            entryTrafficVolume1 = String()
            currentParsedElement = "trafficvolume1"
        }
        if elementName == "averagespeed1"{
            entryAverageSpeed1 = String()
            currentParsedElement = "averagespeed1"
        }
        
    }
    
    func parser(parser: NSXMLParser,
        foundCharacters string: String){
            if currentParsedElement == "lamid" {
                entryLamID = entryLamID + string
            }
            if currentParsedElement == "trafficvolume1" {
                entryTrafficVolume1 = entryTrafficVolume1 + string
            }
            if currentParsedElement == "averagespeed1" {
                entryAverageSpeed1 = entryAverageSpeed1 + string
            }
            
    }
    
    
    func parser(parser: NSXMLParser,
        didEndElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?){
            if elementName == "lamid"{
                entryDictionary["entryLamID"] = entryLamID
            }
            if elementName == "trafficvolume1"{
                entryDictionary["entryTrafficVolume1"] = entryTrafficVolume1
            }
            if elementName == "averagespeed1"{
                entryDictionary["entryAverageSpeed1"] = entryAverageSpeed1
                entriesArray.append(entryDictionary)
            }
            
    }
    
    
    func parserDidEndDocument(parser: NSXMLParser){
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.tableView.reloadData()
            
        })
        
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.entriesArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

        // Configure the cell...
        let text = " Keskinopeus "
        let unit = " km/h "
        
        let stationName = lamDAO.findStationById(entriesArray[indexPath.row]["entryLamID"]!) as String

        cell.textLabel?.text = stationName + text + entriesArray[indexPath.row]["entryAverageSpeed1"]! + unit

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
