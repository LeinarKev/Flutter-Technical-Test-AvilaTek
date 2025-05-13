# Latest App

Latest App es una aplicación desarrollada en Flutter que muestra información de películas y actores mediante el consumo de la API de The Movie Database. La app incluye animaciones personalizadas para las transiciones entre pantallas, interfaces con gradientes, y temas personalizados utilizando Google Fonts (por ejemplo, la fuente Baloo).

## Características

- **Pantalla Principal:**  
  Muestra una lista de películas distribuidas en dos columnas de manera alterna.
  
- **Transiciones Animadas:**  
  Se utiliza `PageRouteBuilder` para animar las transiciones entre pantallas, combinando efectos de fade y scale. También se implementa animación en el overlay de detalles y en el listado de películas/actores.

- **Detalle de Películas y Actores:**  
  Visualiza información detallada de cada película y perfil de actor, con animaciones de aparición  al interactuar.

- **Interfaz Personalizada:**  
  Uso de gradientes en botones y temáticas con la tipografía Baloo integradas a través del paquete `google_fonts`.

## Prerrequisitos

- **Flutter SDK:**  
  Se recomienda la versión estable (por ejemplo, Flutter 3.x) que puedes descargar en [Flutter.dev](https://flutter.dev).

- **API Key de The Movie Database:**  
  La aplicación utiliza la API de TMDB. Asegúrate de contar con un token válido. Consulta [la documentación de TMDB](https://developers.themoviedb.org/3/getting-started/authentication) para más detalles.

- **Dependencias:**  
  - [http](https://pub.dev/packages/http) para las peticiones a la API.  
  - [google_fonts](https://pub.dev/packages/google_fonts) para la integración de la tipografía Baloo.

## Instalación

1. **Clona el repositorio:**

   ```bash
   git clone https://github.com/LeinarKev/Flutter-Technical-Test-AvilaTek.git
   cd Flutter-Technical-Test-AvilaTek

2. **Instalar dependencias:**

   ```bash
   flutter pub get

## Ejecución

- **Dispositivos móviles**

  ```bash
  flutter run

## Estructura de Datos

- **lib/** Contiene el código fuente de la aplicación.
      - **home/**: Pantalla principal, listados de películas y navegación a detalle.
      - **detail/**: Pantalla de detalle de la pelicula y sus actores.
      - **profile/**: Pantalla de detalle del actor y las peliculas que ha actuado o pertenecido.

## Configuración Adicional
- **API Keys**: Asegúrate de configurar tu API key o token de The Movie Database en el código correspondiente (por ejemplo, en los servicios que consumen la API).

## Contacto
Para cualquier duda o comentario, puedes contactarme en **kevin.fernandez2065@gmail.com**
