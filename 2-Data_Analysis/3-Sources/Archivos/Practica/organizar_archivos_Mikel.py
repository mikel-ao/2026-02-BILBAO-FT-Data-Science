def organizar_archivos():
    # Iteramos sobre cada elemento en la carpeta
    for archivo in os.listdir(folder_path):
        ruta_archivo = os.path.join(folder_path, archivo)

        # 1. Ignoramos si es una carpeta (para no mover las carpetas destino)
        if os.path.isdir(ruta_archivo):
            continue

        # 2. Obtenemos la extensión
        _, extension = os.path.splitext(archivo)
        extension = extension.lower() # Normalizamos a minúsculas

        # 3. Clasificamos el destino
        if extension in img_types:
            carpeta_destino = 'Imagenes'
        elif extension in doc_types:
            carpeta_destino = 'Documentos'
        elif extension in software_types:
            carpeta_destino = 'Software'
        else:
            carpeta_destino = 'Otros'

        # 4. Movemos el archivo a su nueva casa
        destino_final = os.path.join(folder_path, carpeta_destino, archivo)
        shutil.move(ruta_archivo, destino_final)
        print(f"Organizado: {archivo} -> {carpeta_destino}")

# Ejecutamos la organización
if __name__ == "__main__":
    organizar_archivos()
    print("-" * 20)
    print("¡Proceso de automatización finalizado!")