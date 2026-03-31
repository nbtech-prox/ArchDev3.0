# Host Vars

Coloque aqui overrides específicos por máquina para a futura arquitectura 4.0.

O `scripts/archdev apply <perfil>` já consegue gerar este ficheiro automaticamente com deteção assistida de hardware.
Quando `archdev_enable_wlsunset: true`, o wrapper também pode gravar `wlsunset_latitude` e `wlsunset_longitude` para evitar defaults errados na máquina real.

Antes de aplicar, pode usar:

```bash
scripts/archdev status
```

para confirmar qual o hostname detetado e qual o ficheiro `inventories/host_vars/<hostname>.yml` que o wrapper espera usar.

Exemplo:

```text
inventories/host_vars/nbtech-workstation.yml
```

Variáveis típicas para mover para aqui:

- `archdev_hardware_type`
- `archdev_cpu_vendor`
- `archdev_graphics_mode`
- `archdev_enable_gpu_overrides`
- `archdev_sddm_theme`
- `primary_gpu_drm_path`
- `secondary_gpu_drm_path`
- `archdev_target_ram_mb`
- `archdev_enable_zram`
- coordenadas de `wlsunset`
- tuning local de bases de dados ou serviços

Overrides especialmente úteis para máquina real:

- `wlsunset_latitude`
- `wlsunset_longitude`
- `archdev_postgresql_shared_buffers`
- `archdev_postgresql_effective_cache_size`
- `archdev_postgresql_work_mem`
- `archdev_postgresql_maintenance_work_mem`
- `archdev_postgresql_wal_buffers`
- `archdev_postgresql_max_connections`
