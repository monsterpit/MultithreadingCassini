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
            // how about we optional chain it
            //that's make it this line will be ignored if scrollView is nil
            // all that's happening here is that we are setting to image to nil
            // it's for just preparing its going to start out nil
            scrollView?.contentSize = imageView.frame.size
            
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
            /*
             This is where our app is trying to go out on the get that cassini or any URL and it's big
             And even for a faster network it's taking long to load over
             So this line of code is aint returning
             let urlContents = try? Data(contentsOf: url)
             So I cant have this line of code executing on main queue
             which is where all my code pretty much runs unless I specifically put it somewhere else or  unless I use some iOS API to  put it somewhere else
             
             So how do I get it off the main queue ?
             Well I just use
             DispatchQueue.main.async{}
             
             but we don't want to run on main queue So lets change it
             DispatchQueue.global(qos : .userInitiated).async{}
             
             this will immediately stop my app from blocking like that because it's going to be doing this network fetch on some other queue
             */
            
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                let urlContents = try? Data(contentsOf: url)
                
                if let imageData = urlContents{
                    
                    self?.image = UIImage(data: imageData)
                    /*
                     Checking if we have a memory cycle here
                     here self doesnt have a pointer to this closure
                     there is no pointer in self that points to this closure
                     So there's no cycle
                     
                     However whenever you do this with multithreading
                     when you do self. you have to think about another thing
                     which is what happens if the code before this line that has self itself takes a long time to execute
                     So long that this viewcontroller doesn't even wanna be in here anymore
                     Can't you imagine that easily happening
                     Someone goes to go get an image
                     The image is taking 5 minutes to come along they are like forget it
                     and they will click somewhere else , go back or something
                     Now that view controller that requested that image it's meaningless
                     It has no value it should not be in the heap but it's being kept in the heap by  this closure
                     because I have a reference to self in this closure , this view controller ,
                     my imageViewcontroller is being always kept in the heap
                     for as long as image request is outstanding  ,
                     So this is a case where i wanna do weak self
                     Not having anything to do with memory cycles
                     but having to do with fact that i don't want self held in the heap by this closure
                     if this closure takes so long to run that the user doesn't care about self anymore then Idc about self anymore
                     So by definition i want to be weak
                     
                     
                     So in multithread think about weak or whether you wanna really hold things on heap
                     
                    */
                }
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
