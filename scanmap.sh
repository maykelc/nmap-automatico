#!/bin/bash

# Definir colores
sin_color='\033[0m'
rojo_luminoso='\033[1;31m'
cyan_luminoso='\033[1;36m'

# Función para mostrar mensaje de error y salir
mostrar_error() {
  echo -e "${rojo_luminoso}Error: $1${sin_color}"
  exit 1
}

# Verificar si se ejecuta como root
if [ "$(id -u)" -ne 0 ]; then
  mostrar_error "Debes ser usuario root para ejecutar el script"
fi

# Verificar si Nmap está instalado y si no, instalarlo
if ! command -v nmap &> /dev/null; then
  echo -e "${cyan_luminoso}Instalando Nmap...${sin_color}"
  apt update >/dev/null || mostrar_error "No se pudo actualizar la lista de paquetes"
  apt install nmap -y >/dev/null || mostrar_error "No se pudo instalar Nmap"
  echo -e "${cyan_luminoso}Nmap instalado${sin_color}"
fi

# Obtener la dirección IP de la red local
ip_red=$(ip route | awk '/default/ {print $3}' | cut -d"." -f1-3)

# Realizar un escaneo de ping en la red local
nmap -sn $ip_red.0/24 | grep "report for" | cut -d" " -f5 > hosts_activos.txt

echo -e "${cyan_luminoso}Hosts activos guardados en hosts_activos.txt${sin_color}"

# Menú de opciones para el usuario
while true; do
  echo -e "\n1) Escaneo rápido pero ruidoso"
  echo "2) Escaneo normal"
  echo "3) Escaneo silencioso (puede tardar más de lo normal)"
  echo "4) Escaneo de servicios y versiones"
  echo "5) Escanear puertos abiertos con escaneo rápido y ruidoso"
  echo "6) Salir"
  read -p "Seleccione una opción: " opcion
  case $opcion in 
    1)
      clear && echo "Escaneando rápido pero ruidoso..." && nmap -p- --open --min-rate 5000 -T5 -sS -Pn -n -v $ip > escaneo_potente.txt && echo -e "${cyan_luminoso}Reporte guardado en escaneo_potente.txt${sin_color}"
      ;;
    2)
      clear && echo "Escaneando normal..." && nmap -p- --open $ip > escaneo_normal.txt && echo -e "${cyan_luminoso}Reporte guardado en el fichero escaneo_normal.txt${sin_color}"
      ;;
    3)
      clear && echo "Escaneando silencioso..." && nmap -p- -T2 -sS -Pn -f $ip > escaneo_silencioso.txt && echo -e "${cyan_luminoso}Reporte guardado en el fichero escaneo_silencioso.txt${sin_color}"
      ;;
    4)
      clear && echo "Escaneando servicios..." && nmap -sV -sC $ip > escaneo_servicios.txt && echo -e "${cyan_luminoso}Reporte guardado en el fichero escaneo_servicios.txt${sin_color}"
      ;;
    5)
      clear && echo "Escaneando Host Activos (rapido y ruidoso)..." && nmap -p- --open --min-rate 5000 -T5 -sS -Pn -n -v -iL hosts_activos.txt > scan-host-activos.txt && echo -e "${cyan_luminoso}Reporte guardado en el fichero scan-host-activos.txt${sin_color}"
      ;;
    6)
      break
      ;;
    *)
      echo -e "NO SE HA ENCONTRADO EL PARÁMETRO, INTRODUZCA UN VALOR CORRECTO"
      ;;
  esac
done
