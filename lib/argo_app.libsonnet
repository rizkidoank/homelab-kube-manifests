local argocd = import 'argocd.libsonnet';

{
  new(name, appNamespace, project, destinationServer, destinationNamespace, chartRepo, chartName, chartVersion):: {
    application:
      argocd.argoproj.v1alpha1.application.new(name) +
      argocd.argoproj.v1alpha1.application.mixin.metadata.withNamespace(appNamespace) +
      argocd.argoproj.v1alpha1.application.mixin.spec.source.withChart(chartName) +
      argocd.argoproj.v1alpha1.application.mixin.spec.source.withRepoURL(chartRepo) +
      argocd.argoproj.v1alpha1.application.mixin.spec.source.withTargetRevision(chartVersion) +
      argocd.argoproj.v1alpha1.application.mixin.spec.withProject(project) +
      argocd.argoproj.v1alpha1.application.mixin.spec.syncPolicy.automated.withPrune(true) +
      argocd.argoproj.v1alpha1.application.mixin.spec.syncPolicy.automated.withSelfHeal(true) +
      argocd.argoproj.v1alpha1.application.mixin.spec.destination.withServer(destinationServer) +
      argocd.argoproj.v1alpha1.application.mixin.spec.destination.withNamespace(destinationNamespace)
  },
}
