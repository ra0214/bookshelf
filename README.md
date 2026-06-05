# BookShelf Club 📚

BookShelf Club es una plataforma móvil avanzada diseñada para lectores apasionados que buscan organizar su biblioteca personal de manera eficiente y elegante. Construida con los más altos estándares de desarrollo en Flutter, la aplicación ofrece una experiencia fluida para la gestión de lecturas.

## 🚀 Características Principales

### 🔐 Autenticación Segura
- Sistema de inicio de sesión y registro de usuarios integrado con servicios de autenticación.
- Gestión de perfiles y persistencia de sesión.

### 📖 Gestión de Biblioteca (CRUD)
- **Registro de Libros:** Añade nuevas obras a tu colección con detalles completos (título, autor, descripción y calificación).
- **Control de Lectura:** Organiza tus libros en categorías dinámicas: "Por leer", "Leyendo" y "Leídos".
- **Edición en Tiempo Real:** Actualiza la información y el estado de tus libros conforme avanzas en tus lecturas.
- **Calificaciones:** Sistema de valoración por estrellas para tus libros terminados.

### 🎨 Interfaz de Usuario Premium
- Basada en **Material Design 3.0**.
- Experiencia de usuario inmersiva con `Slivers` y navegación fluida.
- Tipografía cuidadosamente seleccionada para una lectura cómoda.

## 🛠️ Stack Tecnológico

- **Framework:** Flutter 3
- **Lenguaje:** Dart
- **Gestión de Estado:** Provider
- **Arquitectura:** Clean Architecture + Vertical Slicing
- **Patrón de Diseño:** MVVM (Model-View-ViewModel)
- **Cliente HTTP:** Http (Integración con API RESTful)
- **Fuentes:** Google Fonts (Merriweather & Roboto)

## 🏗️ Arquitectura del Proyecto

El proyecto sigue una estructura de **Arquitectura Limpia** con un enfoque de **Screaming Architecture**, donde cada funcionalidad (feature) es independiente:

```text
lib/
├── core/           # Estilos compartidos y temas
├── shared/         # Utilidades y componentes genéricos
└── features/       # Funcionalidades del dominio
    ├── auth/       # Módulo de Autenticación
    └── books/      # Módulo de Gestión de Libros
```

Cada módulo implementa el patrón **MVVM**:
- **Model:** Representación de los datos y lógica de dominio.
- **ViewModel:** Gestión del estado y lógica de negocio reactiva.
- **View:** Interfaz de usuario declarativa que responde a cambios del ViewModel.

## 📥 Instalación

1. Clona el repositorio:
   ```bash
   git clone https://github.com/tu-usuario/bookshelf-club.git
   ```
2. Instala las dependencias:
   ```bash
   flutter pub get
   ```
3. Ejecuta la aplicación:
   ```bash
   flutter run
   ```

---
Desarrollado con ❤️ para amantes de la lectura.
