//
//  FeedDetailView.swift
//  MovieDemo
//
//  Created by Sandeep on 11/02/24.
//

import SwiftUI
import AVKit

struct FeedDetailView: View {
    @State var feed: Feed
    @State private var player: AVPlayer?
    @State private var isPlayingInline: Bool = false
    @State private var currentOrientation: UIDeviceOrientation?

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    if let previewLink = feed.previewLink, let previewURL = URL(string: previewLink.attributes.href) {
                            VideoPlayer(player: player)
                            .onAppear {
                                let player = AVPlayer(url: previewURL)
                                self.player = player
                                if !isPlayingInline {
                                    player.play()
                                }
                            }
                            .onDisappear() {
                                player?.pause()
                            }
                            .opacity(!isPlayingInline ? 1.0 : 0.0) // Use opacity to hide/show
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth:  UIScreen.main.bounds.width)
                            .background(.black)
                    }
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
                                .font(.title2)
                                .bold()
                                .foregroundColor(.primary)
                            Text(feed.category.attributes.label)
                                .font(.title3)
                                .lineLimit(2)
                                .foregroundColor(.primary)

                            HStack {
                                Text(feed.imPrice.label)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding(4)
                                    .bold()
                                    .background(.primary, in: RoundedRectangle(cornerRadius: 4))

                                Text("Preview")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding(4)
                                    .bold()
                                    .background(.teal, in: RoundedRectangle(cornerRadius: 4))
                                    .onTapGesture {
                                        toggleInlinePlay()
                                    }
                            }
                            Spacer()

                            Text(feed.imReleaseDate.attributes.label)
                                .foregroundColor(.gray)

                        }
                        Spacer()
                    }
                    .padding()
                    .frame(height: 170)
                }
                VStack(alignment: .leading, spacing: 12) {
                    Text(feed.summary.label)
                        .font(.headline)
                        .foregroundColor(.primary)

                    Text(feed.imArtist.label)
                        .font(.callout)
                        .bold()
                        .foregroundColor(.secondary)

                    if let rights = feed.rights?.label {
                        Text(rights)
                            .font(.caption)
                            .bold()
                            .foregroundColor(.primary)
                    }
                }
                .padding()

                Spacer()
            }
        }
        .sheet(isPresented: $isPlayingInline, onDismiss: {
            isPlayingInline = false
        }) {
            if let previewLink = feed.previewLink {
                AVPlayerViewControllerContainer(player: player, previewLink: previewLink, isPlayingInline: $isPlayingInline)

            }
        }

    }

    func toggleInlinePlay() {
        isPlayingInline.toggle()
        if isPlayingInline {
            player?.play()
        } else {
            player?.pause()
        }
    }
}

#Preview {
    if let feed = Feed.dummy() {
        FeedDetailView(feed: feed)
    } else {
        Text("Detailed Failed")
    }
}
