# Closures in Application Development

## Simple Closure


```swift
struct ClosureWeatherService {

    func fetchWeather(for city: String, completion: (ClosureWeather) -> Void) {
        let weather = ClosureWeather(city: city, temperature: 21, imageName: "sunset.fill")
        completion(weather)
    }
    
}
```

Call it from a _ViewController_ like this.

```swift
    @objc func weatherPressed() {
    var weatherService = ClosureWeatherService()
    
    // Simple closure
    weatherService.fetchWeather(for: "San Francisco") { (weather) in
        updateView(with: weather)
    }
}
```

Here the weather is passed back to the _ViewController_ via the closure _completion_ block.

## Returning Closure

Closures can return variables too. 

```swift
struct ClosureWeatherService {
    var cacheable = false
    var weather = ClosureWeather(city: "Unknown", temperature: 0, imageName: "moon")

    mutating func fetchWeather(for city: String, completion: (ClosureWeather) -> Bool) {
        if cacheable {
            cacheable = completion(weather)
            return
        }

        weather = ClosureWeather(city: city, temperature: -30, imageName: "snow")
        cacheable = completion(weather)
    }
}
```

Which we call like this. Note: The return.

```swift
weatherService.fetchWeather(for: "New York") { (weather) -> Bool in
    updateView(with: weather)
    return weather.temperature < -20
}
```

## Swift Result

The pattern of returning success/fail has become so common Swift has codified that into an _enum_ called `Result`.

```swift
   func fetchWeatherWithResult(for city: String, completion: (Result<ClosureWeather, Error>) -> Void) {
        weather = ClosureWeather(city: city, temperature: 15, imageName: "wind")
        completion(Result.success(weather))

        // if error
        // enum WeatherError: Error { case failure }
        // completion(Swift.Result.failure(WeatherError.failure))
    }
```

Which we call from our _viewController_ like this

```swift
    @objc func weatherPressed() {

        weatherService.fetchWeatherWithResult(for: "Seattle") { (result) in
            switch result {
            case .success(let weather):
                updateView(with: weather)
            case .failure(_):
                print("Error 💥! ")
            }
        }
        
}

struct ClosureWeather {
    typealias Celcius = Int
    let city: String
    let temperature: Celcius
    let imageName: String
}
```


