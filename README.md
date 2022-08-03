# R-music

Приложение с поиском и прослушиванием музыки из открытого iTunes API и сохранением треков у себя в плейлисте.

В этом проекте я использовала: 
* CleanSwift архитектуру
* UIKit / SwiftUI для разных экранов через UIHostingController
* Alamofire, SDWebImage, URLImage, AVPlayer
* UserDefaults для сохранения данных
* Вёрстку в коде/ storyboard и XIB для кастомных ячеек
* Adobe XD для иконок 

## LaunchScreen и Архитектура проекта

<img src="https://github.com/AnnaGola/R-music/blob/main/Screenshots/Simulator%20Screen%20Shot%20-%20iPhone%2011%20-%202022-08-02%20at%2020.29.51.png" width="160">  <img src="https://github.com/AnnaGola/R-music/blob/main/Screenshots/Снимок%20экрана%202022-08-02%20в%2020.17.56.png" width="168">  <img src="https://github.com/AnnaGola/R-music/blob/main/Screenshots/Снимок%20экрана%202022-08-02%20в%2020.18.27.png" width="191">

## Главный экран

Приложени состоит из двух экранов, переходы через таббар. 
**Поиск** написан на UIKit с использованием Storyboard и XIB. 
**Плейлист** написан на SwiftUI

Первой открывается вкладка "Playlist" со списком сохраненных из поисковика песен. 
При первом запуске приложения он пустой, его можно обновить, чтобы в этом убедиться. 
Рядом с ней в TabBar расположена вкладка "Search" с поиском по ключевым словам или символам/цифрам из iTunes API. Он загружает песни продолжительностью в 30 секунд. 
Изначально экран пустой, в нем есть только тапбар и поисковая строка.  
Поиск идет с задержкой в 0.5 секунд, чтобы не обрабатывать запрос пользователя посимвольно, отнимая на это много трафика, также добавлен ActivityIndicator во время загрузки данных с сервера.

<img src="https://github.com/AnnaGola/R-music/blob/main/Screenshots/searchBarSwift.gif" width="160">   <img src="https://github.com/AnnaGola/R-music/blob/main/Screenshots/PlaylistBarrefreshButtonTapped.gif" width="160"> 

<img src="https://github.com/AnnaGola/R-music/blob/main/Screenshots/Simulator%20Screen%20Shot%20-%20iPhone%2011%20-%202022-07-31%20at%2021.27.31.png" width="160">  <img src="https://github.com/AnnaGola/R-music/blob/main/Screenshots/Simulator%20Screen%20Shot%20-%20iPhone%2011%20-%202022-07-31%20at%2021.27.43.png" width="160">   <img src="https://github.com/AnnaGola/R-music/blob/main/Screenshots/Simulator%20Screen%20Shot%20-%20iPhone%2011%20-%202022-07-31%20at%2021.27.47.png" width="160"> 

## Плеер

При нажатии на любую ячейку октроется экран с запущенным плеером, в котором можно регулировать звук и момент в песне на слайдерах, перематывать песни вперед/назад с помощью боковых кнопок, а также останавливать песню и запускать её снова.

При остановке песни, по нажатии на паузу, срабатывает метод playOrPauseState() где в if else при изменении pause на play, меняется изображение кнопки и размер изображения песни. Изменение происходит на 20% благодаря UIView.animate:

```swift
UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut)
```

 <img src="https://github.com/AnnaGola/R-music/blob/main/Screenshots/Simulator%20Screen%20Shot%20-%20iPhone%2011%20-%202022-07-31%20at%2021.27.59.png" width="160">   <img src="https://github.com/AnnaGola/R-music/blob/main/Screenshots/Simulator%20Screen%20Shot%20-%20iPhone%2011%20-%202022-07-31%20at%2021.33.07.png" width="160">   <img src="https://github.com/AnnaGola/R-music/blob/main/Screenshots/Simulator%20Screen%20Shot%20-%20iPhone%2011%20-%202022-07-31%20at%2021.28.38.png" width="160">  <img src="https://github.com/AnnaGola/R-music/blob/main/Screenshots/Simulator%20Screen%20Shot%20-%20iPhone%2011%20-%202022-07-31%20at%2021.28.53.png" width="160">    
 
