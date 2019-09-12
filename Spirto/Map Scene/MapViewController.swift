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

protocol MapDisplayProtocol: class {
    func displayAddressSavedSuccessfully()
}
enum AddressCompletionStatus {
    case empty, detailAdded, finished
}
class CustomCoverView: UIView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        if view is UIButton { return view }
        return nil
    }
}
class MapViewController: UIViewController, MapDisplayProtocol {
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var textFieldBackgroundView: UIView! {
        didSet {
            textFieldBackgroundView.addGestureRecognizer(
                UITapGestureRecognizer(target: self,
                                    action: #selector(dissmissText)))
        }
    }
    @IBOutlet weak var selectLocationButtn: UIButton!
    @IBOutlet weak var addressTextField: UITextField! {
        didSet {
            let imageView = UIImageView(image: #imageLiteral(resourceName: "map_pin"))
            imageView.frame = CGRect(x: 0, y: 0, width: 35, height: 20)
            imageView.contentMode = .scaleAspectFit
            imageView.setImageColor(color: UIColor.spirtoColor())
            addressTextField.leftView = imageView
            addressTextField.leftViewMode = .always
            addressTextField.delegate = self
        }
    }
    @IBOutlet weak var secondaryAddressTextField: UITextField! {
        didSet {
            secondaryAddressTextField.delegate = self
        }
    }
    @IBOutlet weak var topAddressConstraint: NSLayoutConstraint!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var locationPinView: UIView!
    @IBOutlet weak var locationPin: UIImageView!
    private let locationManager = CLLocationManager()
    private var usersPosition: CGPoint?
    private var addressDetail = ""
    private var addressPlaceMark: CLPlacemark?
    private var addressStatus = AddressCompletionStatus.empty
    private var interactor: MapBusinessLogic?
    private var shouldKeepUpdating = true
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupLocationManager()
        setup()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        locationManager.stopUpdatingLocation()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
    }
    private func setup() {
        let viewcontroller = self
        let presenter = MapPresenter()
        presenter.viewController = viewcontroller
        let interactor = MapInteractor()
        interactor.presenter = presenter
        self.interactor = interactor
        shouldKeepUpdating = true
        nextButton.disableMe()
    }
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    //Actions
    @IBAction func tappedNext(_ sender: Any) {
        switch addressStatus {
        case .empty:
            secondaryAddressTextField.text = ""
            secondaryAddressTextField.placeholder = "Building number, observations, etc."
            addressStatus = .detailAdded
        case .detailAdded:
            interactor?.saveAddress(with: addressTextField.text ?? "",
                                    city: addressPlaceMark?.subAdministrativeArea ?? "",
                                    coordinates: addressPlaceMark?.location?.coordinate ?? CLLocationCoordinate2D())
        default:
            break
        }
    }
    @IBAction func dismissMe(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func selectThisLocation(_ sender: Any) {
        shouldKeepUpdating = false
        backButton.isHidden = false
        dismissButton.isHidden = true
        topAddressConstraint.constant = 0
        nextButton.enableMe(with: UIColor.white)
    }
    @IBAction func goBack(_ sender: Any) {
        switch addressStatus {
        case .detailAdded:
            backButton.isHidden = true
            dismissButton.isHidden = false
            topAddressConstraint.constant = -50
            nextButton.disableMe()
            break
        case .finished:
            secondaryAddressTextField.text = ""
            secondaryAddressTextField.placeholder = "Building number, observations, etc."
            addressStatus = .detailAdded
            break
        default:
            break
        }
    }
    @objc func dissmissText() {
        addressTextField.resignFirstResponder()
        secondaryAddressTextField.resignFirstResponder()
    }
    //protocol
    func displayAddressSavedSuccessfully() {
        //
        dismissMe(self)
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
        }
    }
    private func getUserFriendlyAddressFromLocation(with lastLocation: CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(lastLocation,
                                        completionHandler: { (placemarks, error) in
                guard error == nil else { return }
                if let placemark = placemarks?.first {
                    self.addressTextField.text = "\(placemark.locality ?? "") \(placemark.name ?? "")"
                    self.addressPlaceMark = placemark
                }
                self.selectLocationButtn.isHidden = false
        })
    }
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        shouldKeepUpdating = true
        selectLocationButtn.isHidden = true
    }
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        guard shouldKeepUpdating else { return }
        let newPoint = locationPinView.convert(locationPin.center, to: self.mapView)
        let location = mapView.convert(newPoint, toCoordinateFrom: self.mapView)
        getUserFriendlyAddressFromLocation(with: CLLocation(latitude: location.latitude,
                                                            longitude: location.longitude))
    }
}
extension MapViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textFieldBackgroundView.isHidden = false
        if !(textField.text?.isEmpty ?? true) {
            switch addressStatus {
            case .empty:
                addressStatus = .detailAdded
                break
            case .detailAdded:
                addressStatus = .finished
                break
            case .finished:
                break
            }
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        textFieldBackgroundView.isHidden = true
        if textField == secondaryAddressTextField {
            addressDetail = textField.text ?? ""
        }
    }
}
