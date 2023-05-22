//
//  CalenderHourVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 21/05/2023.
//

import UIKit
import EventKit

class CalenderHourVC: ENTALDBaseViewController, KVKCalendarSettings, KVKCalendarDataModel, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var btnViewAllEvent: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    var scheduleData : [ScheduleModelThree] = []
    var formatter = DateFormatter()
    
    var events = [Event]() {
        didSet {
            calendarView.reloadData()
        }
    }
    var selectDate : Date = Date()
    var style: Style {
        createCalendarStyle(selectedDate: selectDate)
    }
    var eventViewer = EventViewer()
    
    private lazy var reloadStyle: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reloadCalendarStyle))
        button.tintColor = .systemRed
        return button
    }()
    
    private lazy var calendarView: KVKCalendarView = {
        var frame = view.frame
        frame.origin.y = 0
        let calendar = KVKCalendarView(frame: frame, date: selectDate, style: style)
        calendar.delegate = self
        calendar.dataSource = self
        
        return calendar
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let data = self.dataModel as? [ScheduleModelThree] {
            self.scheduleData = data
        }
    
        if self.ifEventsHave(date: selectDate).count > 0 {
            self.btnViewAllEvent.isHidden = false
        }else{
            self.btnViewAllEvent.isHidden = true
        }
        navigationItem.title = "Scheduals"
        view.backgroundColor = .systemBackground
        containerView.addSubview(calendarView)
        
        loadEvents(data:self.scheduleData, dateFormat: style.timeSystem.format) { (events) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
                self?.events = events
            }
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        var frame = containerView.frame
        frame.origin.y = 0
        calendarView.reloadFrame(frame)
    }
    
    @objc private func reloadCalendarStyle() {
        var updatedStyle = calendarView.style
        updatedStyle.timeSystem = calendarView.style.timeSystem == .twentyFour ? .twelve : .twentyFour
        calendarView.updateStyle(updatedStyle)
        calendarView.reloadData()
    }
    
    @available(iOS 14.0, *)
    private func createCalendarTypesMenu() -> UIMenu {
        let actions: [UIMenuElement] = [CalendarType.month, CalendarType.day].compactMap { (item) in
            UIAction(title: item.title, state: item == calendarView.selectedType ? .on : .off) { [weak self] (_) in
                guard let self = self else { return }
                self.calendarView.set(type: item, date: self.selectDate)
                self.calendarView.reloadData()
            }
        }
        return UIMenu(children: actions)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        // to track changing windows and theme of device
        
        loadEvents(data:self.scheduleData, dateFormat: style.timeSystem.format) { [weak self] (events) in
            if let style = self?.style {
                self?.calendarView.updateStyle(style)
            }
            self?.events = events
        }
    }
    
    @IBAction func btnToday(_ sender: Any) {
        selectDate = Date()
        calendarView.scrollTo(selectDate, animated: true)
        calendarView.reloadData()
    }
    
    @IBAction func viewAllBtnAction(_ sender: Any) {
        let events = self.ifEventsHave(date: selectDate)
        
        ENTALDControllers.shared.showAchivementScreen(type: .ENTALDPRESENT_POPOVER, from: self, dataObj: events, engagementType: .Calender, callBack: {params,controller in
            controller?.dismiss(animated: false)

            if let model = params as? ScheduleModelThree {
                DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
                    ENTALDControllers.shared.showVolunteerEventDetailScreen(type: .ENTALDPUSH, from: self, dataObj: model, eventType: "calender", callBack: nil)
                })
            }
        })
    }
    
    
    @IBAction func backTapped(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
}


// MARK: - Calendar delegate

extension CalenderHourVC: CalendarDelegate {
    func didChangeEvent(_ event: Event, start: Date?, end: Date?) {
        if let result = handleChangingEvent(event, start: start, end: end) {
            events.replaceSubrange(result.range, with: result.events)
        }
    }
    
