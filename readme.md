# Download latest version and set environment path (if windows machine)
# Trivy container scanning:
Before this container should run.
# Export the container filesystem
docker export form_container1 -o container.tar

# Scan the rootfs tarball
trivy rootfs container.tar
Trivy Image scanning:
trivy image simple-php-app:latest
# file system scanning:
  -> For security scanning → use trivy rootfs.
  -> For local code scanning → use trivy fs.
  -> For manual inspection → docker exec -it ..
    trivy fs .
    trivy fs E:\docker\simple-php-application
# Manually scanning (By interacting)
docker exec -it form_container1 sh
