import Foundation
import SkipFuse
import SwiftUI

/// A logger for the IBunnySparks module.
let logger: Logger = Logger(subsystem: "bundle.id.IBunnySparks", category: "IBunnySparks")

/// The shared top-level view for the app, loaded from the platform-specific App delegates below.
/* SKIP @bridge */public struct IBunnySparksRootView : View {
    /* SKIP @bridge */public init() {
    }

    public var body: some View {
        MainContentView()
            .task {
                logger.info("Bunny Sparks app started - recording creative ideas across platforms!")
            }
    }
}

/// Global application delegate functions.
/* SKIP @bridge */public final class IBunnySparksAppDelegate : Sendable {
    /* SKIP @bridge */public static let shared = IBunnySparksAppDelegate()

    private init() {
    }

    /* SKIP @bridge */public func onInit() {
        logger.debug("Bunny Sparks initializing")
    }

    /* SKIP @bridge */public func onLaunch() {
        logger.debug("Bunny Sparks launched")
    }

    /* SKIP @bridge */public func onResume() {
        logger.debug("Bunny Sparks resumed")
    }

    /* SKIP @bridge */public func onPause() {
        logger.debug("Bunny Sparks paused")
    }

    /* SKIP @bridge */public func onStop() {
        logger.debug("Bunny Sparks stopped")
    }

    /* SKIP @bridge */public func onDestroy() {
        logger.debug("Bunny Sparks destroyed")
    }

    /* SKIP @bridge */public func onLowMemory() {
        logger.debug("Bunny Sparks low memory warning")
    }
}
