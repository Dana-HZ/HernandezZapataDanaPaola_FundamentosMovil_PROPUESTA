# Journie — maqueta Flutter

Este proyecto contiene una maqueta navegable de Journie, sin base de datos ni autenticación real.

## Cómo usarlo en Visual Studio Code

1. Crea una carpeta llamada `journie`.
2. Copia dentro el contenido de este paquete, conservando la estructura de carpetas.
3. Abre esa carpeta en Visual Studio Code.
4. En la terminal integrada ejecuta:
   ```bash
   flutter pub get
   flutter run
   ```

Si ya creaste un proyecto Flutter, puedes copiar `lib/` y reemplazar tu `pubspec.yaml` por el incluido (o agregar únicamente las dependencias; esta maqueta no requiere paquetes externos).

## Navegación disponible

- Splash → bienvenida
- Bienvenida → iniciar sesión, registro o explorar
- Inicio de sesión ↔ registro → diario
- Diario → nueva entrada, detalle, cuenta
- Detalle → editar o eliminar con confirmación
- Cuenta → editar cuenta o cerrar sesión

El diario comienza vacío y no incluye datos personales de ejemplo. Las entradas que agregues se mantienen solo en memoria durante la ejecución y se restablecen al reiniciar la app; no hay base de datos. Los botones de imagen son marcadores visuales; cámara y galería se implementarán después.

## Estructura

```text
lib/
├── main.dart
└── features/
    ├── splash/screens/splash_screen.dart
    ├── welcome/screens/welcome_screen.dart
    ├── auth/
    │   ├── models/auth_form_data.dart
    │   ├── screens/login_screen.dart
    │   ├── screens/register_screen.dart
    │   └── widgets/auth_text_field.dart
    ├── home/
    │   ├── models/journal_entry.dart
    │   ├── screens/home_screen.dart
    │   └── widgets/journal_entry_card.dart
    ├── journal/
    │   ├── screens/entry_form_screen.dart
    │   └── screens/entry_detail_screen.dart
    └── account/
        ├── models/account_data.dart
        ├── screens/account_screen.dart
        ├── screens/edit_account_screen.dart
        └── widgets/account_info_card.dart
```
