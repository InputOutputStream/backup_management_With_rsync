# Backup Management With Rsync

Ce dépôt contient trois scripts Bash permettant de gérer des sauvegardes et de nettoyer les répertoires obsolètes. Voici un aperçu des fonctionnalités :  
1. **Script 1 : Nettoyage des sauvegardes obsolètes**  
   Supprime les répertoires de sauvegarde devenus obsolètes en fonction d’une date d’expiration.  
2. **Script 2 : Sauvegarde complète**  
   Effectue une sauvegarde complète entre un répertoire source et un répertoire de destination, en utilisant `rsync`.  
3. **Script 3 : Sauvegarde incrémentielle**  
   Réalise une sauvegarde incrémentielle avec des sauvegardes liées, en excluant certains jours de la semaine.  

---

## Script 1 : Nettoyage des sauvegardes obsolètes

### Description
Ce script permet de supprimer les répertoires de sauvegarde obsolètes, en se basant sur une durée d’expiration spécifiée. Les répertoires doivent contenir une date valide dans leur nom au format `jj-mm-aaaa`.

### Utilisation
```bash
chmod u+x ./script_nettoyage_backup.sh
./script_nettoyage_backup.sh backup_dir exp_days
```
## backup_dir : Chemin absolu du répertoire contenant les sauvegardes.
## exp_days : Nombre de jours avant qu’un répertoire soit considéré comme obsolète.
## Exemple
```bash
./script_nettoyage_backup.sh /home/user/backups 30
```
Cela supprimera tous les répertoires dans /home/user/backups datant de plus de 30 jours.

### Script 2 : Sauvegarde complète
Description
Ce script effectue une sauvegarde complète d’un répertoire source vers un répertoire de destination. Il utilise rsync pour synchroniser les fichiers. Les deux répertoires doivent être accessibles depuis la machine locale.

# Remarque
Ce script ne supporte pas les sauvegardes entre deux hôtes distants. Par exemple, une commande comme :

```bash
./script_sauvegarde_complete.sh user@hostname:/src_dir user@hostname2:/dst_dir
```
renverra une erreur, car rsync ne prend pas en charge ce scénario.

# Utilisation
```bash
chmod u+x ./script_sauvegarde_complete.sh
./script_sauvegarde_complete.sh src_dir dst_dir
```
src_dir : Chemin absolu du répertoire source (local ou distant).
dst_dir : Chemin absolu du répertoire de destination (local ou distant).

# Exemple
```bash
./script_sauvegarde_complete.sh /home/user/data /backup
```

Effectue une sauvegarde complète de /home/user/data vers /backup.

### Script 3 : Sauvegarde incrémentielle
Description
Ce script réalise une sauvegarde incrémentielle avec des sauvegardes liées. Une nouvelle sauvegarde est créée chaque jour, et les fichiers non modifiés sont liés à partir de la dernière sauvegarde. Les jours spécifiés, comme le dimanche, sont exclus des sauvegardes.

# Utilisation
```bash
chmod u+x ./script_sauvegarde_differentielle.sh
./script_sauvegarde_differentielle.sh src_dir dst_dir last_backup_dir
```
src_dir : Chemin absolu du répertoire source (local ou distant).
dst_dir : Chemin absolu du répertoire de destination (local).
last_backup_dir : Chemin de la dernière sauvegarde pour effectuer une sauvegarde incrémentielle (optionnel).
# Exemple
```bash
./script_sauvegarde_differentielle.sh /home/user/data /backup /backup/last_backup
```
Réalise une sauvegarde incrémentielle de /home/user/data vers /backup, en utilisant /backup/last_backup comme référence.

# Dépendances
rsync : Utilisé pour synchroniser les fichiers.
date : Pour manipuler et formater les dates.
# Notes importantes
Permissions d’exécution : Assurez-vous que les scripts ont les permissions nécessaires pour être exécutés :
```bash
chmod +x script_nettoyage_backup.sh
chmod +x script_sauvegarde_complete.sh
chmod +x script_sauvegarde_differentielle.sh
```
'''Test avant production''' : Testez les scripts dans un environnement sécurisé pour éviter toute perte de données.
'''Gestion des erreurs''': Les scripts incluent des vérifications de base pour éviter les erreurs d’utilisation, mais l’utilisateur est responsable de fournir des chemins valides.




