What this is: a local GitOps sandbox — Terraform provisions a kind cluster and bootstraps Argo CD, which then syncs application state from [gitops repo link].
Why: to run the GitOps workflow end to end on my own machine, including the bootstrap problem (who installs the thing that installs everything).
Stack: Terraform · kind · Argo CD · Helm
Run it: terraform init && terraform apply → Argo CD UI at localhost:… → credentials via kubectl -n argocd get secret …
Design notes: infra and app config live in separate repos so cluster lifecycle is decoupled from application state.