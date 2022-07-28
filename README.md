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

<img src="https://github.com/AnnaGola/R-music/blob/main/Screenshots/Simulator%20Screen%20Shot%20-%20iPhone%2011%20-%202022-07-26%20at%2021.30.09.png" width="160">  <img src="https://github.com/AnnaGola/R-music/blob/main/Screenshots/Снимок%20экрана%202022-07-26%20в%2020.29.45.png" width="174.5">  <img src="https://github.com/AnnaGola/R-music/blob/main/Screenshots/Снимок%20экрана%202022-07-26%20в%2020.31.16.png" width="184">

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

При введении запроса появляется ActivityInspector в центре икрана, чтобы пользователь видел, что экран у него не завис, а приложение в данный момент подгружает его поисковый запрос с сервера.  

Если скорость интернета низкая, то в первую очередь при прогрузке всей таблицы, картинки, которые еще не кэшированы благодаря Alamofire, будут подгружаться в дефолтном цвете приложения и только потом асинхронно загрузятся все остольные изображения.

<img src="https://github.com/AnnaGola/R-music/blob/main/Screenshots/Simulator%20Screen%20Shot%20-%20iPhone%2011%20-%202022-07-26%20at%2021.30.41.png" width="160">  <img src="https://github.com/AnnaGola/R-music/blob/main/Screenshots/Simulator%20Screen%20Shot%20-%20iPhone%2011%20-%202022-07-26%20at%2021.31.05.png" width="160">   <img src="https://github.com/AnnaGola/R-music/blob/main/Screenshots/Simulator%20Screen%20Shot%20-%20iPhone%2011%20-%202022-07-26%20at%2020.40.03.png" width="160">  <img src="https://github.com/AnnaGola/R-music/blob/main/Screenshots/Simulator%20Screen%20Shot%20-%20iPhone%2011%20-%202022-07-26%20at%2020.40.07.png" width="160">

## Плеер

При нажатии на любую ячейку октроется экран с запущенным плеером, в котором можно регулировать звук и момент в песне на слайдерах, перематывать песни вперед/назад с помощью боковых кнопок, а также останавливать песню и запускать её снова.

При остановке песни, по нажатии на паузу, срабатывает метод playOrPauseState() где в if else при изменении pause на play, меняется изображение кнопки и размер изображения песни. Изменение происходит на 20% благодаря UIView.animate:

```swift
UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut)
```
Так же цвет кнопок, текста и цвета сслайдера с аудиодорожкой будут меняться в зависимости от оттенка фона:

 <img src="https://github.com/AnnaGola/R-music/blob/main/Screenshots/Simulator%20Screen%20Shot%20-%20iPhone%2011%20-%202022-07-25%20at%2019.48.16.png" width="160">   <img src="https://github.com/AnnaGola/R-music/blob/main/Screenshots/Simulator%20Screen%20Shot%20-%20iPhone%2011%20-%202022-07-25%20at%2019.42.20.png" width="160">
 
