# ArchDev 4.0 - Plano de Migração

## Fase 1

- manter a 3.x funcional
- adicionar wrapper `scripts/archdev`
- adicionar `playbooks/site-4.yml` como entrada declarativa compatível
- documentar arquitectura futura

## Fase 2

- separar perfis em ficheiros declarativos
- separar roles por domínio funcional
- reduzir AUR crítico

## Fase 3

- `doctor` completo
- rollback controlado
- testes reais em VM

## Fase 4

- host tuning por máquina
- workflow atomic-like mais consistente
- documentação operacional final

## Estado actual

- perfis declarativos já existem
- features declarativas já existem
- `site-4.yml` já carrega `host_vars` por hostname
- `scripts/archdev apply` já faz deteção assistida de hardware e grava `host_vars`
- o fluxo já trata VMs com renderer/software defaults seguros para `Hyprland`
- `doctor` já valida por perfil (`minimal`, `dev`, `full`) e por tipo de hardware
- os perfis `minimal` e `full` já passaram em VM Arch Linux limpa
- a separação dos roles de desenvolvimento já começou
- a separação de `common` e `system` também já começou no fluxo 4.0
