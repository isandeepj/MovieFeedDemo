//
//  AVPlayerViewControllerContainer.swift
//  MovieDemo
//
//  Created by Sandeep on 13/02/24.
//

import SwiftUI
import AVKit

struct AVPlayerViewControllerContainer: UIViewControllerRepresentable {
    let player: AVPlayer?
    let previewLink: FeedLink
    @Binding var isPlayingInline: Bool

    func makeUIViewController(context: Context) -> UIViewController {
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        playerViewController.delegate = context.coordinator
        playerViewController.transitioningDelegate = context.coordinator
        return playerViewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(isPlayingInline: $isPlayingInline, player: player)
    }

    class Coordinator: NSObject, AVPlayerViewControllerDelegate, UIViewControllerTransitioningDelegate {
        @Binding var isPlayingInline: Bool
        var player: AVPlayer?

        init(isPlayingInline: Binding<Bool>, player: AVPlayer?) {
            _isPlayingInline = isPlayingInline
            self.player = player
        }

        func playerViewControllerDidDismiss(_ playerViewController: AVPlayerViewController) {
            player?.pause()
            isPlayingInline = false
        }

        func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
            player?.pause()
            isPlayingInline = false
            return nil
        }

    }
}
