#!/usr/bin/env bash

# la méthode rsync utilise SSH par défaut
# gestion du port pour le SSH
rsync -avz source -e "ssh -p port" user@ip:"/chemin/de destination avec espaces/"

# copie du dossier <source> vers le serveur ou <destination>
rsync -e ssh -avz --delete-after /home/source user@ip_du_serveur:/dossier/destination/

# commande pour exclure des fichiers avec rsync
rsync --exclude="nom_de_dossier" --exclude="- autre_nom_de_dossier" source/ destination/
# avec un fichier
rsync --exclude-from=ExclusionRSync source/ destination/
#ExclusionRSync de la forme: tmp
#                             .Trash
#                             .cache
#                             .PlayOnLinux

# rsync --progress option displays detailed progress of rsync execution as shown below.
