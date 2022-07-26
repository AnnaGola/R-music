# R-music

Приложение с поиском и прослушиванием музыки из открытого iTunes API и сохранением треков у себя в плейлисте.

В этом проекте я использовала: 
* CleanSwift архитектуру
* UIKit / SwiftUI для разных экранов
* Alamofire, SDWebImage, AVPlayer
* UserDefaults для сохранения данных
* Вёрстку в коде/ storyboard и XIB для кастомных ячеек
* Adobe XD для иконок 

## LaunchScreen и Архитектура проекта

<img src="https://github.com/AnnaGola/R-music/blob/main/Screenshots/Simulator%20Screen%20Shot%20-%20iPhone%2011%20-%202022-07-26%20at%2021.30.09.png" width="160">  <img src="https://github.com/AnnaGola/R-music/blob/main/Screenshots/Снимок%20экрана%202022-07-26%20в%2020.29.45.png" width="172">  <img src="https://github.com/AnnaGola/R-music/blob/main/Screenshots/Снимок%20экрана%202022-07-26%20в%2020.31.16.png" width="182">

## Главный экран

Первой открывается вкладка "Search" с поиском по ключевым словам или символам/цифрам из iTunes API, рядом с ней в TabBar расположена вкладка "Playlist" со списком сохраненных из поисковика песен.

## Поиск

Изначально экран пустой, в нем есть только тапбар и поисковая строка. 
Благодаря функции: searchBar() и установленному в нем таймеру, писковик не будет обрабатывать запрос посимвольно, а сделает это с задержкой в 0.5 сек, пока пользователь вводит свой запрос, чтобы не съедать много интернет трафика на обработку каждого символа.

```swift
func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
            self.interactor?.makeRequest(request: Search.Model.Request.RequestType.getTracks(searchText: searchText))
        })
    }
```

<img src="https://github.com/AnnaGola/R-music/blob/main/Screenshots/Simulator%20Screen%20Shot%20-%20iPhone%2011%20-%202022-07-26%20at%2020.39.51.png" width="160">  <img src="https://github.com/AnnaGola/R-music/blob/main/Screenshots/Simulator%20Screen%20Shot%20-%20iPhone%2011%20-%202022-07-26%20at%2020.40.21.png" width="160">   <img src="https://github.com/AnnaGola/R-music/blob/main/Screenshots/Simulator%20Screen%20Shot%20-%20iPhone%2011%20-%202022-07-26%20at%2020.40.03.png" width="160">  <img src="https://github.com/AnnaGola/R-music/blob/main/Screenshots/Simulator%20Screen%20Shot%20-%20iPhone%2011%20-%202022-07-26%20at%2020.40.07.png" width="160">



