//
//  MeetingFooterView.swift
//  Scrumdinger
//
//  Created by Mohammed Faizuddin on 16/12/2020.
//

import SwiftUI

struct MeetingFooterView: View {
    @Binding var speakers: [ScrumTimer.Speaker]
    var skipAction: () -> Void

    private var speakerNumber: Int? {
        guard let index = speakers.firstIndex(where: { !$0.isCompleted }) else { return nil }
        return index + 1
    }

    private var isLastSpeaker: Bool {
        speakers.dropLast().allSatisfy { $0.isCompleted }
    }

    private var speakerText: String {
        guard let speakerNumber = speakerNumber else { return "No more speakers" }
        return "Speaker \(speakerNumber) of \(speakers.count)"
    }

    var body: some View {
        VStack {
            HStack {
                if isLastSpeaker {
                    Text("Last Speaker")
                } else {
                    Text(speakerText)
                    Spacer()
                    Button(action: {
                        skipAction()
                    }) {
                        Image(systemName:"forward.fill")
                    }
                    .accessibilityLabel(Text("Next speaker"))
                }
            }
        }
        .padding([.bottom, .horizontal])
    }
}

struct MeetingFooterView_Previews: PreviewProvider {
    static var speakers = [ScrumTimer.Speaker(name: "Faiz", isCompleted: false), ScrumTimer.Speaker(name: "Afshan", isCompleted: false)]
    static var previews: some View {
        MeetingFooterView(speakers: .constant(speakers), skipAction: {})
            .previewLayout(.sizeThatFits)
    }
}
