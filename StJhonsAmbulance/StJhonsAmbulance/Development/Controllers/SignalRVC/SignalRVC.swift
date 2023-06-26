//
//  SignalRVC.swift
//  StJhonsAmbulance
//
//  Created by Umair Yousaf on 11/06/2023.
//

import UIKit
//import Starscream
import SwiftSignalRClient


class SignalRVC: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    var isConnected = false
//    var socket : WebSocket!
    
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var txtMessage: UITextField!
    
    @IBOutlet weak var btnSend: UIButton!
    // Update the Url accordingly
    private let serverUrl = "https://sjasignalr.azurewebsites.net/chathub"  // /chat or /chatLongPolling or /chatWebSockets
    private let dispatchQueue = DispatchQueue(label: "hubsamplephone.queue.dispatcheueuq")

    private var chatHubConnection: HubConnection?
    private var chatHubConnectionDelegate: HubConnectionDelegate?
    private var name = ""
    private var messages: [String] = []
    private var reconnectAlert: UIAlertController?
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.register(UINib(nibName: "SignalRTVC", bundle: nil), forCellReuseIdentifier: "SignalRTVC")
//        let client = SwiftSignalRClient.HttpConnectionOptions()
//        client.skipNegotiation = true
        
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
    let alert = UIAlertController(title: "Enter your Name", message:"", preferredStyle: UIAlertController.Style.alert)
    alert.addTextField() { textField in textField.placeholder = "Name"}
    let OKAction = UIAlertAction(title: "OK", style: .default) { action in
        self.name = alert.textFields?.first?.text ?? "John Doe"

        self.chatHubConnectionDelegate = ChatHubConnectionDelegate(controller: self)
        self.chatHubConnection = HubConnectionBuilder(url: URL(string: self.serverUrl)!)
            .withLogging(minLogLevel: .debug)
            .withAutoReconnect()
            .withHubConnectionDelegate(delegate: self.chatHubConnectionDelegate!)
            .withHttpConnectionOptions(configureHttpOptions: { httpConnectionOptions in
                httpConnectionOptions.skipNegotiation = true
                
                
                
            })
            .build()

        self.chatHubConnection!.on(method: "NewMessage", callback: {(user: String, message: String) in
            self.appendMessage(message: "\(user): \(message)")
        })
        self.chatHubConnection!.start()
    }
    alert.addAction(OKAction)
    self.present(alert, animated: true)
}

override func viewWillDisappear(_ animated: Bool) {
    chatHubConnection?.stop()
}

override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
}

@IBAction func btnSend(_ sender: Any) {
    let message = txtMessage.text
    if message != "" {
        chatHubConnection?.invoke(method: "Broadcast", name, message) { error in
            if let e = error {
                self.appendMessage(message: "Error: \(e)")
            }
        }
        txtMessage.text = ""
    }
}

private func appendMessage(message: String) {
    self.dispatchQueue.sync {
        self.messages.append(message)
    }

    self.tableView.beginUpdates()
    self.tableView.insertRows(at: [IndexPath(row: messages.count - 1, section: 0)], with: .automatic)
    self.tableView.endUpdates()
    self.tableView.scrollToRow(at: IndexPath(item: messages.count-1, section: 0), at: .bottom, animated: true)
}

fileprivate func connectionDidOpen() {
    toggleUI(isEnabled: true)
}

fileprivate func connectionDidFailToOpen(error: Error) {
    blockUI(message: "Connection failed to start.", error: error)
}

fileprivate func connectionDidClose(error: Error?) {
    if let alert = reconnectAlert {
        alert.dismiss(animated: true, completion: nil)
    }
    blockUI(message: "Connection is closed.", error: error)
}

fileprivate func connectionWillReconnect(error: Error?) {
    guard reconnectAlert == nil else {
        print("Alert already present. This is unexpected.")
        return
    }

    reconnectAlert = UIAlertController(title: "Reconnecting...", message: "Please wait", preferredStyle: .alert)
    self.present(reconnectAlert!, animated: true, completion: nil)
}

fileprivate func connectionDidReconnect() {
    reconnectAlert?.dismiss(animated: true, completion: nil)
    reconnectAlert = nil
}

func blockUI(message: String, error: Error?) {
    var message = message
    if let e = error {
        message.append(" Error: \(e)")
    }
    appendMessage(message: message)
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
    let cell = tableView.dequeueReusableCell(withIdentifier: "SignalRTVC", for: indexPath) as! SignalRTVC
    let row = indexPath.row
    cell.lblMessage?.text = messages[row]
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
