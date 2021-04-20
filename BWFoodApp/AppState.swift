/*
 AppState
 
 We could use NotificationManager here by passing a selector, but this actually checks to make sure
 that the observer implements the required pattern and is therefore more safe.
 */

import Foundation

protocol AppStateObserver {
    func applicationDidBecomeActive()
    func applicationDidBecomeInactive()
}

class AppState {
    private var observers:[AppStateObserver] = []
    
    public func notifyApplicationDidBecomeActive() {
        for observer in observers {
            observer.applicationDidBecomeActive()
        }
    }
    
    public func notifyApplicationDidBecomeInactive() {
        for observer in observers {
            observer.applicationDidBecomeInactive()
        }
    }
    
    public func addObserver(observer:AppStateObserver) {
        observers.append(observer)
    }
    
    static let shared = AppState()
    private init() {
    }
}
