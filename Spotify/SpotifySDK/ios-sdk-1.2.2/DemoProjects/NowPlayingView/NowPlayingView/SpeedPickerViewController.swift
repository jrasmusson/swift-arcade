
protocol SpeedPickerViewControllerDelegate {
    func speedPicker(viewController: SpeedPickerViewController, didChoose speed:SPTAppRemotePodcastPlaybackSpeed)
    func speedPickerDidCancel(viewController: SpeedPickerViewController)
}


class SpeedPickerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var delegate: SpeedPickerViewControllerDelegate?
    private let podcastSpeeds: [SPTAppRemotePodcastPlaybackSpeed]
    private var selectedSpeed: SPTAppRemotePodcastPlaybackSpeed
    private var selectedIndex: Int = 0
    private let cellIdentifier = "SpeedCell"

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.bounds)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.cellIdentifier)
        return tableView
    }()

    init(podcastSpeeds: [SPTAppRemotePodcastPlaybackSpeed], selectedSpeed: SPTAppRemotePodcastPlaybackSpeed) {
        self.podcastSpeeds = podcastSpeeds
        self.selectedSpeed = selectedSpeed
        super.init(nibName: nil, bundle: nil)
        updateSelectedindex()
        view.addSubview(tableView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Podcast Playback Speed"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(didPressCancel))
    }

    private func updateSelectedindex() {
        let values = podcastSpeeds.map { $0.value }
        selectedIndex = values.distance(from: values.startIndex, to:values.firstIndex(of: self.selectedSpeed.value)!)
    }

    @objc func didPressCancel() {
        delegate?.speedPickerDidCancel(viewController: self)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.speedPicker(viewController: self, didChoose: podcastSpeeds[indexPath.row])
        selectedSpeed = podcastSpeeds[indexPath.row]
        selectedIndex = indexPath.row
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcastSpeeds.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = String(format: "%.1fx", podcastSpeeds[indexPath.row].value.floatValue)
        if indexPath.row == selectedIndex {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
}
