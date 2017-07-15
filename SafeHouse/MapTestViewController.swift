//
//  MapTestViewController.swift
//  SafeHouse
//
//  Created by Savannah McCoy on 7/15/17.
//  Copyright © 2017 Savannah McCoy. All rights reserved.
//

import UIKit
import GoogleMaps
import MapKit

class MapTestViewController: UIViewController {

    @IBOutlet weak var mapsView: GMSMapView!
    //@IBOutlet weak var mapsView: MKMapView!
    
    //let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
    
    let currentLocation = CLLocationCoordinate2D(latitude: 43.71, longitude: 7.26 )
    
    override func viewDidLoad() {
        
//        let camera = GMSCameraPosition.camera(withLatitude: 1.285, longitude: 103.848, zoom: 12)
//        let mapView = GMSMapView.map(withFrame: frame, camera: camera)
//        self.mapsView = mapView
        
        let camera = GMSCameraPosition.camera(withLatitude: 43.71, longitude: 7.26, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.init(x: 50, y: 50, width: 50, height: 50), camera: camera)
        self.mapsView = mapView
        //view = mapsView
        //Add a marker to the map in loadView().
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = currentLocation
        marker.title = "Currently"
        marker.snippet = "Visiting"
        marker.map = mapView

        print("VIEW DID LOAD")
        
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
//    override func loadView() {
//        
//        
//        
//        
//        // Create a GMSCameraPosition that tells the map to display the
//        // coordinate -33.86,151.20 at zoom level 6.
////        
////        let camera = GMSCameraPosition.camera(withLatitude: 1.285, longitude: 103.848, zoom: 12)
////        mapsView.camera = camera
////        mapsView.delegate = self as! GMSMapViewDelegate
////        mapsView.accessibilityElementsHidden = false
////        mapsView.isIndoorEnabled = false
////        mapsView.settings.myLocationButton = true
////        DispatchQueue.main.async(execute: {() -> Void in
////            self.mapsView.isMyLocationEnabled = true
////        })
////    
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
