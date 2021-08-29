//
//  NetworkManager.swift
//  NetworkManagerSwiftUI
//
//  Created by Кирилл Заборский on 29.08.2021.
//

import Foundation
import Network

class NetworkManager: ObservableObject {
    
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "NetworkManager")
    
    @Published var isConnected = true
    
    var imageName: String {
        return isConnected ? "wifi" : "wifi.slash"
    }
    
    var connectionDiscription: String {
        if isConnected {
            return "Интернет соединение успешно установлено"
        } else {
            return "Соединение с интернетом отсутсвует"
        }
    }
    
    init() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isConnected = path.status == .satisfied
            }
            
        }
        monitor.start(queue: queue)
    }
}
