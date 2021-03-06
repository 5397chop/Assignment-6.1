//
//  FirstViewController.swift
//  geoMessenger
//
//  Created by Ivor D. Addo, PhD on 10/17/17.
//  Copyright © 2017 water. All rights reserved.
//

import UIKit
import MapKit
import Firebase

class FirstViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var messageNodeRef: DatabaseReference!
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    // MARK: - location manager to authorize user location for Maps app
    var locationManager = CLLocationManager()
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationAuthorizationStatus()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.mapView.delegate = self
        
        let initialLocation = CLLocation(latitude: 43.037632, longitude: -87.927967)
        centerMapOnLocation(location: initialLocation)
        
        messageNodeRef = Database.database().reference().child("messages")
        
        let pinMessageId = "msg-1"
        var pinMessage: Message?
        messageNodeRef.child(pinMessageId).observe(.value, with: { (snapshot: DataSnapshot) in
            
            if let dictionary = snapshot.value as? [String: Any]
            {
                if pinMessage != nil
                {
                    self.mapView.removeAnnotation(pinMessage!)
                }
                
                let pinLat = dictionary["latitude"] as! Double
                let pinLong = dictionary["longitude"] as! Double
                let messageDisabled = dictionary["isDisabled"] as! Bool
                
                let message = Message(title: (dictionary["title"] as? String)!,
                                      locationName: (dictionary["locationName"] as? String)!,
                                      username: (dictionary["username"] as? String)!,
                                      coordinate: CLLocationCoordinate2D(latitude: pinLat, longitude: pinLong),
                                      isDisabled: messageDisabled
                )
                
                pinMessage = message
                
                if !message.isDisabled
                {
                    self.mapView.addAnnotation(message)
                }                
            }
        })
    }
}
