//
//  SignalRVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 11/06/2023.
//

import UIKit
//import Starscream
import SwiftSignalRClient


class SignalRVC: ENTALDBaseViewController, UITableViewDelegate, UITableViewDataSource, HubConnectionDelegate  {

    var isConnected = false
    var eventId : String?
    var eventType : String?
//    var socket : WebSocket!
    let conId = UserDefaults.standard.contactIdToken ?? ""
    var scheduleData : ScheduleModelThree?

    var volunteerData : InAppVolunteerDataModel?
    
    @IBOutlet weak var txtMessage: UITextField!
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var btnSend: UIButton!
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var sendMsgView: UIView!
    
    // Update the Url accordingly
//    private let serverUrl = "https://4c6f-39-41-237-112.ngrok-free.app/chathub"  // /chat or /chatLongPolling or /chatWebSockets
    private let serverUrl = "https://sjasignalr.azurewebsites.net/chathub"
    private let dispatchQueue = DispatchQueue(label: "hubsamplephone.queue.dispatcheueuq")

    private var chatHubConnection: HubConnection?
    private var chatHubConnectionDelegate: HubConnectionDelegate?
    private var name = "Name"
    private var messages: [MessageArguments] = []
    private var reconnectAlert: UIAlertController?
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.register(UINib(nibName: "MessagesCell", bundle: nil), forCellReuseIdentifier: "MessagesCell")
        headerView.addBottomShadow()
        
        lblName.font = UIFont.HeaderBoldFont(14)
        lblName.textColor = UIColor.themeBlackText
        lblName.textColor = UIColor.headerGreen
        lblName.text = name
        lblStatus.font = UIFont.HeaderBoldFont(12)
        lblStatus.textColor = UIColor.textLightGrayColor
        lblStatus.textColor = UIColor.headerGreen
        lblStatus.text = "Online"
        sendMsgView.addHeaderShadow()
        if (eventType == "volunteer"){
            if let data = self.dataModel as? InAppVolunteerDataModel {
                self.volunteerData = data
                self.lblName.text = self.volunteerData?.fullname ?? ""
                self.lblName.text = self.volunteerData?.fullname ?? ""
                self.profileImg.image = ProcessUtils.shared.convertBase64StringToImage(imageBase64String: self.volunteerData?.entityimage ?? "") ?? UIImage(named: "ic_profile")
            }
        }else if (eventType == "event"){
            if let data = self.dataModel as? ScheduleModelThree {
                self.scheduleData = data
                self.lblName.text = self.scheduleData?.sjavms_VolunteerEvent?.msnfp_engagementopportunitytitle ?? ""
            }
        }
        
    }
    
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
        
//        messageConnection()
//        if let url = URL(string: "https://sjasignalr.azurewebsites.net/chathub"){
            
//            let _ = SignalRService(url: url)
//            SignalRService(url: url).conId
//        skipNegotiation: true
//            accesstokkenfactory token    contactid will be token
//        }

 
override func viewDidAppear(_ animated: Bool) {
    getchatMessage()
        self.name = "\(UserDefaults.standard.contactIdToken ?? "")"

        self.chatHubConnectionDelegate = ChatHubConnectionDelegate(controller: self)
        let appendQuery = "\(self.serverUrl)?access_token=\(self.name)"
        self.chatHubConnection = HubConnectionBuilder(url: URL(string: appendQuery)!)
            .withLogging(minLogLevel: .debug)
            .withAutoReconnect()
            .withHubConnectionDelegate(delegate: self.chatHubConnectionDelegate!)
            .withHttpConnectionOptions(configureHttpOptions: { httpConnectionOptions in
                httpConnectionOptions.skipNegotiation = true
                httpConnectionOptions.accessTokenProvider = {"\(UserDefaults.standard.contactIdToken ?? "")"}
            })
            .build()
        
        if let hub = self.chatHubConnection {
            hub.delegate = self
            // Set our callbacks for the messages we expect from the SignalR hub.
            hub.on(method: "newMessageReceived", callback: {[weak self] argumentExtractor in
                guard let self = self else {return}
                do {
                    let response = try argumentExtractor.getArgument(type: String.self)
                    if let model = response.parse(to: ChatMessage.self), let message = model.data {
                        self.appendMessage(model: message)
                        print("Response: \(message.message ?? "")")
                    }
                    
                    
                }catch(let error){
                    print(error)
                }
            })
            DispatchQueue.main.asyncAfter(deadline: .now()+5.0, execute: {
                hub.send(method: "addUserToGroups", [self.eventId]) { error in
                    if let err = error {
                        print("Invoke error \(err.localizedDescription)")
                    }
                }
            })
            
            hub.start()
        }
        
        
        
//        self.chatHubConnection?.on(method: "receiveBroadCastMessage", callback: {(user: String, message: String) in
//            self.appendMessage(message: "\(user): \(message)")
//        })
//
//
//        self.chatHubConnection!.start()

   
}

