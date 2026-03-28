#!/bin/bash
# ArchDev - Bitwarden Setup Helper
# Configura o rbw (Bitwarden CLI não-oficial em Rust) para usar com rofi

set -e

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}🔐 ArchDev Bitwarden Setup${NC}"
echo "=========================================="
echo ""

if ! command -v rbw &> /dev/null; then
    echo -e "${YELLOW}⚠️  rbw não está instalado.${NC}"
    echo "   O helper assume que o ArchDev já instalou rbw e rofi-rbw."
    echo "   Volte a correr o setup com perfil dev ou full."
    exit 1
fi

echo -e "${GREEN}✅ rbw instalado${NC}"
echo ""
echo -e "${BLUE}🔧 Configuração inicial do Bitwarden${NC}"
echo "=========================================="
echo ""
echo "Você precisa configurar sua conta Bitwarden."
echo ""
echo -e "${YELLOW}Comandos necessários:${NC}"
echo ""
echo "1. Configurar email e servidor:"
echo -e "   ${BLUE}rbw config set email seu-email@exemplo.com${NC}"
echo ""
echo "2. (Opcional) Se usar servidor self-hosted:"
echo -e "   ${BLUE}rbw config set base_url https://seu-servidor.com${NC}"
echo ""
echo "3. Fazer login:"
echo -e "   ${BLUE}rbw login${NC}"
echo ""
echo "4. Sincronizar vault:"
echo -e "   ${BLUE}rbw sync${NC}"
echo ""
echo "=========================================="
echo -e "${GREEN}✅ Setup completo!${NC}"
echo ""
echo "Uso:"
echo "  Super+P → Abrir rofi-rbw (selecionar password)"
echo "  rbw list → Listar todos os itens"
echo "  rbw get 'nome do item' → Ver password"
