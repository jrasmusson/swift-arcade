# How to process Core Data background thread

When you have a heavy load of Core Data processing, do it on a background thread using `persistentContainer.performBackgroundTask`.

```swift
func createCoreDataWeather(weather: WeatherModel) {    
    // How to process on background thread ✅
    persistentContainer.performBackgroundTask { (context) in
        let weatherCoreData = WeatherCoreData(context: context)
        weatherCoreData.cityName = weather.cityName
        try? context.save()
        printStats()
    }
}
```

# How to ensure you are on the main UI thread

To ensure you are on the main UI thread for UI processing use `context.perform`.

```swift
func printStats() {
    let context = persistentContainer.viewContext

    // How to safely do something on the main UI thread
    context.perform {
        
        if Thread.isMainThread {
            print("on main thread")
        } else {
            print("off main thread")
        }
        
        let fetchRequest = NSFetchRequest<WeatherCoreData>(entityName: "WeatherCoreData")
        let weathers = try? context.fetch(fetchRequest)
        print("\(String(describing: weathers?.count)) Weathers")
    }
}
```

This will ensure whatever processing follows is done on the contexts queue.

### Links that help


### Video


