//
//  FeedView.swift
//  MovieDemo
//
//  Created by Sandeep on 11/02/24.
//

import Foundation
import SwiftUI

struct FeedView: View {
    @State var feed: Feed
    var body: some View {
        VStack {
            HStack {

                AsyncImage(url: feed.imImage.last?.url, scale: 1) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: 113, maxHeight: 170)
                } placeholder: {
                    ProgressView()
                }


                VStack(alignment: .leading, spacing: 5) {
                    Text(feed.title.label)
                        .font(.title3)
                        .bold()
                        .lineLimit(2)
                        .foregroundColor(.primary)
                    Text(feed.summary.label)
                        .font(.subheadline)
                        .lineLimit(2)
                        .foregroundColor(.primary)

                    Text(feed.imPrice.label)
                        .font(.headline)
                        .bold()
                        .foregroundColor(.white)
                        .padding(4)
                        .background(.primary, in: RoundedRectangle(cornerRadius: 4))

                    Spacer()
                    Text(feed.imReleaseDate.attributes.label)
                        .foregroundColor(.gray)

                }
                Spacer()
            }
            .frame(height: 170)
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    if let feed = Feed.dummy() {
        FeedView(feed: feed)
    } else {
        Text("Failed")
    }
}
