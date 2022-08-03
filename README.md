# R-music

Приложение с поиском и прослушиванием музыки из открытого iTunes API и сохранением треков у себя в плейлисте.

В этом проекте я использовала: 
* CleanSwift архитектуру
* UIKit / SwiftUI для разных экранов через UIHostingController
* Alamofire, SDWebImage, URLImage, AVPlayer
* UserDefaults для сохранения данных
* Вёрстку в коде/ storyboard и XIB для кастомных ячеек
* Анимацию через пересчёт констреинтов
* Adobe XD для иконок 

## LaunchScreen и Архитектура проекта

<img src="https://github.com/AnnaGola/R-music/blob/main/Screenshots/Simulator%20Screen%20Shot%20-%20iPhone%2011%20-%202022-08-02%20at%2020.29.51.png" width="160">  <img src="https://github.com/AnnaGola/R-music/blob/main/Screenshots/Снимок%20экрана%202022-08-02%20в%2020.17.56.png" width="168">  <img src="https://github.com/AnnaGola/R-music/blob/main/Screenshots/Снимок%20экрана%202022-08-02%20в%2020.18.27.png" width="191">

## Главный экран

Приложени состоит из двух экранов, переходы через таббар.
**Поиск** написан на UIKit с использованием Storyboard и XIB. 
**Плейлист** написан на SwiftUI

Первым открывается экран "Playlist" со списком сохраненных из поисковика песен.    
При первом запуске приложения он пустой, без сохраненных песен.   

Рядом с ним в TabBar расположен экран "Search" с поиском по ключевым словам из iTunes API.                    
Изначально экран пустой, в нем есть только таббар и поисковая строка.  

Поиск идет с задержкой в 0.5 секунд, чтобы не обрабатывать запрос пользователя посимвольно, отнимая на это много трафика, также добавлен ActivityIndicator во время загрузки данных с сервера.

<img src="https://github.com/AnnaGola/R-music/blob/main/Screenshots/searchBarSwift.gif" width="160">   <img src="https://github.com/AnnaGola/R-music/blob/main/Screenshots/PlaylistBarrefreshButtonTapped.gif" width="160"> 

## Плеер

При нажатии на ячейку с песней октроется экран с запущенным плеером, в котором можно регулировать звук и момент в песне на слайдерах, перематывать песни вперед/назад с помощью боковых кнопок, а также останавливать песню и запускать её снова.

<img src="https://github.com/AnnaGola/R-music/blob/main/Screenshots/PlaylistPlayPause.gif" width="160">  <img src="https://github.com/AnnaGola/R-music/blob/main/Screenshots/Simulator%20Screen%20Shot%20-%20iPhone%2011%20-%202022-08-03%20at%2016.30.49.png" width="160">   <img src="https://github.com/AnnaGola/R-music/blob/main/Screenshots/Simulator%20Screen%20Shot%20-%20iPhone%2011%20-%202022-08-03%20at%2016.29.54.png" width="160">   <img src="https://github.com/AnnaGola/R-music/blob/main/Screenshots/Simulator%20Screen%20Shot%20-%20iPhone%2011%20-%202022-08-03%20at%2016.29.30.png" width="160">  <img src="https://github.com/AnnaGola/R-music/blob/main/Screenshots/Simulator%20Screen%20Shot%20-%20iPhone%2011%20-%202022-08-03%20at%2016.29.42.png" width="160"> 
 
 ## Анимация и кастомизация плеера
 
Тени добавлены на доп вью за обложкой, углы скруглены у самого изображения с обложкой песни. Пришлось прибегнуть к такой хитрости, ибо одновременно работать со свойством layer у вью над всеми нужными функциями для такого эффекта не получится. 
Настроила так, чтобы на паузе вью и тени были меньше на 20%, чем при проигровании песни.

Также за всеми элементами в плеере есть imageView, на которую передается картинка с обложки по URL в разрешении 8х8, расстянутая на весь экран, чтобы окрасить его в цвет обложки. Поверх наложен темный BlurEffect.
 
Анимация планого открытия и закрытия плеера прописана в коде через пересчет констреинтов, без сторонних библиотек.          
Скрыть плеер до мини версии над тамббаром: по нажатию на кнопку в самом верху и по свайпу вниз из любого места экрана.      
Открыть плеер на весь экран: свайпом вверх из мини плеера и по тапу на него.

<img src="https://github.com/AnnaGola/R-music/blob/main/Screenshots/SwipePlaylistSwift.gif" width="160">  <img src="https://github.com/AnnaGola/R-music/blob/main/Screenshots/TabGesturePlaylistSwift.gif" width="160"> 
 
## Удаление и сохранение

Добавить песню можно из поисковика, если напротив песни стоит знак "+". При нажатии на эту кнопку, нужно перейти в плейлист и обновить его по кнопке "refresh", после чего песня появится в самом низу. Добавление происходит в конец, а не в начало массива только в целях экономии места в памяти, чтобы не менять индексы всех сохраненных песен в массиве при каждом добавлоении новой песни на нулевой индекс.

Удалить песню можно из плейлиста по свайпу влево и обновить список по кнопке "refresh". Песня удалиться как с экрана, так и из массива с песнями в памяти устройства. после повторного поиска, напротив удаленной песни внось появится "+" для добавления ее в плейлист.

<img src="https://github.com/AnnaGola/R-music/blob/main/Screenshots/delete.gif" width="160">






