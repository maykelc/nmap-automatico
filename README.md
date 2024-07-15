# Script de Escaneo de Redes y Servicios En entorno Linux

Este script Bash automatiza el escaneo de redes locales y servicios en un entorno Linux. Utiliza Nmap para realizar distintos tipos de escaneos y guardar los resultados en archivos de texto.

## Requisitos

- Linux
- Nmap instalado

## Funcionalidades

- **Verificación de permisos:** El script verifica si se ejecuta como usuario root para funciones específicas de red.
- **Instalación de Nmap:** Si Nmap no está instalado, el script lo instala automáticamente.
- **Escaneo de hosts activos:** Escanea la red local para identificar hosts activos y guarda los resultados en `hosts_activos.txt`.
- **Opciones de escaneo:** Ofrece varias opciones de escaneo:
  - Escaneo rápido pero ruidoso
  - Escaneo normal
  - Escaneo silencioso
  - Escaneo de servicios y versiones
  - Escaneo de puertos abiertos con lista de hosts activos
- **Resultados:** Cada opción de escaneo guarda su resultado en un archivo de texto correspondiente.

## Uso

1. Clona este repositorio 
2. Ejecuta el script como usuario root:
   ```bash
   sudo ./nombre_del_script.sh


Notas
Asegúrate de revisar los archivos de salida (*.txt) para analizar los resultados de los escaneos.
Algunos escaneos pueden tardar más tiempo dependiendo del tamaño de la red y la configuración del escaneo.mkh


******************* Este script es proporcionado como está. Úsalo bajo tu propia responsabilidad.  *******************




   
