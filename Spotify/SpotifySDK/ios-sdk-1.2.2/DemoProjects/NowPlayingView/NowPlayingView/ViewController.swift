import UIKit
import StoreKit

class ViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet var buttons: [UIButton]!

    @IBOutlet var skipBackward15Button: UIButton!
    @IBOutlet var prevButton: UIButton!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var skipForward15Button: UIButton!

    @IBOutlet var podcastSpeedButton: UIButton!
    @IBOutlet weak var playRadioButton: UIButton!

    @IBOutlet weak var playerStateSubscriptionButton: UIButton!
    @IBOutlet weak var onDemandCapabilitiesLabel: UILabel!
    @IBOutlet weak var capabilitiesSubscriptionButton: UIButton!

    @IBOutlet weak var shuffleModeLabel: UILabel!
    @IBOutlet weak var toggleShuffleButton: UIButton!
    @IBOutlet weak var repeatModeLabel: UILabel!
    @IBOutlet weak var toggleRepeatModeButton: UIButton!
    @IBOutlet weak var albumArtImageView: UIImageView!

    // MARK: - Variables
    private let playURI = "spotify:album:1htHMnxonxmyHdKE2uDFMR"
    private let trackIdentifier = "spotify:track:32ftxJzxMPgUFCM6Km9WTS"
    private let name = "Now Playing View"

    private var currentPodcastSpeed: SPTAppRemotePodcastPlaybackSpeed?
    private var connectionIndicatorView = ConnectionStatusIndicatorView()
    private var playerState: SPTAppRemotePlayerState?
    private var subscribedToPlayerState: Bool = false
    private var subscribedToCapabilities: Bool = false

    var defaultCallback: SPTAppRemoteCallback {
        get {
            return {[weak self] _, error in
                if let error = error {
                    self?.displayError(error as NSError)
                }
            }
        }
    }

    var appRemote: SPTAppRemote? {
        get {
            return (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.appRemote
        }
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: connectionIndicatorView)
        connectionIndicatorView.frame = CGRect(origin: CGPoint(), size: CGSize(width: 20,height: 20))

        playPauseButton.setTitle("", for: UIControl.State.normal);
        playPauseButton.setImage(PlaybackButtonGraphics.playButtonImage(), for: UIControl.State.normal)
        playPauseButton.setImage(PlaybackButtonGraphics.playButtonImage(), for: UIControl.State.highlighted)

        nextButton.setTitle("", for: UIControl.State.normal)
        nextButton.setImage(PlaybackButtonGraphics.nextButtonImage(), for: UIControl.State.normal)
        nextButton.setImage(PlaybackButtonGraphics.nextButtonImage(), for: UIControl.State.highlighted)

        prevButton.setTitle("", for: UIControl.State.normal)
        prevButton.setImage(PlaybackButtonGraphics.previousButtonImage(), for: UIControl.State.normal)
        prevButton.setImage(PlaybackButtonGraphics.previousButtonImage(), for: UIControl.State.highlighted)

        skipBackward15Button.setImage(skipBackward15Button.imageView?.image?.withRenderingMode(.alwaysTemplate), for: .normal)
        skipForward15Button.setImage(skipForward15Button.imageView?.image?.withRenderingMode(.alwaysTemplate), for: .normal)
        skipBackward15Button.isHidden = true
        skipForward15Button.isHidden = true
    }

    // MARK: - View
    private func updateViewWithPlayerState(_ playerState: SPTAppRemotePlayerState) {
        updatePlayPauseButtonState(playerState.isPaused)
        updateRepeatModeLabel(playerState.playbackOptions.repeatMode)
        updateShuffleLabel(playerState.playbackOptions.isShuffling)
        trackNameLabel.text = playerState.track.name + " - " + playerState.track.artist.name
        fetchAlbumArtForTrack(playerState.track) { (image) -> Void in
            self.updateAlbumArtWithImage(image)
        }
        updateViewWithRestrictions(playerState.playbackRestrictions)
        updateInterfaceForPodcast(playerState: playerState)
    }

    private func updateViewWithRestrictions(_ restrictions: SPTAppRemotePlaybackRestrictions) {
        nextButton.isEnabled = restrictions.canSkipNext
        prevButton.isEnabled = restrictions.canSkipPrevious
        toggleShuffleButton.isEnabled = restrictions.canToggleShuffle
        toggleRepeatModeButton.isEnabled = restrictions.canRepeatContext || restrictions.canRepeatTrack
    }

    private func enableInterface(_ enabled: Bool = true) {
        buttons.forEach { (button) -> () in
            button.isEnabled = enabled
        }

        if (!enabled) {
            albumArtImageView.image = nil
            updatePlayPauseButtonState(true);
        }
    }

    // MARK: Podcast Support
    private func updateInterfaceForPodcast(playerState: SPTAppRemotePlayerState) {
        skipForward15Button.isHidden = !playerState.track.isEpisode
        skipBackward15Button.isHidden = !playerState.track.isEpisode
        podcastSpeedButton.isHidden = !playerState.track.isPodcast
        nextButton.isHidden = !skipForward15Button.isHidden
        prevButton.isHidden = !skipBackward15Button.isHidden
        getCurrentPodcastSpeed()
    }

    private func updatePodcastSpeed(speed: SPTAppRemotePodcastPlaybackSpeed) {
        currentPodcastSpeed = speed
        podcastSpeedButton.setTitle(String(format: "%0.1fx", speed.value.floatValue), for: .normal);
    }

    // MARK: Player State
    private func updatePlayPauseButtonState(_ paused: Bool) {
        let playPauseButtonImage = paused ? PlaybackButtonGraphics.playButtonImage() : PlaybackButtonGraphics.pauseButtonImage()
        playPauseButton.setImage(playPauseButtonImage, for: UIControl.State())
        playPauseButton.setImage(playPauseButtonImage, for: .highlighted)
    }

    private func updatePlayerStateSubscriptionButtonState() {
        let playerStateSubscriptionButtonTitle = subscribedToPlayerState ? "Unsubscribe" : "Subscribe"
        playerStateSubscriptionButton.setTitle(playerStateSubscriptionButtonTitle, for: UIControl.State())
    }

    // MARK: Capabilities
    private func updateViewWithCapabilities(_ capabilities: SPTAppRemoteUserCapabilities) {
        onDemandCapabilitiesLabel.text = "Can play on demand: " + (capabilities.canPlayOnDemand ? "Yes" : "No")
    }

    private func updateCapabilitiesSubscriptionButtonState() {
        let capabilitiesSubscriptionButtonTitle = subscribedToCapabilities ? "Unsubscribe" : "Subscribe"
        capabilitiesSubscriptionButton.setTitle(capabilitiesSubscriptionButtonTitle, for: UIControl.State())
    }

    // MARK: Shuffle
    private func updateShuffleLabel(_ isShuffling: Bool) {
        shuffleModeLabel.text = "Shuffle mode: " + (isShuffling ? "On" : "Off")
    }

    // MARK: Repeat Mode
    private func updateRepeatModeLabel(_ repeatMode: SPTAppRemotePlaybackOptionsRepeatMode) {
        repeatModeLabel.text = "Repeat mode: " + {
            switch repeatMode {
            case .off: return "Off"
            case .track: return "Track"
            case .context: return "Context"
            default: return "Off"
            }
            }()
    }

    // MARK: Album Art
    private func updateAlbumArtWithImage(_ image: UIImage) {
        self.albumArtImageView.image = image
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.fade
        self.albumArtImageView.layer.add(transition, forKey: "transition")
    }

    // MARK: - Player actions
    private func seekForward15Seconds() {
        appRemote?.playerAPI?.seekForward15Seconds(defaultCallback)
    }

    private func seekBackward15Seconds() {
        appRemote?.playerAPI?.seekBackward15Seconds(defaultCallback)
    }

    private func pickPodcastSpeed() {
        appRemote?.playerAPI?.getAvailablePodcastPlaybackSpeeds({ (speeds, error) in
            if error == nil, let speeds = speeds as? [SPTAppRemotePodcastPlaybackSpeed], let current = self.currentPodcastSpeed {
                let vc = SpeedPickerViewController(podcastSpeeds: speeds, selectedSpeed: current)
                vc.delegate = self
                let nav = UINavigationController(rootViewController: vc)
                self.present(nav, animated: true, completion: nil)
            }
        })
    }

    private func skipNext() {
        appRemote?.playerAPI?.skip(toNext: defaultCallback)
    }

    private func skipPrevious() {
        appRemote?.playerAPI?.skip(toPrevious: defaultCallback)
    }

    private func startPlayback() {
        appRemote?.playerAPI?.resume(defaultCallback)
    }

    private func pausePlayback() {
        appRemote?.playerAPI?.pause(defaultCallback)
    }
    
    private func playTrack() {
        appRemote?.playerAPI?.play(trackIdentifier, callback: defaultCallback)
    }

    private func enqueueTrack() {
        appRemote?.playerAPI?.enqueueTrackUri(trackIdentifier, callback: defaultCallback)
    }

    private func toggleShuffle() {
        guard let playerState = playerState else { return }
        appRemote?.playerAPI?.setShuffle(!playerState.playbackOptions.isShuffling, callback: defaultCallback)
    }

    private func getPlayerState() {
        appRemote?.playerAPI?.getPlayerState { (result, error) -> Void in
            guard error == nil else { return }

            let playerState = result as! SPTAppRemotePlayerState
            self.updateViewWithPlayerState(playerState)
        }
    }

    private func getCurrentPodcastSpeed() {
        appRemote?.playerAPI?.getCurrentPodcastPlaybackSpeed({ (speed, error) in
            guard error == nil, let speed = speed as? SPTAppRemotePodcastPlaybackSpeed else { return }
            self.updatePodcastSpeed(speed: speed)
        })
    }

    private func playTrackWithIdentifier(_ identifier: String) {
        appRemote?.playerAPI?.play(identifier, callback: defaultCallback)
    }

    private func subscribeToPlayerState() {
        guard (!subscribedToPlayerState) else { return }
        appRemote?.playerAPI!.delegate = self
        appRemote?.playerAPI?.subscribe { (_, error) -> Void in
            guard error == nil else { return }
            self.subscribedToPlayerState = true
            self.updatePlayerStateSubscriptionButtonState()
        }
    }

    private func unsubscribeFromPlayerState() {
        guard (subscribedToPlayerState) else { return }
        appRemote?.playerAPI?.unsubscribe { (_, error) -> Void in
            guard error == nil else { return }
            self.subscribedToPlayerState = false
            self.updatePlayerStateSubscriptionButtonState()
        }
    }

    private func toggleRepeatMode() {
        guard let playerState = playerState else { return }
        let repeatMode: SPTAppRemotePlaybackOptionsRepeatMode = {
            switch playerState.playbackOptions.repeatMode {
            case .off: return .track
            case .track: return .context
            case .context: return .off
            default: return .off
            }
        }()

        appRemote?.playerAPI?.setRepeatMode(repeatMode, callback: defaultCallback)
    }

    // MARK: - Image API
    private func fetchAlbumArtForTrack(_ track: SPTAppRemoteTrack, callback: @escaping (UIImage) -> Void ) {
        appRemote?.imageAPI?.fetchImage(forItem: track, with:CGSize(width: 1000, height: 1000), callback: { (image, error) -> Void in
            guard error == nil else { return }

            let image = image as! UIImage
            callback(image)
        })
    }

    // MARK: - User API
    private func fetchUserCapabilities() {
        appRemote?.userAPI?.fetchCapabilities(callback: { (capabilities, error) in
            guard error == nil else { return }

            let capabilities = capabilities as! SPTAppRemoteUserCapabilities
            self.updateViewWithCapabilities(capabilities)
        })
    }

    private func subscribeToCapabilityChanges() {
        guard (!subscribedToCapabilities) else { return }
        appRemote?.userAPI?.delegate = self
        appRemote?.userAPI?.subscribe(toCapabilityChanges: { (success, error) in
            guard error == nil else { return }

            self.subscribedToCapabilities = true
            self.updateCapabilitiesSubscriptionButtonState()
        })
    }

    private func unsubscribeFromCapailityChanges() {
        guard (subscribedToCapabilities) else { return }
        appRemote?.userAPI?.unsubscribe(toCapabilityChanges: { (success, error) in
            guard error == nil else { return }

            self.subscribedToCapabilities = false
            self.updateCapabilitiesSubscriptionButtonState()
        })
    }

    // MARK: - AppRemote
    func appRemoteConnecting() {
        connectionIndicatorView.state = .connecting
    }

    func appRemoteConnected() {
        connectionIndicatorView.state = .connected
        subscribeToPlayerState()
        subscribeToCapabilityChanges()
        getPlayerState()

        enableInterface(true)
    }

    func appRemoteDisconnect() {
        connectionIndicatorView.state = .disconnected
        self.subscribedToPlayerState = false
        self.subscribedToCapabilities = false
        enableInterface(false)
    }

    // MARK: - Error & Alert
    func showError(_ errorDescription: String) {
        let alert = UIAlertController(title: "Error!", message: errorDescription, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    private func displayError(_ error: NSError?) {
        if let error = error {
            presentAlert(title: "Error", message: error.description)
        }
    }

    private func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    // MARK: - IBActions
    @IBAction func didPressPlayPauseButton(_ sender: AnyObject) {
        if appRemote?.isConnected == false {
            if appRemote?.authorizeAndPlayURI(playURI) == false {
                // The Spotify app is not installed, present the user with an App Store page
                showAppStoreInstall()
            }
        } else if playerState == nil || playerState!.isPaused {
            startPlayback()
        } else {
            pausePlayback()
        }
    }

    @IBAction func didPressPreviousButton(_ sender: AnyObject) {
        skipPrevious()
    }

    @IBAction func didPressNextButton(_ sender: AnyObject) {
        skipNext()
    }

    @IBAction func didPressPlayTrackButton(_ sender: AnyObject) {
        playTrack()
    }

    @IBAction func didPressSkipForward15Button(_ sender: UIButton) {
        seekForward15Seconds()
    }

    @IBAction func didPressSkipBackward15Button(_ sender: UIButton) {
        seekBackward15Seconds()
    }

    @IBAction func didPressChangePodcastPlaybackSpeedButton(_ sender: UIButton) {
        pickPodcastSpeed()
    }

    @IBAction func didPressEnqueueTrackButton(_ sender: AnyObject) {
        enqueueTrack()
    }

    @IBAction func didPressGetPlayerStateButton(_ sender: AnyObject) {
        getPlayerState()
    }

    @IBAction func didPressPlayerStateSubscriptionButton(_ sender: AnyObject) {
        if (subscribedToPlayerState) {
            unsubscribeFromPlayerState()
        } else {
            subscribeToPlayerState()
        }
    }

    @IBAction func didPressGetCapabilitiesButton(_ sender: AnyObject) {
        fetchUserCapabilities()
    }

    @IBAction func didPressCapabilitiesSubscriptionButton(_ sender: AnyObject) {
        if (subscribedToCapabilities) {
            unsubscribeFromCapailityChanges()
        } else {
            subscribeToCapabilityChanges()
        }
    }

    @IBAction func didPressToggleShuffleButton(_ sender: AnyObject) {
        toggleShuffle()
    }

    @IBAction func didPressToggleRepeatModeButton(_ sender: AnyObject) {
        toggleRepeatMode()
    }

    @IBAction func playRadioTapped(_ sender: Any) {
        if appRemote?.isConnected == false && appRemote?.playerAPI != nil {
            if appRemote?.authorizeAndPlayURI(trackIdentifier, asRadio: true) == false {
                // The Spotify app is not installed, present the user with an App Store page
                showAppStoreInstall()
            }
        } else {
            var trackUri = trackIdentifier
            appRemote?.playerAPI?.getPlayerState({ result, error in
                if let currentTrack = (result as? SPTAppRemotePlayerState)?.track.uri {
                    trackUri = currentTrack
                }

                self.appRemote?.playerAPI?.play(trackUri, asRadio: true, callback: self.defaultCallback)
            })
        }
    }

}

// MARK: - SpeedPickerViewControllerDelegate
extension ViewController: SpeedPickerViewControllerDelegate {
    func speedPickerDidCancel(viewController: SpeedPickerViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }

    func speedPicker(viewController: SpeedPickerViewController, didChoose speed: SPTAppRemotePodcastPlaybackSpeed) {
        appRemote?.playerAPI?.setPodcastPlaybackSpeed(speed, callback: { (_, error) in
            guard error == nil else {
                return
            }
            self.updatePodcastSpeed(speed: speed)
        })
        viewController.dismiss(animated: true, completion: nil)
    }
}

// MARK: - SPTAppRemotePlayerStateDelegate
extension ViewController: SPTAppRemotePlayerStateDelegate {
       func playerStateDidChange(_ playerState: SPTAppRemotePlayerState) {
           self.playerState = playerState
           updateViewWithPlayerState(playerState)
       }
}
// MARK: - SPTAppRemoteUserAPIDelegate
extension ViewController: SPTAppRemoteUserAPIDelegate {
    func userAPI(_ userAPI: SPTAppRemoteUserAPI, didReceive capabilities: SPTAppRemoteUserCapabilities) {
        updateViewWithCapabilities(capabilities)
    }
}

// MARK: SKStoreProductViewControllerDelegate
extension ViewController: SKStoreProductViewControllerDelegate {
    private func showAppStoreInstall() {
        if TARGET_OS_SIMULATOR != 0 {
            presentAlert(title: "Simulator In Use", message: "The App Store is not available in the iOS simulator, please test this feature on a physical device.")
        } else {
            let loadingView = UIActivityIndicatorView(frame: view.bounds)
            view.addSubview(loadingView)
            loadingView.startAnimating()
            loadingView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
            let storeProductViewController = SKStoreProductViewController()
            storeProductViewController.delegate = self
            storeProductViewController.loadProduct(withParameters: [SKStoreProductParameterITunesItemIdentifier: SPTAppRemote.spotifyItunesItemIdentifier()], completionBlock: { (success, error) in
                loadingView.removeFromSuperview()
                if let error = error {
                    self.presentAlert(
                        title: "Error accessing App Store",
                        message: error.localizedDescription)
                } else {
                    self.present(storeProductViewController, animated: true, completion: nil)
                }
            })
        }
    }

    public func productViewControllerDidFinish(_ viewController: SKStoreProductViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
}
