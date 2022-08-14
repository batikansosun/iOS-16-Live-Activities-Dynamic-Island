//
//  DeliveryTrackWidget.swift
//  DeliveryTrackWidget
//
//  Created by Batikan Sosun on 13.08.2022.
//

import ActivityKit
import WidgetKit
import SwiftUI

@main
struct Widgets: WidgetBundle {
    var body: some Widget {
        GroceryDeliveryApp()
    }
}

struct GroceryDeliveryApp: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(attributesType: GroceryDeliveryAppAttributes.self) { context in
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .center) {
                        Text(context.state.courierName + " is on the way!").font(.headline)
                        Text("You ordered \(context.attributes.numberOfGroceyItems) grocery items.")
                            .font(.subheadline)
                        BottomLineView()
                    }
                }
            }.padding(15)
        }
    }
}
struct BottomLineView: View {
    var time = Date(timeInterval: TimeInterval(100), since: .now)
    var body: some View {
        HStack {
            Divider().frame(width: 50,
                            height: 10)
            .overlay(.gray).cornerRadius(5)
            Image("delivery")
            VStack {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(style: StrokeStyle(lineWidth: 1,
                                               dash: [4]))
                    .frame(height: 10)
                    .overlay(Text(time, style: .timer).font(.system(size: 8)).multilineTextAlignment(.center))
            }
            Image("home-address")
        }
    }
}
