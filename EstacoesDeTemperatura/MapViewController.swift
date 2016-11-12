//
//  MapViewController.swift
//  EstacoesDeTemperatura
//
//  Created by Kassiane S Mentz on 04/11/16.
//  Copyright © 2016 Kassiane S Mentz. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    
    @IBOutlet weak var mapView: MKMapView!
    
    var weatherStation: WeatherStation?
    var annotation: MKPointAnnotation!
    var weatherStations = [WeatherStation]()
    
    //MARK: - Custom Methods
    
    func loadData(){
        
        let weatherStationManager = WeatherStationManager()
        
        weatherStationManager.loadWeatherStations{ (weatherStations, error) in
            if error == nil {
                
                self.weatherStations = weatherStations!
                
                for item in self.weatherStations {
                    
                    self.loadLocations(latitude: item.latitude!, longitude: item.longitude!, estacao: item.station ?? "Não Informado", temperatura: item.temperaturaExterna ?? 0.0)
                }
                
                
            }
            
        }
    }
    
    func loadLocations (latitude: Double, longitude: Double, estacao: String?, temperatura: Double?){
        
        let latDelta: CLLocationDegrees = 0.50
        let lonDelta: CLLocationDegrees = 0.50
        let span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        annotation = MKPointAnnotation()
        annotation.coordinate = location
        
        if let estacao = estacao {
            annotation.title = "Estação: \(estacao)"
        } else {
            annotation.title = "Sensação: -"
        }
        
        if let temperatura = temperatura {
            annotation.subtitle = "Temperatura: \(temperatura)"
        } else {
            annotation.subtitle = "Temperatura: -"
        }
        
        let region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        mapView.setRegion(region, animated: true)
        mapView.addAnnotation(annotation)
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKPointAnnotation {
            let pinAnnotationview = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "myPin")
            
            pinAnnotationview.pinTintColor = .purple
            pinAnnotationview.isDraggable = true
            pinAnnotationview.canShowCallout = true
            pinAnnotationview.animatesDrop = true
            pinAnnotationview.rightCalloutAccessoryView = UIButton.init(type: .detailDisclosure) as UIButton
            
            return pinAnnotationview
        }
        return nil
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            performSegue(withIdentifier: "moreDetail", sender: weatherStation)
        }
    }
    
//    func mapViewDidFinishRenderingMap(_ mapView: MKMapView, fullyRendered: Bool) {
//        self.mapView.addAnnotation(annotation)
//    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.loadData()
        
        self.mapView.delegate = self
        

        // Do any additional setup after loading the view.
    }

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
