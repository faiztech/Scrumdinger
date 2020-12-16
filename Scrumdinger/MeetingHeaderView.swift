//
//  MeetingHeaderView.swift
//  Scrumdinger
//
//  Created by Mohammed Faizuddin on 16/12/2020.
//

import SwiftUI

struct MeetingHeaderView: View {
    @Binding var secondsElapsed: Int
    @Binding var secondsRemaining: Int

    //calculating progress and updating progress view
    private var progress: Double {
        guard secondsRemaining > 0 else { return 1 }
        let totalSeconds = Double(secondsRemaining + secondsElapsed)
        return Double(secondsElapsed) / totalSeconds
    }
    private var minutesRemaining: Int {
        secondsRemaining / 60
    }
    private var minutesRemaningMetric: String {
        minutesRemaining == 1 ? "minute" : "minutes"
    }

    var body: some View {
        VStack {
            ProgressView(value: progress)
            HStack {
                VStack(alignment: .leading) {
                    Text("Seconds Elapsed")
                        .font(.caption)
                    Label("\(secondsElapsed)", systemImage: "hourglass.bottomhalf.fill")
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Seconds Remaining")
                        .font(.caption)
                    Label("\(secondsRemaining)", systemImage: "hourglass.tophalf.fill")
                }
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(Text("Time remaining"))
        .accessibilityValue(Text("\(minutesRemaining) \(minutesRemaningMetric)"))
    }
}

struct MeetingHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingHeaderView(secondsElapsed: .constant(60), secondsRemaining: .constant(300))
            .previewLayout(.sizeThatFits)
    }
}