override func viewWillDisappear(_ animated: Bool) {
    chatHubConnection?.stop()
}

override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
}
    
    func saveChatMessage (messageTxt:String){
        let currentDate = DateFormatManager.shared.getCurrentDate()
        let dateStr = DateFormatManager.shared.formatDate(date: currentDate)
        
        let params : [String: Any] = [
                "sjavms_inappmessage_activity_parties": [
                    [
                        "partyid_contact@odata.bind": "/contacts(\(self.conId))",
                        "participationtypemask": 1
                    ] as [String : Any],
                    [
                        "partyid_contact@odata.bind": "/contacts(\(self.eventId ?? ""))",
                        "participationtypemask": 2
                    ]
                ],
                "subject": messageTxt,
                "sjavms_senton": "\(dateStr)"
            ]
        
        ENTALDLibraryAPI.shared.saveChatMessage(params: params){ result in
            switch result{
            case .success(value: _):
                debugPrint("message send")
            case .error(let error, let errorResponse):
                var message = error.message
                if let err = errorResponse {
                    message = err.error
                }
                
//                DispatchQueue.main.async {
//                    ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
//                }
            }
        }
}

    
    
    func getchatMessage (){
       
        let params : [String:Any] = [
            
//            ParameterKeys.select : "activityid,subject",
            ParameterKeys.expand : "sjavms_inappmessage_activity_parties($filter=(participationtypemask eq 1 and _partyid_value eq \(self.conId ))),sjavms_inappmessage_activity_parties($filter=(participationtypemask eq 2 and _partyid_value eq \(self.eventId ?? "")))",
            ParameterKeys.filter : "(sjavms_inappmessage_activity_parties/any(o1:(o1/participationtypemask eq 1 and o1/_partyid_value eq \(self.conId )))) and (sjavms_inappmessage_activity_parties/any(o2:(o2/participationtypemask eq 2 and o2/_partyid_value eq \(self.eventId ?? ""))))",
            ParameterKeys.orderby : "sjavms_senton desc"
        ]
        
        self.getMessagesData(params: params)
    
}
    

