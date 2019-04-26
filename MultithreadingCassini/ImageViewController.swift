//
//  ImageViewController.swift
//  Cassini
//
//  Created by Boppo on 25/04/19.
//  Copyright © 2019 MB. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController , UIScrollViewDelegate {
    
    var imageURL : URL?{
        didSet{
            
            image = nil
            
            if view.window != nil{
                
                fetchImage()
            }
        }
    }
    
    private var image : UIImage?{
        get
        {
           return imageView.image
        }
        set
        {
            imageView.image = newValue
            
            imageView.sizeToFit()
            
            scrollView.contentSize = imageView.frame.size
            
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if imageView.image == nil{
            fetchImage()
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView!{

        didSet{
            
            scrollView.minimumZoomScale = 1/25
            
            // max to 1 so bits doesnt looks pixelated so i wont let you zoom in any more than 1.0
            scrollView.maximumZoomScale = 1
            
            scrollView.delegate = self
            
            scrollView.addSubview(imageView)

        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        //returning imageView because that's the subview we want to be transformed when we pinch
        return imageView
    }
    
    
    //this create a imageView of size zero
    var imageView = UIImageView()
    
    func fetchImage(){
        
        if let url = imageURL{
            
            let urlContents = try? Data(contentsOf: url)
            
            if let imageData = urlContents{
                
                image = UIImage(data: imageData)

            }
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // by the time I load if my imageURl is nil then load up a sample image
        if imageURL == nil {
            
            imageURL = DemoURLs.standford
        }
    }
    
    
}


//easier in code than IB

//zooming
//set min and max zoom scale
//provide a delegate that says which is a view to zoom
//now it's obvious which view we want the transform to work on here its our imageView


//option key + drag in simulator to pinch 
