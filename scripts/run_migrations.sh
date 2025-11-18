#!/bin/bash

# Carregar configurações
source ./config/database_config.sh

echo "Conectando ao banco: $DB_NAME em $DB_HOST:$DB_PORT"

# Função para verificar se migration já foi executado
is_migration_applied() {
    local version=$1
    psql -h $DB_HOST -p $DB_PORT -U $DB_USER -d $DB_NAME -t -c "SELECT 1 FROM schema_migrations WHERE version = '$version'" | grep -q 1
}

# Executar cada migration
for migration in $(ls ./migrations/*.sql | sort); do
    version=$(basename $migration | cut -d'_' -f1)
    
    if ! is_migration_applied $version; then
        echo "Aplicando migration: $migration"
        psql -h $DB_HOST -p $DB_PORT -U $DB_USER -d $DB_NAME -f $migration
        
        if [ $? -eq 0 ]; then
            psql -h $DB_HOST -p $DB_PORT -U $DB_USER -d $DB_NAME -c "INSERT INTO schema_migrations (version, name) VALUES ('$version', '$(basename $migration)')"
            echo "✓ Migration $version aplicado com sucesso"
        else
            echo "✗ Erro no migration $version"
            exit 1
        fi
    else
        echo "→ Migration $version já aplicado"
    fi
done

echo "Todas as migrations foram executadas!"

echo ""
echo "Executando seeds..."
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

echo "Todas as migrations e seeds foram executadas!"