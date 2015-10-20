//
//  FirstViewController.swift
//  TrafficInfo
//
//  Created by Tuukka Tallgren on 20/10/15.
//  Copyright © 2015 omenafarmari. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, NSXMLParserDelegate {
    
    var xmlParser: NSXMLParser!
    var entryTrafficVolume1: String!
    var entryAverageSpeed1: String!
    var entryLamID: String!
    var entryMeasurementTime: String!
    
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
            print(self.entriesArray)

        })
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

