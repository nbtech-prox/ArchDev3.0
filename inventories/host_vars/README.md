# Host Vars

Coloque aqui overrides específicos por máquina para a futura arquitectura 4.0.

O `scripts/archdev apply <perfil>` já consegue gerar este ficheiro automaticamente com deteção assistida de hardware.

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
