//
//  CreateEventFormVC.swift
//  StJhonsAmbulance
//
//  Created by Muhammad Usman on 3/6/23.
//

import UIKit

class CreateEventFormVC: ENTALDBaseViewController, UIScrollViewDelegate {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var segmentsCOntroll: UISegmentedControl!
    @IBOutlet var scrollView: UIScrollView!{
        didSet{
            scrollView.delegate = self
            scrollView.isPagingEnabled = true
        }
    }
    var slides:[Any] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.slides = self.createSlides()
        // Do any additional setup after loading the view.
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.08, execute: {
            self.setupSlideScrollView(slides: self.slides)
        })
    }


    @IBAction func onChangeSegment(_ sender: Any) {
        
        scrollView.scrollTo(currentPage: segmentsCOntroll.selectedSegmentIndex)
    }
    
    func setupSlideScrollView(slides : [Any]) {
        let screenWidth = UIScreen.main.bounds.width
        scrollView.contentSize = CGSize(width: screenWidth * CGFloat(slides.count), height: containerView.frame.height)
        
        for i in 0 ..< slides.count {
            if i == 0 {
                var view = slides[0] as! GeneralInfoFormVC
                view.frame = CGRect(x: screenWidth * CGFloat(i), y: 0, width: screenWidth, height: containerView.frame.height)
                scrollView.addSubview(view)
            }else{
                var view = slides[1] as! EventDetailInfoFormVC
                view.frame = CGRect(x: screenWidth * CGFloat(i), y: 0, width: screenWidth, height: containerView.frame.height)
                scrollView.addSubview(view)
            }
        }
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    func createSlides() -> [Any] {
//
        let slide1 : GeneralInfoFormVC = Bundle.main.loadNibNamed("GeneralInfoFormVC", owner: self, options: nil)?.first as! GeneralInfoFormVC
        
        let slide2 : EventDetailInfoFormVC = Bundle.main.loadNibNamed("EventDetailInfoFormVC", owner: self, options: nil)?.first as! EventDetailInfoFormVC
        
        return [slide1, slide2]
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}


extension UIScrollView {
    func scrollTo(currentPage: Int? = 0) {
        let screenWidth = UIScreen.main.bounds.width
        var frame: CGRect = self.frame
        frame.origin.x = screenWidth * CGFloat(currentPage ?? 0)
        self.scrollRectToVisible(frame, animated: true)
    }
}
