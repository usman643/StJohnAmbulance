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
    
    
    var isConnected = false
    var eventId : String?
//    var socket : WebSocket!
    
    
    @IBOutlet weak var txtMessage: UITextField!
    
    @IBOutlet weak var btnSend: UIButton!
    // Update the Url accordingly
//    private let serverUrl = "https://4c6f-39-41-237-112.ngrok-free.app/chathub"  // /chat or /chatLongPolling or /chatWebSockets
    private let serverUrl = "https://sjasignalr.azurewebsites.net/chathub"
    private let dispatchQueue = DispatchQueue(label: "hubsamplephone.queue.dispatcheueuq")

    private var chatHubConnection: HubConnection?
    private var chatHubConnectionDelegate: HubConnectionDelegate?
    private var name = ""
    private var messages: [MessageArguments] = []
    private var reconnectAlert: UIAlertController?
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.register(UINib(nibName: "MessagesCell", bundle: nil), forCellReuseIdentifier: "MessagesCell")
        
        
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
                let mess = MessageArguments(name: "\(UserDefaults.standard.userInfo?.fullname ?? "")", image: "test.jpg", message: message)
                self.appendMessage(model: mess)
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

//fileprivate func connectionDidFailToOpen(error: Error) {
//    blockUI(message: "Connection failed to start.", error: error)
//}
//
//fileprivate func connectionDidClose(error: Error?) {
//    if let alert = reconnectAlert {
//        alert.dismiss(animated: true, completion: nil)
//    }
//    blockUI(message: "Connection is closed.", error: error)
//}
//
//fileprivate func connectionWillReconnect(error: Error?) {
//    guard reconnectAlert == nil else {
//        print("Alert already present. This is unexpected.")
//        return
//    }
//
//    reconnectAlert = UIAlertController(title: "Reconnecting...", message: "Please wait", preferredStyle: .alert)
//    self.present(reconnectAlert!, animated: true, completion: nil)
//}
//
//fileprivate func connectionDidReconnect() {
//    reconnectAlert?.dismiss(animated: true, completion: nil)
//    reconnectAlert = nil
//}

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
    
    cell.lblName.text = messages[row].name ?? ""
    cell.lblMessage?.text = messages[row].message ?? ""
    
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
