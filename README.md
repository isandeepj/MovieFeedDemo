# SwiftUI Top Movies App with Combine and Alamofire

This SwiftUI application fetches and displays the top movies from the Apple iTunes top movie RSS feed. It leverages SwiftUI for a modern UI, incorporates Combine for handling asynchronous operations, and utilizes Alamofire for making network requests. The app also features navigation using `List` and `NavigationLink`, and movie previews played through `PlayerView`.


## Features

- Fetches and displays the top movies from the Apple iTunes top movie RSS feed.
- Presents movie details, including title, summary, and release date.
- Utilizes SwiftUI for a modern and responsive user interface.
- Implements navigation using `List` and `NavigationLink`.
- Demonstrates network requests using Alamofire and handles responses with Combine.
- Plays movie previews using `PlayerView`.

## Screenshots
<img src="https://github.com/isandeepj/MovieFeedDemo/assets/24805252/456934cd-39f1-43c4-936b-c94ede3a6492" alt="Screenshot 1" width="300" />
<img src="https://github.com/isandeepj/MovieFeedDemo/assets/24805252/38eb6005-4440-439b-b97c-4c42432e4046" alt="Screenshot 2" width="300" />
<img src="https://github.com/isandeepj/MovieFeedDemo/assets/24805252/88dea658-bb15-43de-b3f2-75d10dc1de41" alt="Screenshot 3" width="300" />


## Usage

1. **Clone the repository:**

   ```bash
   git clone https://github.com/isandeepj/MovieFeedDemo.git
   ```
2. **Open the project in Xcode.**
3. **Build and run the app on a simulator or device.**


## Dependencies

- Alamofire for network requests
- Combine for handling asynchronous operations


## Installing Dependencies

**Swift Package Manager**:

Add the following dependencies in your Package.swift file

```bash
dependencies: [
    .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.8.1"),
],
targets: [
    .target(name: "YourTarget", dependencies: ["Alamofire"]),
]
```
Run swift package update to fetch the Alamofire library.


**Combine**:

Combine is part of the Apple's SDK and is included by default when using SwiftUI

## Contributing
Contributions are welcome! Feel free to open issues, create pull requests, or suggest improvements.


## How to Fetch Data

The app fetches data from the Apple iTunes top movie RSS feed: https://itunes.apple.com/us/rss/topmovies/limit=50/json

## How to Play Previews
Previews are played using the PlayerView. Ensure the device or simulator has network connectivity to stream preview content.
