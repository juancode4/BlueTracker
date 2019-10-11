//
//  ViewController.swift
//  BlueTracker
//
//  Created by Juan Navarro on 10/2/19.
//  Copyright © 2019 Juan Navarro. All rights reserved.
//

import UIKit
import CoreBluetooth

class BlueTrackerViewController: UITableViewController, CBCentralManagerDelegate {
    
    let cellId = "cellId"
    var products: [Products] = [Products]()
    var centralManager: CBCentralManager?
    var RSSIs: [NSNumber] = []
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.refresh, target: self, action: #selector(refreshTapped))
        navigationItem.title = "Blue Tracker"
        self.navigationController?.navigationBar.isTranslucent = false
        
        tableView.register(ProductCell.self, forCellReuseIdentifier: cellId)
        
        centralManager = CBCentralManager(delegate: self, queue: nil)
        
    }
    
    //TABLEVIEW CODE
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return products.count
       }
       
       override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ProductCell
           let currentLastItem = products[indexPath.row]
           cell.product = currentLastItem
        
           return cell
       }
       
       override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 100
       }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(products)
        print("###################")
    }
    
    //CBCENTRALMANAGER CODE
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        
       if let name = peripheral.name{
            products.append(Products(productName: name, productRSSI:  NSString(format: "%d", RSSIs) as String))
            print(name)
            print("////")
            print(peripheral.identifier.uuidString)
            print("////")
            print(NSString(format: "%d", RSSIs) as String)

        } else {
            products.append(Products(productName: peripheral.identifier.uuidString, productRSSI: NSString(format: "%d", RSSIs) as String))
            print(peripheral.identifier.uuidString)
        }
        
        tableView.reloadData()

        print("**************")
        
        
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn{
            //working
            startScan()
            startTimer()
            
        } else {
            //not working
           let alertVC = UIAlertController(title: "Bluetooth is not working", message: "Make sure your bluetooth is ready to rock N' roll!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                alertVC.dismiss(animated: true, completion: nil)
            }
                alertVC.addAction(okAction)
                present(alertVC, animated: true, completion: nil)
            }
        }
    
    

    
    @objc func refreshTapped(){
        print("REFRESHED TAPPED")
        startScan()
        startTimer()
        
    }
    
    func startTimer(){
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true, block: { (timer) in
            self.startScan()
        })
        
    }
    
    func startScan(){
        products = []
        //RSSIs = []
        tableView.reloadData()
        centralManager?.stopScan()
        centralManager?.scanForPeripherals(withServices: nil, options: nil)
        
    }
    
    func createDummyData(){
        products.append(Products(productName: "Juans Iphone", productRSSI: "354ferr7894y"))
    }


}





