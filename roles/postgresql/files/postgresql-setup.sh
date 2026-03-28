#!/bin/bash
# ArchDev 4.0 - PostgreSQL Setup Helper

set -e

BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}🔧 ArchDev PostgreSQL Setup${NC}"
echo "=========================================="

if ! command -v psql &> /dev/null; then
    echo -e "${RED}❌ PostgreSQL não está instalado.${NC}"
    echo "   Execute o setup com o perfil dev ou full."
    exit 1
fi

if ! systemctl is-active --quiet postgresql; then
    echo -e "${YELLOW}⚠️  A iniciar PostgreSQL...${NC}"
    sudo systemctl start postgresql
fi

echo -e "${GREEN}✅ PostgreSQL está ativo${NC}"
echo ""

read -rp "Nome do utilizador da base de dados [archdev]: " APP_USER
APP_USER=${APP_USER:-archdev}

read -rp "Nome da base de dados [archdev]: " APP_DB
APP_DB=${APP_DB:-archdev}

APP_PASSWORD=$(openssl rand -base64 24 | tr -d '=+/' | cut -c1-20)

echo ""
echo -e "${BLUE}⚡ A configurar utilizador e base de dados...${NC}"

sudo -u postgres psql -v app_user="$APP_USER" -v app_db="$APP_DB" -v app_password="$APP_PASSWORD" <<'EOSQL'
DO $do$
BEGIN
  IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = :'app_user') THEN
    EXECUTE format('CREATE ROLE %I WITH LOGIN PASSWORD %L CREATEDB', :'app_user', :'app_password');
  ELSE
    EXECUTE format('ALTER ROLE %I WITH LOGIN PASSWORD %L CREATEDB', :'app_user', :'app_password');
  END IF;
END
$do$;

DO $do$
BEGIN
  IF NOT EXISTS (SELECT FROM pg_database WHERE datname = :'app_db') THEN
    EXECUTE format('CREATE DATABASE %I OWNER %I', :'app_db', :'app_user');
  END IF;

  EXECUTE format('GRANT ALL PRIVILEGES ON DATABASE %I TO %I', :'app_db', :'app_user');
END
$do$;
EOSQL

CREDENTIALS_FILE="${HOME}/.config/archdev/postgresql-credentials.txt"
mkdir -p "$(dirname "$CREDENTIALS_FILE")"

cat > "$CREDENTIALS_FILE" <<EOF
========================================
🐘 PostgreSQL Credentials - ArchDev 4.0
========================================

Host:     127.0.0.1
Port:     5432
Database: ${APP_DB}
User:     ${APP_USER}
Password: ${APP_PASSWORD}

Ligação rápida:
postgresql://${APP_USER}:${APP_PASSWORD}@127.0.0.1:5432/${APP_DB}

⚠️  GUARDE ESTE FICHEIRO EM LOCAL SEGURO!
    E apague-o depois de memorizar a password.

========================================
EOF

chmod 600 "$CREDENTIALS_FILE"

echo ""
echo -e "${GREEN}✅ PostgreSQL configurado com sucesso!${NC}"
echo ""
echo -e "${BLUE}📋 Resumo:${NC}"
echo "  • Base de dados: ${GREEN}${APP_DB}${NC}"
echo "  • Utilizador: ${GREEN}${APP_USER}${NC}"
echo "  • Password: ${GREEN}${APP_PASSWORD}${NC}"
echo "  • Credenciais guardadas em: ${YELLOW}${CREDENTIALS_FILE}${NC}"
echo ""
echo "   Teste a ligação com:"
echo -e "   ${BLUE}psql postgresql://${APP_USER}:${APP_PASSWORD}@127.0.0.1:5432/${APP_DB}${NC}"
