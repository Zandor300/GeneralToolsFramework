//
//  MKMapView+Focus.swift
//  GeneralToolsFramework
//
//  Created by Zandor Smith on 19/12/2018.
//

import Foundation
import MapKit

// See https://stackoverflow.com/a/53025716/5544222
extension MKMapView {
    
    public func fitAll(animated: Bool, padding: UIEdgeInsets) {
        var zoomRect            = MKMapRect.null;
        for annotation in annotations {
            let annotationPoint = MKMapPoint(annotation.coordinate)
            let pointRect       = MKMapRect(x: annotationPoint.x, y: annotationPoint.y, width: 0.01, height: 0.01);
            zoomRect            = zoomRect.union(pointRect);
        }
        setVisibleMapRect(zoomRect, edgePadding: UIEdgeInsets(top: 100 + padding.top, left: 100 + padding.left, bottom: 100 + padding.bottom, right: 100 + padding.right), animated: animated)
    }
    
    /// When we call this function, we have already added the annotations to the map, and just want all of them to be displayed.
    public func fitAll(animated: Bool) {
        var zoomRect            = MKMapRect.null;
        for annotation in annotations {
            let annotationPoint = MKMapPoint(annotation.coordinate)
            let pointRect       = MKMapRect(x: annotationPoint.x, y: annotationPoint.y, width: 0.01, height: 0.01);
            zoomRect            = zoomRect.union(pointRect);
        }
        setVisibleMapRect(zoomRect, edgePadding: UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100), animated: animated)
    }
    
    public func fitAll() {
        fitAll(animated: true)
    }
    
    /// We call this function and give it the annotations we want added to the map. we display the annotations if necessary
    public func fitAll(in annotations: [MKAnnotation], andShow show: Bool, animated: Bool) {
        var zoomRect:MKMapRect  = MKMapRect.null
        
        for annotation in annotations {
            let aPoint          = MKMapPoint(annotation.coordinate)
            let rect            = MKMapRect(x: aPoint.x, y: aPoint.y, width: 0.1, height: 0.1)
            
            if zoomRect.isNull {
                zoomRect = rect
            } else {
                zoomRect = zoomRect.union(rect)
            }
        }
        if(show) {
            addAnnotations(annotations)
        }
        setVisibleMapRect(zoomRect, edgePadding: UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100), animated: animated)
    }
    
    public func fitAll(in annotations: [MKAnnotation], andShow show: Bool) {
        fitAll(in: annotations, andShow: show, animated: true)
    }
    
}
