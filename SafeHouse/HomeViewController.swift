//
//  HomeViewController.swift
//  SafeHouse
//
//  Created by Savannah McCoy on 7/15/17.
//  Copyright © 2017 Savannah McCoy. All rights reserved.
//


import UIKit
import GoogleMaps
import MapKit
import Foundation
import SystemConfiguration
import MessageUI
import ReachabilitySwift
import PopupDialog


class HomeViewController: UIViewController, MFMessageComposeViewControllerDelegate {
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var backButton: UIButton!
    
    //let messageComposer = MessageCompose()
    let currentLocation = CLLocationCoordinate2D(latitude: 43.71, longitude: 7.26)
    var htmlDirections = [String]()
    var directions = [String]()
    var googleDirections = GoogleDirections()
    let reachability = Reachability()!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let title = ""
        let message = ""
        let image = UIImage(named: "loading_Indicator.jpg")
        
        // Create the dialog
        //let popup = PopupDialog(title: "", message: message, image: image)
        //self.present(popup, animated: true, completion: nil)
        
        //self.mapView.animate(toZoom: 5.0)
        self.mapView.animate(toLocation: currentLocation)
        self.mapView.animate(toZoom: 4.0)
        
        let circleCenter = currentLocation
        let circ = GMSCircle(position: circleCenter, radius: 100000)
        let circ2 = GMSCircle(position: circleCenter, radius: 10000)
        let camera = GMSCameraPosition.camera(withLatitude: 43.71, longitude: 7.26, zoom: 6.0)
        //let mapView = GMSMapView.map(withFrame: CGRect.init(x: 50, y: 50, width: 50, height: 50), camera: camera)
        let marker = GMSMarker()
        //self.mapView = mapView
        
        marker.position = currentLocation
        marker.title = "Currently"
        marker.snippet = "Visiting"
        // print("loading")
        
        circ2.fillColor = UIColor.orange
        circ.fillColor = UIColor(red: 1, green: 0.6, blue: 0, alpha: 0.55)    // orange rgb: 255,165,0
        circ.title = "Currently Visiting"
        circ.map = self.mapView
        circ2.map = self.mapView
        
        
        googleDirections.makeSearchRequest(success: { (directions: NSArray) in
            
            self.htmlDirections = directions as! [String]
            
            for direction in self.htmlDirections {
                var newdir = direction.replacingOccurrences(of: "</b>", with: "")
                newdir = newdir.replacingOccurrences(of: "<b>", with: "")
                //newdir = direction.replacingOccurrences(of: "</b>", with: "")
                self.directions.append(newdir)
                //print(newdir)
                
            }
            
        }) { (error: Error) in
            print("-----ERROR----")
            
        }
        
    }
    
    
    func printReachability(){
        
        let reachability = Reachability()!
        
        reachability.whenReachable = { reachability in
            // this is called on a background thread, but UI updates must
            // be on the main thread, like this:
            DispatchQueue.main.async {
                if reachability.isReachableViaWiFi {
                    print("Reachable via WiFi")
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "onlineVC") as! OnlineViewController
                    vc.directions = self.directions
                    self.present(vc, animated: true, completion: nil)
                    
                } else {
                    print("Reachable via Cellular")
                    self.sendsms()
                }
            }
        }
        reachability.whenUnreachable = { reachability in
            // this is called on a background thread, but UI updates must
            // be on the main thread, like this:
            DispatchQueue.main.async {
                print("Not reachable")
            }
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
      
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func didTapBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    
    func canSendText() -> Bool {
        return MFMessageComposeViewController.canSendText()
    }
    
    // Configures and returns a MFMessageComposeViewController instance
    func configuredMessageComposeViewController() -> MFMessageComposeViewController {
        let messageComposeVC = MFMessageComposeViewController()
        messageComposeVC.messageComposeDelegate = self  //  Make sure to set this property to self, so that the controller can be dismissed!
        messageComposeVC.recipients = ["1-408-533-0090"]
        messageComposeVC.body = "REQUEST SAFEHOUSE, AUTH KEY: J3NskpH03-990-45-7"
        return messageComposeVC
    }
    
    
    // MFMessageComposeViewControllerDelegate callback - dismisses the view controller when the user is finished with it
    func messageComposeViewController(_ controller: MFMessageComposeViewController!, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
//    func isInternetAvailable() -> Bool {
//        
//        var zeroAddress = sockaddr_in()
//        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
//        zeroAddress.sin_family = sa_family_t(AF_INET)
//        
//        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
//            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
//                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
//            }
//        }
//        
//        var flags = SCNetworkReachabilityFlags()
//        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
//            
//            //if (!SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags)){
//                
//            //}
//            //messageComposeViewController(controller: MFMessageComposeViewController!, didFinishWith: MessageComposeResult)
//            
//            return false
//        }
//        let isReachable = flags.contains(.reachable)
//        let needsConnection = flags.contains(.connectionRequired)
//        
//        // Present Online View Controller
//        if (isReachable && !needsConnection) {
//            print("ONLINE")
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "onlineVC") as! OnlineViewController
//            vc.directions = self.directions
//            self.present(vc, animated: true, completion: nil)
//            
//        }else{
//            //print("here")
//            print("NO INTERNET")
//            sendsms()
//        }
//        
//        return (isReachable && !needsConnection)
//        
//  
//    }
    
    
    func sendsms(){
        print("openingsms")
        
        let messageComposeViewController = configuredMessageComposeViewController()
        if MFMessageComposeViewController.canSendText() {
            self.present(messageComposeViewController, animated: true, completion: nil)
        } else {
            
        }
        
    }
    
    @IBAction func didTapRequestSafeHouse(_ sender: Any) {
        
        //print(isInternetAvailable())
        printReachability()
        //debugPrint(Networking.networkInterfaceType)

        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let onlineVC = segue.destination as! OnlineViewController
        onlineVC.directions = self.directions
        
    }
    

}



