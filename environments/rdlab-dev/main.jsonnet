local tanka = import 'github.com/grafana/jsonnet-libs/tanka-util/main.libsonnet';
local helm = tanka.helm.new(std.thisFile);
local bootstrap = import 'bootstrap.libsonnet';

{
  bootstrap: bootstrap.new('infrastructure'),
}
