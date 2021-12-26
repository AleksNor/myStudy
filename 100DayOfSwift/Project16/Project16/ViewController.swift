//
//  ViewController.swift
//  Project16
//
//  Created by Евгений Карпов on 25.12.2021.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let london = Capital(
            title: "London",
            coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275),
            info: "Home to the 2012 Summer Olympics.",
            wikiPage: "https://en.wikipedia.org/wiki/London")
        let oslo = Capital(
            title: "Oslo",
            coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75),
            info: "Founded over a thousand years ago.",
            wikiPage: "https://en.wikipedia.org/wiki/Oslo")
        let paris = Capital(
            title: "Paris",
            coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508),
            info: "Often called the City of Light.",
            wikiPage: "https://en.wikipedia.org/wiki/Paris")
        let rome = Capital(
            title: "Rome",
            coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5),
            info: "Has a whole country inside it.",
            wikiPage: "https://en.wikipedia.org/wiki/Rome")
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.", wikiPage: "https://en.wikipedia.org/wiki/Washington,_D.C.")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(changeStyle))
        
        mapView.addAnnotations([london, oslo, paris, rome, washington])
    }
    
    @objc private func changeStyle() {
        let ac = UIAlertController(title: "Change Style", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Satellie", style: .default, handler: { _ in
            self.mapView.mapType = .satellite
        }))
        ac.addAction(UIAlertAction(title: "Hybrid", style: .default, handler: { _ in
            self.mapView.mapType = .hybrid
        }))
        ac.addAction(UIAlertAction(title: "Standard", style: .default, handler: { _ in
            self.mapView.mapType = .standard
        }))
        ac.addAction(UIAlertAction(title: "Satellite Flyover", style: .default, handler: { _ in
            self.mapView.mapType = .satelliteFlyover
        }))
        present(ac, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 1
        guard annotation is Capital else { return nil }
        
        // 2
        let identifier = "Capital"
        
        // 3
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
        
        if annotationView == nil {
            //4
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            
            // 5
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
            annotationView?.markerTintColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        } else {
            // 6
            annotationView?.annotation = annotation
            annotationView?.markerTintColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailVC") as? WebKitilViewController {
            vc.urlString = capital.wikiPage
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

