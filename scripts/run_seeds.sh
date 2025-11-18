#!/bin/bash

# Obter o diretório do script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# Carregar configurações
source "./config/database_config.sh"

echo "Executando seeds no banco: $DB_NAME"

# Executar todos os arquivos de seed em ordem
for seed_file in $(ls "./seed_data"/*.sql | sort); do
    echo "Aplicando seed: $(basename "$seed_file")"
    PGPASSWORD=$DB_PASSWORD psql -h $DB_HOST -p $DB_PORT -U $DB_USER -d $DB_NAME -f "$seed_file"
    
    if [ $? -eq 0 ]; then
        echo "✓ Seed $(basename "$seed_file") aplicado com sucesso"
    else
        echo "✗ Erro no seed $(basename "$seed_file")"
        exit 1
    fi
done

echo "Todos os seeds foram executados!"