# traefik-defaultbackend

Default backend dla Traefika na klastrze rpi-k3s: serwuje stronę **shpaq.org**
dla żądań trafiających na gołe IP LoadBalancera lub nieznane hostname'y
(odpowiednik `defaultBackend` z ingress-nginx).

## Zawartość

`site/index.html` + `site/robots.txt` to kopia strony shpaq.org.
Źródłem prawdy jest ConfigMap w `rpi-k3s/cluster/helm/shpaq-org/templates/configmap.yaml` —
po zmianie strony zsynchronizuj pliki tutaj i wydaj nowy tag obrazu.

## Obraz

Bazuje na `nginxinc/nginx-unprivileged` (nginx stable, non-root, uid 101,
nasłuch na **8080**), dzięki czemu pod w charcie może działać z
`readOnlyRootFilesystem`, bez capabilities i jako non-root.

```bash
make image    # buduje lokalnie (linux/arm64)
make run      # smoke test na http://localhost:8080
make release  # build & push do Docker Hub (szpaczyn/traefik-defaultbackend-arm64)
```

Nowa wersja = podbicie `VERSION` w Makefile + tag w
`rpi-k3s/cluster/helm/defaultbackend/values.yaml`.

## Routing

Catch-all HTTPRoute (`cluster/helm/defaultbackend`, bez `hostnames`) podpina
ten backend pod listenery `web`/`websecure` gatewaya `traefik-gateway`.
Trasy z konkretnymi hostname zawsze mają priorytet nad tą trasą.
