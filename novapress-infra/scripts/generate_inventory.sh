#!/bin/bash

# Arrête le script immédiatement si une commande échoue
set -e

# Récupère le chemin absolu du dossier contenant ce script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Déclare la liste complète des environnements à gérer
ALL_ENVS=("dev" "preprod" "prod")

# Si un environnement est fourni en argument, on ne traite que celui-ci ; sinon on parcourt tous les environnements
if [[ -n "$1" ]]; then
  ENVIRONMENTS=("$1")
else
  ENVIRONMENTS=("${ALL_ENVS[@]}")
fi

# On traite chaque environnement un par un
for ENV in "${ENVIRONMENTS[@]}"; do
  echo "Processing environment: $ENV"

  # Détermine le chemin du dossier Terraform correspondant à l’environnement
  ENV_DIR="${SCRIPT_DIR}/../terraform/infra/envs/${ENV}"

  # Vérifie que le dossier de l’environnement existe
  if [[ ! -d "$ENV_DIR" ]]; then
    echo "Environment directory not found: $ENV_DIR"
    continue  # Passe à l’environnement suivant
  fi

  # Se positionne dans le répertoire de l’environnement
  cd "$ENV_DIR"

  # Génère le fichier d’inventaire Ansible à partir de la sortie Terraform
  terraform output -raw ansible_inventory > "${SCRIPT_DIR}/../ansible/inventory/${ENV}.yml"

  echo "Ansible inventory file for $ENV generated successfully"
done

# Fin de traitement de tous les environnements spécifiés
echo "All inventory files have been generated."
