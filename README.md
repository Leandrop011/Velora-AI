
## APLICACION DE CHATBOT CON AI
Esta es una aplicacion de chatbot utilizando inteligencia artificial, 
desarrollada con Flutter. El chatbot es capaz de responder a preguntas 
y mantener conversaciones de manera natural.
Ademas gracias a la arquitectura aplicada puede variar los modelos de 
AI.

## Dependencias
Cambiar Splash Screen
```
flutter pub add flutter_native_splash
dart run flutter_native_splash:create
Configuraciones en el main:
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    Cuando la app se contruya colocar: 
    FlutterNativeSplash.remove();
```
Go Router
```
flutter pub add go_router
```
Image Picker
```
flutter pub add image_picker
```
Chat UI
```
flutter pub add flutter_chat_ui
```
UUID
```
dart pub add uuid
```
DIO
```
dart pub add dio
```
RiverPod
```
flutter pub add flutter_riverpod
```

