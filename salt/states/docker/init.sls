# 使用salt的module "pkg" 的 function "installed" 來安裝包
docker-packages:
  pkg.installed:
    - pkgs:
      - docker.io
      - docker-compose-v2

# 使用salt的module "service" 的 function "running" 來啟動運行
docker-service:
  service.running:
    - name: docker
    - enable: true
    - require:
      - pkg: docker-packages