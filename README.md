# docker_cloudflared <a href='https://github.com/padhi-homelab/docker_cloudflared/actions?query=workflow%3A%22Docker+CI+Release%22'><img align='right' src='https://img.shields.io/github/workflow/status/padhi-homelab/docker_cloudflared/Docker%20CI%20Release?logo=github&logoWidth=24&style=flat-square'></img></a>

<a href='https://hub.docker.com/r/padhihomelab/cloudflared'><img src='https://img.shields.io/docker/image-size/padhihomelab/cloudflared/latest?logo=docker&logoWidth=24&style=for-the-badge'></img></a> <a href='https://microbadger.com/images/padhihomelab/cloudflared'><img src='https://img.shields.io/microbadger/layers/padhihomelab/cloudflared/latest?logo=docker&logoWidth=24&style=for-the-badge'></img></a>

A multiarch [cloudflared] Docker image, based on [Alpine Linux].

### Supported Architectures

- `x86` (`linux/386`)
- `amd64` (`linux/amd64`)
- `arm` (`linux/arm/v6`)
- `armhf` (`linux/arm/v7`)
- `aarch64` (`linux/arm64`)
- ~~`ppc64le` (`linux/ppc64le`)~~

### Credits

#### https://github.com/crazy-max/docker-cloudflared
  - `TZ`, `HEALTHCHECK` and several small improvements were inspired by this project
  - My [Dockerfile](Dockerfile) is a little bit cleaner and uses latest version of Go



[Alpine Linux]: https://alpinelinux.org/
[cloudflared]:  https://github.com/cloudflare/cloudflared
