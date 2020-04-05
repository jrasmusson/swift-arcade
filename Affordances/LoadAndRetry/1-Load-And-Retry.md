# Load and Retry

Sometimes when you are builing applications. It's nice having a load and retry screen. Some remote calls take time. Others fail. Having a consisent way of swapping between loading, retrying, and your final screen is really nice.

![problem]()

One way to solve it is to create a parent view controller, holding both the load and retry screens, and then swap between them depending on where you are in your slow/flakey running network call.

![problem]()

The key line(s) here is this.


**LoadAndRetryDemo.swift**


```swift
    func loadData() {
        setToLoading()

        fetchData { result in
            self.doneLoading()

            switch result {
            case .success(let games):
                self.games = games
                self.tableView.reloadData()
            case .failure(_):
                self.setToRetry()
            }
        }
    }
```

By calling the parent viewController you extended from, which manages which view to show depending on your state, you can have a nice elegant simple work flow for handling load and retries in your app.

See source code for complete solution.

