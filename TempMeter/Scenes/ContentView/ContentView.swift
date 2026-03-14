//
//  ContentView.swift
//  TempMeter
//
//  Created by Emil Piórkowski on 14/03/2026.
//

import SwiftUI


struct ContentView: View {

    @StateObject private var vm = ContentViewModel()
    @State private var simulationRunning = false

    var body: some View {
        VStack(spacing: 50) {
            
       
            HStack(spacing: 30) {
                
                VStack(spacing: 30) {
                    ValueBox(value: vm.insideTemp, title: "Inside")
                    ValueBox(value: vm.outsideTemp, title: "Outside")
                }
                
                VStack(spacing: 30) {
                    ValueBox(value: vm.humidity, title: "Humidity")
                    ValueBox(value: vm.pressure, title: "Pressure")
                }
            }
            
            
            HStack(spacing: 50) {
                
                Button {
                    simulationRunning = true
                    Task {
                        await vm.start()
                    }
                } label: {
                    Text("Start Simulation")
                        .foregroundStyle(.white)
                        .frame(width: 150, height: 50)
                        .background(
                            Capsule()
                                .fill(.green)
                        )
                }
                .disabled(simulationRunning)
                
                Button {
                    vm.stop()
                    simulationRunning = false
                } label: {
                    Text("Stop Simulation")
                        .foregroundStyle(.white)
                        .frame(width: 150, height: 50)
                        .background(
                            Capsule()
                                .fill(simulationRunning ? .red : .gray)
                        )
                }
                .disabled(!simulationRunning) 
            }
        }
        .padding(50)
    }
}


struct ValueBox: View {
    let value: Int
    let title: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(.blue)
                .frame(width: 120, height: 80)
            VStack {
                Text(title)
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.7))
                Text("\(value)")
                    .font(.title)
                    .foregroundStyle(.white)
            }
        }
    }
}

#Preview {
    ContentView()
}
