Для запуска iOS приложения нужно: 
- Поменять bundle identifier и App Groups name (в папке ios поиском найти `YOUR_BUNDLE_ID` и заменить на свой)
- Поменять Team и подписать приложение
- Вставить в поле `endpointId` в файле [mindboxUtils.ts](src/mindboxUtils.ts) вместо `IOS_ENDPOINT` свой endpoint
- Запустить приложение и получить UUID
- В админке mindbox создать rich-уведомление и отправить на устройство c нужным UUID

В результате пуш-уведомление отображается на устройстве, но при клике на кнопке в метод `onPushClickReceived` приходит null.  
По нажатию на само уведомление в метод `onPushClickReceived` приходит нужный pushUrl.
