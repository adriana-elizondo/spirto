//
//  MapViewController.swift
//  Spirto
//
//  Created by Adriana Elizondo on 2019/8/19.
//  Copyright © 2019 adriana. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var locationPinView: UIView!
    @IBOutlet weak var locationPin: UIImageView!
    private let locationManager = CLLocationManager()
    private var usersPosition: CGPoint?
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        setupLocationManager()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        (navigationController?.parent as? TopTabBarController)?.tabBar?.hideMe(hide: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = true
        locationManager.stopUpdatingLocation()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
    }
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
}
extension MapViewController: MKMapViewDelegate, CLLocationManagerDelegate, UIScrollViewDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard usersPosition == nil else { locationManager.stopUpdatingLocation(); return }
        if let location = locations.last {
            getUserFriendlyAddressFromLocation(with: location)
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude,
                                                longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center,
                                            span: MKCoordinateSpan(latitudeDelta: 0.01,
                                                                   longitudeDelta: 0.01))
            mapView.setRegion(region, animated: true)
            let currentLocationPoint = mapView.convert(location.coordinate, toPointTo: locationPinView)
            usersPosition = currentLocationPoint
            locationPin.center = currentLocationPoint
        }
    }
    private func getUserFriendlyAddressFromLocation(with lastLocation: CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(lastLocation,
                                        completionHandler: { (placemarks, error) in
                guard error == nil else { return }
                if let placemark = placemarks?.first {
                    self.addressTextField.text = "\(placemark.locality ?? "") \(placemark.name ?? "")"
                }
        })
    }
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let newPoint = locationPinView.convert(locationPin.center, to: self.mapView)
        let location = mapView.convert(newPoint, toCoordinateFrom: self.mapView)
        getUserFriendlyAddressFromLocation(with: CLLocation(latitude: location.latitude,
                                                            longitude: location.longitude))
    }
}
