//
//  ViewController.swift
//  Assignment2_UG
//
//  Created by topaz t on 6/05/2015.
//  Copyright (c) 2015 topaz turkenitz. All rights reserved.
//
import Foundation
import UIKit



//Dealing with Alamofire request

enum Router: URLRequestConvertible {
    case QPXRequest()
    
    var URLRequest: NSURLRequest {
        let URL = NSURL(string: "https://www.googleapis.com/qpxExpress/v1/trips/search?key=<ios-key>&fields=trips(data/carrier/name),trips(tripOption/saleTotal)")!
        let URLRequest = NSMutableURLRequest(URL: URL)
        
        URLRequest.HTTPMethod = "POST"
        
        var parameters = [
            "request": [
                "slice": [
                    [
                        "origin": "SYD",
                        "destination": "LOS",
                        "date": "2015-07-15"
                    ]
                ],
                
                "passengers": [
                    "adultCount": 1,
                    "infantInLapCount": 0,
                    "infantInSeatCount": 0,
                    "childCount": 0,
                    "seniorCount": 0
                ],
                "solutions": 5,
                "refundable": false
            ]
        ]
        
        return ParameterEncoding.JSON.encode(URLRequest, parameters: parameters).0
    }
}



////////////


class FlightsController: UITableViewController {


    var arrayOfFlights : [FlightDataModel] = [FlightDataModel]()
   
    /*
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let qpxRequest = Router.QPXRequest()
        
        request(qpxRequest).responseJSON { (request, response, json, error) -> Void in
            if response != nil {
               //println(response!)
            }
            if json != nil {
                if let myJSON = json as? [String:AnyObject] {
                    if let trips = myJSON["trips"] as? [String:AnyObject] {
                        if let data = trips["data"] as? [String:AnyObject] {
                            if let carriers = data["carrier"] as? [[String:String]] {
                                for (index, carrierName) in enumerate(carriers) {
                                    println("\(index): " + carrierName["name"]!)
                                }
                            }
                        }
                        if let tripOptions = trips["tripOption"] as? [[String:AnyObject]] {
                            for (index, tripOption) in enumerate(tripOptions) {
                                //println("\(index): " + (tripOption["saleTotal"]! as String))
                               var j = tripOption["saleTotal"]! as String
                                self.arrayOfFlights[index].carrier = j
                                println("\(self.arrayOfFlights[index].carrier)")
                            }
                        }
                    }
                }
            }//end if json..
            
         
            
        } // end api request
        
       // self.setupFlightData()
        
        
    } //end viewdidload
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //Managing the table
    /*
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var Cell = self.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as flightTableViewCell
    
    
    
    //Cell.textLabel?.text = SecondArray[indexPath.row]
        
        return Cell
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        var indexPath : NSIndexPath = self.tableView.indexPathForSelectedRow()!
        
        //var DestViewController = segue.destinationViewController as BookingController
        
       // DestViewController.FirstString = "sss"//SecondAnswerArray[indexPath.row]
        
        
    }
*/
    

    
    
}
