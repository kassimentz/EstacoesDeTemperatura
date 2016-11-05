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
                
                
                
            }
            
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.loadData()
        

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
