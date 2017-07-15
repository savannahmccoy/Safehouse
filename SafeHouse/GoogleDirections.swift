//
//  GoogleDirections.swift
//  SafeHouse
//
//  Created by Savannah McCoy on 7/15/17.
//  Copyright © 2017 Savannah McCoy. All rights reserved.
//

import Foundation
import MapKit


//https://maps.googleapis.com/maps/api/directions/json?origin=Boston,MA&destination=Concord,MA&waypoints=Charlestown,MA|Lexington,MA&key=AIzaSyCXh8GV3cbJrzyGpZ0h1QWWz5jcc_N2_FU

class GoogleDirections: NSObject {
    
    let host_path = "https://maps.googleapis.com/maps/api/directions/json?"
    let public_beta_key = "AIzaSyCXh8GV3cbJrzyGpZ0h1QWWz5jcc_N2_FU"
    let currentLocation = CLLocationCoordinate2D(latitude: 43.71, longitude: 7.26)
    let origin = "Nice,France"
    let destination = "Genoa,Italy"
    let mode = "walking"
    
    let instruction = String()
    
    func makeSearchRequest(success: @escaping (NSArray) ->(), failure: @escaping (Error)->()){
        
        let url = URL(string: host_path+"origin="+origin+"&destination="+destination+"&mode="+mode+"&key="+public_beta_key)
        let session = URLSession(
            configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: OperationQueue.main
        )
        let task = session.dataTask(with:url!) { (data, response, error) in
            if error != nil {
                print("Error: ", error!)
            } else {
                do {
                    
                    let response = try JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
                    //print(response)
                    
                    let returnedData = response["routes"] as! NSArray
                    
                    let legs = returnedData.value(forKey: "legs") as! NSArray
                    
                    let steps = legs.value(forKey: "steps") as! NSArray
                    
                    let instructions = steps.value(forKey: "html_instructions") as! NSArray
                    
                    let instr = instructions[0] as! NSArray
                    
                    let inst = instr[0] as! NSArray
                    
                    
                    //let addresses = returnedData.value(forKey: "formatted_address") as! NSArray
                    
                    //print(inst)
                    //                    let downSampledGifs = images.value(forKey: "fixed_width_downsampled") as! NSArray
                    //                    let gifUrls = downSampledGifs.value(forKey: "url") as! NSArray
                    
                    success(inst)
                    
                } catch let error as NSError {
                    print(error)
                }
            }
            
        }
        task.resume()
    }
    
}
