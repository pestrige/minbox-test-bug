Для запуска iOS приложения нужно: 
- Поменять bundle identifier и App Groups name (в папке ios поиском найти `YOUR_BUNDLE_ID` и заменить на свой)
- Поменять Team и подписать приложение
- Вставить в поле `endpointId` в файле [mindboxUtils.ts](src/mindboxUtils.ts) вместо `IOS_ENDPOINT` свой endpoint
