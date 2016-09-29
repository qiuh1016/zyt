//
//  MapViewController.swift
//  zytyumin-iOS
//
//  Created by qiuhong on 9/9/16.
//  Copyright © 2016 CETCME. All rights reserved.
//

import Foundation
import UIKit

class MapViewController: UIViewController, BMKMapViewDelegate {
    
    var bMKMapView: BMKMapView!
    var polyline: BMKPolyline?
    
    var coords = [CLLocationCoordinate2D]()
    var anntations = [MyAnnotation]()
    var overlays = [BMKOverlay]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
        initMapView()
    }
    
    
    func initNavigationBar() {
        self.navigationController?.navigationBar.barTintColor = UIColor.navigationBarColor()
        self.navigationController?.navigationBar.titleTextAttributes =  [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    func initMapView() {
        bMKMapView = BMKMapView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - 64 - 49))
        bMKMapView.showMapScaleBar = true
        bMKMapView.isRotateEnabled = false //关闭旋转
        bMKMapView.isOverlookEnabled = false //关闭俯视
        bMKMapView.delegate = self
        self.view.addSubview(bMKMapView!)
        
        let mapStatus = BMKMapStatus()
        mapStatus.targetGeoPt = CLLocationCoordinate2D(latitude: 30, longitude: 122)
        mapStatus.fLevel = 8
        bMKMapView.setMapStatus(mapStatus)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //bMKMapView.viewWillAppear()
        bMKMapView.delegate = self // 此处记得不用的时候需要置nil，否则影响内存的释放
        
        if defaults.bool(forKey: "hasLogin") {
            let ships = (self.tabBarController as! TabBarController).ships
            for ship in ships {
                coords.append(ship.coor)
                setAnnotation(ship, type: .point)
            }
            drawMapLine()
        } else {
            bMKMapView.removeAnnotations(anntations)
            bMKMapView.removeOverlays(overlays)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //bMKMapView.viewWillDisappear()
        bMKMapView.delegate = nil // 不用时，置nil
        
        bMKMapView.removeAnnotations(anntations)
        bMKMapView.removeOverlays(overlays)
    }

    
    func setAnnotation(_ ship: Ship, type: MyAnnotationType) {
        let annotation = MyAnnotation()
        annotation.title = ship.name
        annotation.subtitle = ship.number
        annotation.type = type
        annotation.coordinate = ship.coor
        bMKMapView.addAnnotation(annotation)
        anntations.append(annotation)
    }
    
    func drawMapLine() {
        polyline = BMKPolyline(coordinates: &coords, count: UInt(coords.count))
        bMKMapView.add(polyline)
        overlays.append(polyline!)
    }
    
    func mapView(_ mapView: BMKMapView!, viewFor annotation: BMKAnnotation!) -> BMKAnnotationView! {
        
        if annotation.isKind(of: MyAnnotation.self) {
            var view = mapView.dequeueReusableAnnotationView(withIdentifier: "point");
            view = BMKAnnotationView(annotation: annotation, reuseIdentifier: "point");
            let myAnnotation = annotation as! MyAnnotation
            switch myAnnotation.type {
            case .start:
                view?.image = UIImage(named: "map_icon_start");
            case .end:
                view?.image = UIImage(named: "map_icon_end");
            case .point:
                view?.image = UIImage(named: "map_icon_point");
            }
            view?.centerOffset = CGPoint(x: 0, y: -(view!.frame.size.height * 0.5));
            view?.canShowCallout = true;
            return view
        }
        
        return nil
    
    }
    
    func mapView(_ mapView: BMKMapView!, didSelect view: BMKAnnotationView!) {
        print(view.annotation.title!())
    }
    
    func mapView(_ mapView: BMKMapView!, viewFor overlay: BMKOverlay!) -> BMKOverlayView! {
        if let overlayTemp = overlay as? BMKPolyline {
            let polylineView = BMKPolylineView(overlay: overlay)
            if overlayTemp == polyline {
                polylineView?.strokeColor = UIColor.mainColor()
                polylineView?.lineWidth = 2
            }
            return polylineView
        }

        return nil
    }

    
    func mapView(_ mapView: BMKMapView!, annotationViewForBubble view: BMKAnnotationView!) {
        print("\(view.annotation.title!())")
        
        let sb = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = sb.instantiateViewController(withIdentifier: "ShipInfoViewController")
        self.present(vc, animated: true, completion: nil)
        
    }
}


















