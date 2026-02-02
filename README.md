# 📰 NewsApp-VIPER-SwiftUI

Un ejemplo robusto de arquitectura **VIPER** aplicada a **SwiftUI**. 
Este proyecto fue diseñado con un enfoque dual: demostrar mejores prácticas de arquitectura 
para entornos profesionales y servir como guía educativa para desarrolladores que desean aprender a escalar apps en Swift.

---

## 🚀 Características (Features)
- **Consumo de API:** Integración con NewsAPI usando `URLSession`.
- **Arquitectura VIPER:** Separación estricta de responsabilidades (View, Interactor, Presenter, Entity, Router).
- **UI Moderna:** Construida 100% en SwiftUI con soporte para Modo Oscuro.
- **Búsqueda Reactiva:** Filtrado de noticias en tiempo real a través del Presenter.
- **Manejo de Estados:** Implementación de estados de carga (`isLoading`), errores y datos vacíos.

---

## 🏗️ Arquitectura: ¿Por qué VIPER?

En este proyecto, se optó por VIPER sobre MVVM para demostrar cómo manejar la lógica de navegación y de negocio de forma totalmente independiente:

* **View:** Recibe eventos del usuario y muestra lo que el Presenter le indica.
* **Interactor:** Contiene la lógica de negocio pura (Llamadas a la API). Es agnóstico a la UI.
* **Presenter:** El "cerebro". Recibe datos del Interactor y los prepara para la Vista.
* **Entity:** Modelos de datos simples (`Article`, `Source`).
* **Router:** Gestiona la navegación y el ensamblaje (Dependency Injection) del módulo.

---

## 🛠️ Tecnologías Utilizadas
- **Swift 6.0**
- **SwiftUI**
- **Foundation (URLSession)**
- **Combine** (para el manejo de estados reactivos)

---

## 📸 Screenshots
| Lista de Noticias | Detalle de Noticia | Búsqueda |
|---|---|---|
| ![Listado](https://via.placeholder.com/200x400.png?text=Noticias+List) | 
![Detalle](https://via.placeholder.com/200x400.png?text=Noticia+Detail) | 
![Busqueda](https://via.placeholder.com/200x400.png?text=Search+Feature) |

> *.*

---

## 📖 Guía para Estudiantes

Si estás aprendiendo VIPER, fíjate en estos puntos clave del código:
1. **El Router:** Mira cómo se inyectan las dependencias en `NewsRouter.createModule()`.
2. **Protocolos:** Cada componente se comunica a través de protocolos, lo que facilita las pruebas unitarias.
3. **Weak References:** Nota cómo el `presenter` dentro del Interactor es `weak` para evitar ciclos de retención de memoria.

---
