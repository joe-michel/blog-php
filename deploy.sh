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

# To transfer a file securely to another machine - type:
scp file1.txt example@server2:$HOME
# This example presents transferring file1.txt from our host to server2 's user tom 's home directory.
# scp can serve to send mutltiple files from a server to another, just send the all folder

# Show all process paginated
ps -e | less
# ps -e shows all the processes, its output is connected to the input of more via | , less paginates the results.

# the conditionnal staement (if) takes many flags to perform conditionnal tests
# -e file is true if a specific file/directory exists
# -z string is true if  the given string is empty
# string1 = string2 is true if specific the two string are equals
