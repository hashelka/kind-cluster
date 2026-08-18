# kind-cluster

Terraform provisions a local kind cluster and bootstraps Argo CD into it.
From that point the cluster manages itself: Argo CD reads the desired
state from [gitops](https://github.com/hashelka/gitops) and reconciles.

This repo is the infrastructure half of a two-repo GitOps sandbox.

## Run it

Requires Docker, Terraform and kubectl.

```bash
terraform init
terraform apply
```

Argo CD admin password:

```bash
kubectl -n argocd get secret argocd-initial-admin-secret \
  -o jsonpath='{.data.password}' | base64 -d
```

Port-forward the UI:

```bash
kubectl -n argocd port-forward svc/argocd-server 8080:443
```

Tear down with `terraform destroy`.

## Layout

| File | Purpose |
|---|---|
| `cluster.tf` | kind cluster definition |
| `argocd.tf` | Argo CD installation |
| `variable.tf` / `outputs.tf` | inputs and outputs |

## Design notes

- **Infra and application state live in separate repos.** The cluster
  changes on a different cadence than what runs inside it, and mixing
  the two means every app change touches infrastructure code.
- **Terraform handles the bootstrap problem only** — someone has to
  install the thing that installs everything else. Once Argo CD is
  running, further changes go through git, not through `terraform apply`.
- **Local by design.** kind keeps the whole loop reproducible on a
  laptop: destroy, recreate, verify the bootstrap actually works from
  zero rather than from a cluster that accumulated manual fixes.