//
//  ContentView.swift
//  GroceryDeliveryApp
//
//  Created by Batikan Sosun on 13.08.2022.
//

import SwiftUI
import ActivityKit

struct ContentView: View {
    @State var  activities = Activity<GroceryDeliveryAppAttributes>.activities
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Text("Create an activity to start a live activity on the lock screen.")
                    Button(action: {
                        createActivity()
                    }) {
                        Text("Create Activity").font(.headline)
                    }.tint(.green)
                    Button(action: {
                        listAllDeliveries()
                    }) {
                        Text("List All Activities").font(.headline)
                    }.tint(.green)
                    Button(action: {
                        endAllActivity()
                        listAllDeliveries()
                    }) {
                        Text("End All Activites").font(.headline)
                    }.tint(.green)
                }
                Section {
                    if !activities.isEmpty {
                        Text("Live Activities")
                    }
                    List(activities) { activity in
                        let courierName = activity.contentState.courierName
                        let deliveryTime = activity.contentState.deliveryTime.formatted()
                        HStack(alignment: .center) {
                            Text(courierName)
                            Text(deliveryTime.description)
                            Text("update")
                                .font(.headline)
                                .foregroundColor(.green)
                                .onTapGesture {
                                    update(activity: activity)
                                    listAllDeliveries()
                                }
                            Text("end")
                                .font(.headline)
                                .foregroundColor(.green)
                                .onTapGesture {
                                    end(activity: activity)
                                    listAllDeliveries()
                                }
                        }
                    }
                }
            }
            .navigationTitle("Welcome!")
            .fontWeight(.ultraLight)
        }
        
    }
    
    func createActivity() {
        let attributes = GroceryDeliveryAppAttributes(numberOfGroceyItems: 12)
        let contentState = GroceryDeliveryAppAttributes.LiveDeliveryData(courierName: "Mike", deliveryTime: .now + 120)
        do {
            let _ = try Activity<GroceryDeliveryAppAttributes>.request(
                attributes: attributes,
                contentState: contentState,
                pushType: nil)
        } catch (let error) {
            print(error.localizedDescription)
        }
    }
    func update(activity: Activity<GroceryDeliveryAppAttributes>) {
        Task {
            let updatedStatus = GroceryDeliveryAppAttributes.LiveDeliveryData(courierName: "Adam",
                                                                              deliveryTime: .now + 150)
            await activity.update(using: updatedStatus)
        }
    }
    
    func end(activity: Activity<GroceryDeliveryAppAttributes>) {
        Task {
            await activity.end(dismissalPolicy: .immediate)
        }
    }
    func endAllActivity() {
        Task {
            for activity in Activity<GroceryDeliveryAppAttributes>.activities{
                await activity.end(dismissalPolicy: .immediate)
            }
        }
    }
    func listAllDeliveries() {
        var activities = Activity<GroceryDeliveryAppAttributes>.activities
        activities.sort { $0.id > $1.id }
        self.activities = activities
    }
}