fileprivate func getMessagesData(params : [String:Any]){
    DispatchQueue.main.async {
        LoadingView.show()
    }
    
    ENTALDLibraryAPI.shared.requestChatMessages(params: params){ result in
        DispatchQueue.main.async {
            LoadingView.hide()
        }
        
        switch result{
        case .success(value: let response):
            
            if let messagesData = response.value {
                self.messages = messagesData.map({MessageArguments(subject:$0.subject, sjavms_senton: $0.sjavms_senton)})
                if (self.messages.count < 1){
                    self.showEmptyView(tableVw: self.tableView)
                }else{
                    
                    DispatchQueue.main.async {
                        for subview in self.tableView.subviews {
                            subview.removeFromSuperview()
                        }
                    }
                }
                DispatchQueue.main.async {
                    
                    self.tableView.reloadData()
                }
                
            }else{
                self.showEmptyView(tableVw: self.tableView)
            }
            
        case .error(let error, let errorResponse):
            var message = error.message
            if let err = errorResponse {
                message = err.error
            }
            self.showEmptyView(tableVw: self.tableView)
            DispatchQueue.main.async {
                ENTALDAlertView.shared.showAPIAlertWithTitle(title: "", message: message, actionTitle: .KOK, completion: {status in })
            }
        }
    }
}
    func showEmptyView(tableVw : UITableView){
        DispatchQueue.main.async {
            let view = EmptyView.instanceFromNib()
            view.frame = tableVw.frame
            tableVw.addSubview(view)
        }
    }
    
    @IBAction func baskTapped(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
@IBAction func btnSend(_ sender: Any) {
    let message = txtMessage.text
    if message != "" {
        
        chatHubConnection?.send(method: "sendMessageToUser", message, "\(eventId ?? "")" ,"\(UserDefaults.standard.userInfo?.fullname ?? "")", "test.jpg", sendDidComplete: { error in
            if let e = error {
                print("Sending Error \(e)")
            }else{
                let mess = MessageArguments(name: "\(UserDefaults.standard.userInfo?.fullname ?? "")", image: "test.jpg", subject: message)
                self.appendMessage(model: mess)
                self.saveChatMessage(messageTxt: message ?? "")
            }
        })
        
//        self.chatHubConnection!.on(method: "receiveBroadCastMessage", callback: {(user: String, message: String) in
//            self.appendMessage(message: "\(user): \(message)")
//        })
        
        txtMessage.text = ""
    }
    tableView.reloadData()
}

private func appendMessage(model: MessageArguments) {
    self.dispatchQueue.sync {
        self.messages.append(model)
    }

    self.tableView.beginUpdates()
    self.tableView.insertRows(at: [IndexPath(row: messages.count - 1, section: 0)], with: .automatic)
    self.tableView.endUpdates()
    self.tableView.scrollToRow(at: IndexPath(item: messages.count-1, section: 0), at: .bottom, animated: true)
}

fileprivate func connectionDidOpen() {
    toggleUI(isEnabled: true)
}
    
    func connectionDidOpen(hubConnection: SwiftSignalRClient.HubConnection) {
        
    }
    
    func connectionDidFailToOpen(error: Error) {
        
    }
    
    func connectionDidClose(error: Error?) {
        
    }
    
    func connectionDidOpen(connection: SwiftSignalRClient.Connection) {
        
    }
    
    func connectionDidReceiveData(connection: SwiftSignalRClient.Connection, data: Data) {
        print("Received Data")
    }

func blockUI(message: String, error: Error?) {
    var message = message
    if let e = error {
       print("Error \(e)")
    }
    toggleUI(isEnabled: false)
}

func toggleUI(isEnabled: Bool) {
    btnSend.isEnabled = isEnabled
    txtMessage.isEnabled = isEnabled
}

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    var count = -1
    dispatchQueue.sync {
        count = self.messages.count
    }
    return count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "MessagesCell", for: indexPath) as! MessagesCell
    let row = indexPath.row
    
//    cell.lbl.text = messages[row].name ?? ""
    cell.lblMessage?.text = messages[row].message ?? ""
    if (messages[row].subject != nil || messages[row].subject == "" ){
        cell.lblMessage?.text = messages[row].subject;
    }
    if let img =  messages[row].message {
        cell.userImage.image = ProcessUtils.shared.convertBase64StringToImage(imageBase64String: img)
    }
    
    
    return cell
}
}

class ChatHubConnectionDelegate: HubConnectionDelegate {

weak var controller: SignalRVC?

init(controller: SignalRVC) {
    self.controller = controller
}

func connectionDidOpen(hubConnection: HubConnection) {
    controller?.connectionDidOpen()
}

func connectionDidFailToOpen(error: Error) {
    controller?.connectionDidFailToOpen(error: error)
}

func connectionDidClose(error: Error?) {
    controller?.connectionDidClose(error: error)
}

func connectionWillReconnect(error: Error) {
    controller?.connectionWillReconnect(error: error)
}

func connectionDidReconnect() {
    controller?.connectionDidReconnect()
}
}
