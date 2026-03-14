//
//  ContentViewModel.swift
//  TempMeter
//
//  Created by Emil Piórkowski on 14/03/2026.
//

import Foundation
import Combine

@MainActor
class ContentViewModel: ObservableObject {
    @Published var insideTemp = 0
    @Published var outsideTemp = 0
    @Published var humidity = 0
    @Published var pressure = 0
    var isRunning = false
    
    func start() async {
        isRunning = true
        
        Task {
            await insideTempSimulation()
        }
        
        Task {
            await outsideTempSimulation()
        }
        
        Task {
            await showHumidity()
        }
        
        Task {
            await showPressure()
        }
    }
    
    func stop() {
        isRunning = false
        
        insideTemp = 0
        outsideTemp = 0
        humidity = 0
        pressure = 0
    }
    
    
    func insideTempSimulation() async{
        while isRunning {
            insideTemp = Int(Double.random(in: 20.00...30.00))
            
            try? await Task.sleep(nanoseconds: 2_000_000_000)
        }
    }
    
    func outsideTempSimulation() async {
        while isRunning {
            outsideTemp = Int(Double.random(in: -13.00...30.00))
            
            try? await Task.sleep(nanoseconds: 2_000_000_000)
        }
    }
    
    func showHumidity() async {
        while isRunning {
            humidity = Int.random(in: 0...100)
            
            try? await Task.sleep(nanoseconds: 2_000_000_000)
        }
    }
    
    func showPressure() async {
        while isRunning {
            pressure = Int.random(in: 870...1055)
            
            try? await Task.sleep(nanoseconds: 2_000_000_000)
        }
    }
}
