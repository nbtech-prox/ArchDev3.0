# ArchDev 4.0 - Perfis

## minimal

- desktop base
- terminal
- browser
- segurança
- Btrfs / snapshots

## dev

- tudo do `minimal`
- Laravel / PHP
- PostgreSQL
- Docker
- Python
- Node / OpenCode

## full

- tudo do `dev`
- extras de produtividade e trabalho
- ferramentas avançadas de base de dados
- frontend / CLI adicionais

## Features separadas

As features devem ser activáveis sem obrigar a um perfil inteiro.

Exemplos:

- `feature_desktop`
- `feature_laravel`
- `feature_postgresql`
- `feature_docker`
- `feature_opencode`
- `feature_redis`
- `feature_dbeaver`

## Deteção assistida de hardware

No fluxo 4.0, `scripts/archdev apply <perfil>` passa primeiro por deteção assistida de hardware.

O wrapper:

- deteta VM vs bare metal
- deteta CPU, RAM e modo gráfico
- propõe defaults seguros
- pede confirmação rápida
- grava o resultado em `inventories/host_vars/<hostname>.yml`

Isto separa claramente:

- `perfil` = o que instalar
- `host_vars` = como adaptar a instalação à máquina real
