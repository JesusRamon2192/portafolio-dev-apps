# Documentación Técnica del Proyecto (READMEtechnical)

Este documento detalla las especificaciones técnicas del proyecto del portafolio, así como una explicación sencilla de las tecnologías clave utilizadas: Reflex y Bun.

## Especificaciones del Proyecto

El proyecto está diseñado y configurado para ejecutarse en un contenedor Docker, lo que garantiza que funcione de manera idéntica en cualquier entorno (como tu Raspberry Pi o tu máquina local de desarrollo).

- **Lenguaje Principal:** Python 3.11
- **Framework Web:** Reflex (Frontend y Backend en un solo código)
- **Gestor de Dependencias y Runtime JS:** Bun (y npm como respaldo/compatibilidad)
- **Despliegue:** Docker y Docker Compose
- **Puertos:** 
  - Frontend expuesto internamente en el puerto `3000` (Mapeado al `8888` en Docker Compose).
  - Backend expuesto en el puerto `8001`.
- **Persistencia de Datos:** Volumen de Docker asociado a `./assets` para mantener los archivos multimedia y datos JSON sincronizados.

---

## ¿Qué es Reflex y cómo funciona aquí?

**Reflex** es un framework de desarrollo web que te permite construir aplicaciones web completas (tanto la interfaz de usuario como la lógica del servidor) **escribiendo únicamente código en Python**. 

### ¿Cómo funciona en términos simples?
Cuando escribes tu portafolio usando Reflex, no tienes que lidiar directamente con HTML, CSS, JavaScript o React. 

1. **Tu Código:** Escribes componentes web y lógica usando Python puro.
2. **El Frontend (Lo que el usuario ve):** Reflex toma tu código de interfaz en Python y lo "traduce" (compila) automáticamente a una aplicación moderna de **React (Next.js)**.
3. **El Backend (El motor de fondo):** Reflex crea un servidor rápido usando **FastAPI** en Python para manejar los datos, el estado y las operaciones en segundo plano.
4. **Comunicación:** El frontend en React se comunica en tiempo real con el backend en FastAPI usando WebSockets.

En este repositorio, el comando `reflex init` y `reflex export` (dentro del `Dockerfile`) se encargan de generar los archivos estáticos de tu interfaz de usuario listos para producción.

---

## ¿Qué es Bun y cómo funciona aquí?

**Bun** es una herramienta todo-en-uno para el ecosistema de JavaScript. Funciona como un entorno de ejecución (como Node.js), pero también como un instalador de paquetes (como npm) y un empaquetador (bundler). **Su principal característica es que es increíblemente rápido.**

### ¿Cómo funciona en términos simples?
Aunque estás programando en Python con Reflex, recuerda que Reflex, por detrás, necesita crear una aplicación de React (JavaScript) para tu frontend.

1. **El trabajo de Bun:** Para que Reflex pueda construir el frontend en React, necesita descargar e instalar muchas librerías de JavaScript y luego compilar ese código para que el navegador lo entienda.
2. **Velocidad:** Originalmente, Reflex usaría `npm` (el gestor clásico de Node.js) para esto. Sin embargo, en tu `Dockerfile` se instala y configura **Bun** porque hace este mismo proceso de descarga y compilación muchísimo más rápido.
3. **En el repositorio:** Bun actúa como el motor "invisible" que Reflex llama internamente cuando detecta que necesita construir o actualizar la parte web de tu aplicación. Esto reduce los tiempos de construcción de tu imagen Docker significativamente.