    func ifEventsHave(date: Date)->[ScheduleModelThree]{
        var selectedEvent : [ScheduleModelThree] = []
        for i in (0..<(scheduleData.count)) {
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
            if let event = formatter.date(from: scheduleData[i].sjavms_start ?? ""){
                
                let newFormatter = DateFormatter()
                newFormatter.dateFormat = "yyyy-MM-dd"
                
                var eventDate = newFormatter.string(from: event)
                var calenderDate = newFormatter.string(from: date)
                
                
                if eventDate == calenderDate {
                    selectedEvent.append(scheduleData[i])
                }
            }
        }
        
        return selectedEvent
    }
    
    func didSelectDates(_ dates: [Date], type: CalendarType, frame: CGRect?) {
        selectDate = dates.first ?? Date()
        self.calendarView.set(type: CalendarType.day, date: self.selectDate)
        calendarView.reloadData()
        
        if self.ifEventsHave(date: selectDate).count > 0 {
            self.btnViewAllEvent.isHidden = false
        }else{
            self.btnViewAllEvent.isHidden = true
        }
    }
    
    func didSelectEvent(_ event: Event, type: CalendarType, frame: CGRect?) {
        print(type, event)
        switch type {
        case .day:
            if let event = self.scheduleData.filter({$0.msnfp_participationscheduleid == event.ID}).first {
                ENTALDControllers.shared.showVolunteerEventDetailScreen(type: .ENTALDPUSH, from: self, dataObj: event, eventType: "calender", callBack: nil)
            }
        default:
            break
        }
    }
    
    func didDeselectEvent(_ event: Event, animated: Bool) {
        
        
    }
    
    func didSelectMore(_ date: Date, frame: CGRect?) {
        print(date)
    }
    
    func didChangeViewerFrame(_ frame: CGRect) {
        eventViewer.reloadFrame(frame: frame)
    }
    
    func didAddNewEvent(_ event: Event, _ date: Date?) {
        if let newEvent = handleNewEvent(event, date: date) {
            events.append(newEvent)
        }
    }
}

// MARK: - Calendar datasource

extension CalenderHourVC: CalendarDataSource {
    
    func willSelectDate(_ date: Date, type: CalendarType) {
        print(date, type)
    }
    
    @available(iOS 14.0, *)
    func willDisplayEventOptionMenu(_ event: Event, type: CalendarType) -> (menu: UIMenu, customButton: UIButton?)? {
        return nil
    }
    
    func eventsForCalendar(systemEvents: [EKEvent]) -> [Event] {
        // if you want to get a system events, you need to set style.systemCalendars = ["test"]
        handleEvents(systemEvents: systemEvents)
    }
    
    func willDisplayEventView(_ event: Event, frame: CGRect, date: Date?) -> EventViewGeneral? {
        handleCustomEventView(event: event, style: style, frame: frame)
    }
    
    func dequeueCell<T>(parameter: CellParameter, type: CalendarType, view: T, indexPath: IndexPath) -> KVKCalendarCellProtocol? where T: UIScrollView {
        handleCell(parameter: parameter, type: type, view: view, indexPath: indexPath)
    }
    
    func willDisplayEventViewer(date: Date, frame: CGRect) -> UIView? {
        eventViewer.frame = frame
        return eventViewer
    }
    
    func sizeForCell(_ date: Date?, type: CalendarType) -> CGSize? {
        handleSizeCell(type: type, stye: calendarView.style, view: containerView)
    }
    
    func subTitleForDate(date: Date) -> String {
        var eventCount = 0;
        for i in (0..<(scheduleData.count)) {
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
            if let event = formatter.date(from: scheduleData[i].sjavms_start ?? ""){
                
                let newFormatter = DateFormatter()
                newFormatter.dateFormat = "yyyy-MM-dd"
                
                let eventDate = newFormatter.string(from: event)
                let calenderDate = newFormatter.string(from: date)
                
                
                if eventDate == calenderDate {
                    eventCount += 1
                    
                }
            }
        }
        
        if  (eventCount > 0){
            return "\(eventCount) event(s)"
        }
        
        return ""
    }
}
