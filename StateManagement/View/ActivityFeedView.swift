//
//  ActivityFeedView.swift
//  StateManagement
//
//  Created by Priyal PORWAL on 14/11/22.
//

import SwiftUI

struct ActivityFeedView: View {
    @EnvironmentObject var state: Store<AppState>
    var body: some View {
        List {
            ForEach(state.value.activityFeed,
                    id: \.timestamp) { activity in
                HStack {
                    Text(activity.description)
                    Spacer()
                    Text(activity.timestamp.formatted())
                }
            }
        }
        .navigationTitle("Activity Feed")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ActivityFeedView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityFeedView()
    }
}
