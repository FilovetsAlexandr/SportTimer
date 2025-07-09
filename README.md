# SportTimer

Простое и удобное приложение для отслеживания времени тренировок.

## Архитектурные решения

Проект построен с использованием современных подходов к разработке под iOS:

- **SwiftUI**: Весь пользовательский интерфейс написан на декларативном фреймворке SwiftUI.
- **MVVM (Model-View-ViewModel)**: Принята архитектура MVVM для разделения логики, представления данных и пользовательского интерфейса. Каждый модуль имеет свою `View`, `ViewModel` и `Model`.
- **CoreData**: Для сохранения истории тренировок используется CoreData, обернутая в `PersistenceSportTimer`.
- **Combine**: Фреймворк Combine используется для работы с асинхронными событиями, например, в `SplashScreenViewModelSportTimer`.

## Известные ограничения

- Приложение находится в стадии разработки, некоторый функционал может быть не до конца реализован.
- Отсутствует локализация, интерфейс только на одном языке.
- Пользовательские данные хранятся локально и не синхронизируются с облачными сервисами.

## Инструкции по запуску

1.  Клонируйте репозиторий.
2.  Откройте файл `SportTimer.xcodeproj` в Xcode.
3.  Выберите симулятор или реальное устройство.
4.  Нажмите `Cmd+R` для сборки и запуска проекта.

## Скриншоты основных экранов
![Simulator Screenshot - iPhone 15 Pro Max - 2025-07-09 at 18 55 52](https://github.com/user-attachments/assets/8a24c3df-bc52-4e25-b57f-c059454d2c60)
![Simulator Screenshot - iPhone 15 Pro Max - 2025-07-09 at 18 56 10](https://github.com/user-attachments/assets/f5a059dc-7048-4fe8-85f0-ef76308496c3)
![Simulator Screenshot - iPhone 15 Pro Max - 2025-07-09 at 18 56 14](https://github.com/user-attachments/assets/1e333b09-297f-4c6d-a211-80537ec557ca)
![Simulator Screenshot - iPhone 15 Pro Max - 2025-07-09 at 18 56 21](https://github.com/user-attachments/assets/c237093f-633b-4a81-a042-893d6aa2fc50)
