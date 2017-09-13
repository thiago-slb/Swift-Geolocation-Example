//
//  ViewController.swift
//  Geolocation
//
//  Created by Thiago Lovatine on 13/09/17.
//  Copyright © 2017 Thiago Lovatine. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()

    @IBOutlet weak var enableGolocationBtn: UIButton!
    
    @IBOutlet weak var getGeolocationBtn: UIButton!
    
    @IBOutlet weak var locationDeniedBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if CLLocationManager.authorizationStatus() == .notDetermined {
            enableGolocationBtn.isHidden    = false
            getGeolocationBtn.isHidden      = true
            locationDeniedBtn.isHidden      = true
        } else if(CLLocationManager.authorizationStatus() == .authorizedAlways){
            enableGolocationBtn.isHidden    = true
            getGeolocationBtn.isHidden      = false
            locationDeniedBtn.isHidden      = true
        } else if(CLLocationManager.authorizationStatus() == .denied){
            enableGolocationBtn.isHidden    = true
            getGeolocationBtn.isHidden      = true
            locationDeniedBtn.isHidden      = false
        }
        
        locationManager.delegate = self;
        locationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func enableGeolocation(_ sender: Any) {
        locationManager.requestAlwaysAuthorization()
    }
    
    
    @IBAction func getGeolocation(_ sender: Any) {
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        
        //locationManager.stopUpdatingLocation()
        
        let location = locations[0]
        
        print(location.coordinate)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == CLAuthorizationStatus.denied) {
            print("Location denied!!!")
            locationDeniedBtn.isHidden = false
            enableGolocationBtn.isHidden = true
            getGeolocationBtn.isHidden   = true
        } else if (status == CLAuthorizationStatus.authorizedAlways) {
            print("Location enabled always!")
            locationDeniedBtn.isHidden = true
            enableGolocationBtn.isHidden = true
            getGeolocationBtn.isHidden   = false
        }
    }
    @IBAction func goToSettings(_ sender: Any) {
        if let url = URL(string: "App-Prefs:root=Privacy&path=LOCATION/com.studiotella.Geolocation") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

}

