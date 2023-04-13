//
//  EventSummaryVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 24/03/2023.
//

import UIKit
import Parchment

class EventSummaryVC: ENTALDBaseViewController, UIScrollViewDelegate{
    
    var pageController = PagingViewController(viewControllers: [])
    var viewControllers: [UIViewController] = []
    var eventData : CurrentEventsModel?
    var slides:[Any] = []
    
    @IBOutlet var containerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reloadControllers()
    }
    
    func segmentsConfigurations(){
        self.addPagerControllerAsChildView()
        pageController.dataSource = self
        pageController.menuHorizontalAlignment = .center
        pageController.menuItemLabelSpacing = 0
        pageController.menuItemSize = .sizeToFit(minWidth: 90, height: 40)
        pageController.menuBackgroundColor = UIColor.hexString(hex: "e6f2eb")
        pageController.indicatorColor = UIColor.themePrimary
        pageController.indicatorOptions = .visible(height: 3, zIndex: 0, spacing: .zero, insets: .zero)
        let font:UIFont = UIFont.BoldFont(12)
        pageController.font = font
        pageController.selectedFont = font
        
        pageController.textColor = .black
        pageController.selectedTextColor = .themeSecondry
        pageController.collectionView.bounces = false
    }
    
    func addPagerControllerAsChildView(){
        DispatchQueue.main.async {
            self.addChild(self.pageController)
            self.containerView.addSubview(self.pageController.view)
            self.containerView.constrainToEdges(self.pageController.view)
            self.pageController.didMove(toParent: self)
        }
    }
    
    
    func reloadControllers(){
        self.eventData = self.dataModel as? CurrentEventsModel
        self.pageController = PagingViewController(viewControllers: [])
        let eventSummary = EventSummaryScreenVC.loadFromNib()
        let eventDesc = EventDescriptionVC.loadFromNib()
        let eventLocation = EventLocationVC.loadFromNib()
        let eventSchedule = EventScheduleVC.loadFromNib()
        let eventMessage = EventMessagVC.loadFromNib()
        let eventHour = EventHourVC.loadFromNib()
        let eventNote = EventNotesVC.loadFromNib()
        let eventAudit = EventAuditVC.loadFromNib()
        
        eventSummary.title = "Summary"
        eventDesc.title = "Description"
        eventLocation.title = "Location"
        eventSchedule.title = "Schedule"
        eventMessage.title = "Message"
        eventHour.title = "Hours"
        eventNote.title = "Note"
        eventAudit.title = "Audit"
        
        eventSummary.eventData = self.eventData
        eventDesc.eventData = self.eventData
        eventLocation.eventData = self.eventData
        eventSchedule.eventData = self.eventData
        eventMessage.eventData = self.eventData
        eventHour.eventData = self.eventData
        eventNote.eventData = self.eventData
        eventAudit.eventData = self.eventData
        
        viewControllers.append(eventSummary)
        viewControllers.append(eventDesc)
        viewControllers.append(eventLocation)
        viewControllers.append(eventSchedule)
        viewControllers.append(eventMessage)
        viewControllers.append(eventHour)
        viewControllers.append(eventNote)
        viewControllers.append(eventAudit)
        

        var option : PagingOptions = PagingOptions()
        option.borderColor = UIColor.separator
        option.borderOptions = .visible(height: 0.5, zIndex: 0, insets: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))

        self.pageController = PagingViewController(options: option, viewControllers: viewControllers)

        self.segmentsConfigurations()
    }
    
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func homeTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}






extension EventSummaryVC: PagingViewControllerDataSource {
    
    func pagingViewController(_: PagingViewController, pagingItemAt index: Int) -> PagingItem {
        let title = viewControllers[index].title ?? ""
        return PagingIndexItem(index: index, title: title)
    }
    
    func pagingViewController(_: PagingViewController, viewControllerAt index: Int) -> UIViewController {
        return viewControllers[index]
        //        return ContentViewController(title: viewControllers[index].title ?? "test")
    }
    
    func numberOfViewControllers(in _: PagingViewController) -> Int {
        return viewControllers.count
    }
    
    

}




