local argocd = import 'argocd.libsonnet';
local argo_app = import 'argo_app.libsonnet';
local tanka = import 'github.com/grafana/jsonnet-libs/tanka-util/main.libsonnet';
local k = import 'k.libsonnet';

{
  new(namespace):: {
    traefik: 
      argo_app.new("traefik", namespace, "default", "https://kubernetes.default.svc", namespace, "https://traefik.github.io/charts", "traefik", "31.1.1")
  },
}
