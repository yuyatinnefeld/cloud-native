# Node Affinity
- You can constrain a Pod so that it is restricted to run on particular node(s), or to prefer to run on particular nodes. There are several ways to do this and the recommended approaches all use label selectors to facilitate the selection.
- Kubernetes node affinity is an advanced scheduling feature that helps administrators optimize the distribution of pods across a cluster.
- Node Affinity is more flexible then label selectors

## Setup
```bash
# you can only select the labe
cat pod_1.yaml

# you can define flexible with node affinity (select not small size node)
cat pod_2.yaml
```