//
//  CompanyMapViewController.swift
//  Companies
//
//  Created by CS3714 on 10/17/16.
//  Copyright © 2016 Jesus Fabian. All rights reserved.
//

import UIKit
import MapKit

import CoreLocation



class CompanyMapViewController: UIViewController, MKMapViewDelegate {
    
    

    @IBOutlet var companyNameNavItem: UINavigationItem!
    
    
    @IBOutlet var companyMapView: MKMapView!
    
    
    var companyAddressPassed: String?
    
    override func viewDidLoad() {
    
        companyMapView.mapType = MKMapType.standard
        
        let geocoder:CLGeocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(companyAddressPassed!) { [weak self] placemarks, error in
            
            
            if let placemark = placemarks?.first, let location = placemark.location {
                
            
                let mark = MKPlacemark(placemark: placemark)
                
                
                
                if var region = self?.companyMapView.region {
                    
                    region.center = location.coordinate
                    
                    region.span.longitudeDelta /= 8.0
                    
                    region.span.latitudeDelta /= 8.0
                    
                    self?.companyMapView.setRegion(region, animated: true)
                    
                    self?.companyMapView.addAnnotation(mark)
                    
                }
                
            }
            
        }
        
    }


}

