# Comandos Git ejecutados (generales para ambas ramas)
- Crear repositorio local: `git init`
- Agregar archivos iniciales: `git add index.html README.md`
- Primer commit: `git commit -m "Iniciando el repositorio con index.html y README.md"`
- Vincular remoto: `git remote add origin ...`
- Subir a main: `git push -u origin main`
- Crear rama UI: `git checkout -b feature/perfil-nuevo-ui`
- Subir rama: `git push -u origin feature/perfil-nuevo-ui`
- Commit formulario: `git commit -m "Agregado de forms y documentación"`
- Commit conflicto: `git commit -m "Agregado placeholder: simulando el conflicto"`


# Experiencias y Problemas
- Configurar dos entornos separados con claves SSH distintas fue un desafío, pero permitió simular dos colaboradores de manera efectiva.
- Aprendí a usar git rebase para actualizar una rama con cambios de otra.
- El error non-fast-forward al pushear feature/perfil-nuevo-backend se debió a un rebase forzado. Lo resolví sincronizando la rama local con la remota usando git reset --hard y re aplicando el commit.
- Perdí archivos (backend.php y el formulario en index.html) debido a un git reset --hard. Lo solucioné recreando backend.php y sincronizando index.html.
- El error merge: feature/perfil-nuevo-backend - not something we can merge ocurrió porque la rama no estaba localmente en el entorno UI. Lo pude resolver trayendo la rama con git fetch y git checkout.
- El merge de feature/perfil-nuevo-backend no generó un conflicto inicialmente porque los cambios no eran conflictivos, posiblemente debido a un merge fast-forward. Lo corregí modificando main y feature/perfil-nuevo-backend para crear un nuevo cambio conflictivo.
- Crear pull requests en GitHub fue un proceso nuevo, pero ayudó a entender cómo se documentan y revisan los cambios en un equipo.



Aquí adjunto una imagen del error del merge el cual era uno de los objetivos principales y que me había costado llegar en un principo.

![ERROR MERGE](https://github.com/user-attachments/assets/22601372-e9cc-44c5-94a6-2b1d24462f6d)
