# ArchDev 4.0 - Wrapper Operations

## Objetivo

Este guia resume os comandos operacionais do wrapper `scripts/archdev` no fluxo 4.0.

## Comandos principais

```bash
scripts/archdev explain full
scripts/archdev profiles
scripts/archdev status
scripts/archdev doctor
scripts/archdev apply minimal
scripts/archdev apply dev
scripts/archdev apply full
scripts/archdev rollback list
scripts/archdev rollback <snapshot_id>
```

## `profiles`

Lista os perfis declarativos disponíveis a partir dos ficheiros reais em:

```text
inventories/group_vars/profiles/
```

Use este comando para confirmar rapidamente o que o wrapper considera válido.

## `explain`

Mostra, sem alterar nada, o contexto que o wrapper usará para um perfil:

- ficheiro do perfil resolvido
- flags `feature_*` desse perfil
- ficheiros de features que `site-4.yml` espera carregar
- contexto local conhecido pelo wrapper para o host actual

Exemplo:

```bash
scripts/archdev explain full
scripts/archdev explain dev
```

## `status`

Mostra o estado operacional do wrapper antes de um `apply`.

Inclui:

- host detetado
- caminho esperado de `inventories/host_vars/<hostname>.yml`
- perfil efectivo conhecido pelo wrapper
- perfis declarativos disponíveis
- hardware, modo gráfico, `GPU overrides`, `ZRAM` e `Wlsunset`
- resumo do último `apply`, incluindo snapshots quando existirem

## `doctor`

O `doctor` continua a ser não destrutivo.

Além das validações de sistema e desenvolvimento, agora também valida o contexto declarativo do wrapper:

- diretório de perfis
- diretório de features
- perfil actual conhecido pelo wrapper
- presença dos ficheiros declarativos de features
- presença do `host_vars` esperado para o host actual

## `apply`

O `apply` continua a usar:

- deteção assistida de hardware
- `playbooks/site-4.yml`
- snapshots `pre` e `post` quando `snapper` estiver pronto
- `doctor` automático no fim

## `rollback`

Use rollback apenas quando necessário e de forma controlada:

```bash
scripts/archdev rollback list
scripts/archdev rollback 123
```

Se um `apply` falhar na validação final, o wrapper mostra o snapshot `pre-apply` quando disponível.
