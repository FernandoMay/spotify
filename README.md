# Spotify — Unofficial Flutter Client

Cliente no oficial de Spotify con interfaz Cupertino (iOS), control remoto vía Spotify SDK y reproducción local de audio.

## Stack

| Capa | Tecnología |
|------|-----------|
| Framework | Flutter 3.x / Dart 3.x |
| UI | Cupertino (iOS-style) |
| SDK Spotify | `spotify_sdk: ^2.3.0` (control remoto) |
| Audio local | `audioplayers: ^1.0.1` |
| Config | `flutter_dotenv: ^5.0.2` |
| CI/CD | GitHub Actions (analyze + test + build APK) |

## Funcionalidades

- Pantalla de splash con branding y navegación automática
- Pantalla de inicio con "Reproducido recientemente", cuadrícula "Buenas tardes", filas de recomendaciones
- Vista de álbum con parallax, gradiente y botones de corazón/reproducir/aleatorio
- Página de álbum con lista de pistas y 10 playlists hardcoded
- Reproductor musical con slider, controles (play/pause/skip/shuffle/repeat)
- Control remoto Spotify SDK: conectar, play/pause, skip, seek, shuffle, repeat, leer estado
- Modelos Album, Artist, Playlist con serialización JSON
- Tema oscuro con acento verde Spotify

## Estructura

```
lib/
├── main.dart                    # Entry point + tema oscuro
├── models/
│   ├── album.dart               # Modelo Album
│   ├── artist.dart              # Modelo Artist
│   ├── auth.dart                # Modelo de autorización
│   └── playlist.dart            # Modelo Playlist + Song
├── repository/
│   ├── auth.dart                # Auth placeholder
│   └── services.dart            # Integración Spotify SDK (715 líneas)
├── views/
│   ├── splash.dart              # Splash animado
│   ├── login.dart               # OAuth web (comentado)
│   ├── home.dart                # Home + Explore tabs
│   ├── albumview.dart           # Detalle de álbum
│   ├── albumpage.dart           # Página de álbum con pistas
│   ├── musicdetail.dart         # Reproductor musical
│   └── playlist.dart            # Pantalla de playlist
└── assets/                      # Imágenes de álbumes
```

## Inicio rápido

```bash
flutter pub get
cp .env.example .env
# Editar .env con CLIENT_ID y REDIRECT_URL de Spotify
flutter run
```

## Pruebas

```bash
flutter test
```

## Notas

- Requiere la app oficial de Spotify instalada para control remoto
- Imágenes de assets incompletas (solo 4 JPEGs presentes)
- Compatible con Android, iOS, Web, Windows, macOS, Linux
