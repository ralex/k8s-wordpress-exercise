
# Prerequisites

* [Minikube|https://github.com/ralex/salt-laptop/tree/master/minikube]
* Helm

# Install project

```
terraform init
terraform apply
```

Then, open Wordpress blog in your default browser:
```
x-www-browser $(minikube service my-wordpress-release -n tp --url | head -1)
```

# Scaling

## Pods

Since we are working on a minikube environment, scaling is not a concern but we are able to scale wordpress pods.
As mariadb is served with a Statefulset, we need to configure replication mode with at least a master and a slave to scale replicas.

## Resources requests / limits

CPU and memory requests need to be sized large enough to allow containers starting without beeing throttled.
In a minikube environment with low resources, it helps ensuring a minimum. In a production environment, setting resources requests ensure pods will be scheduled on nodes with sufficient ressources.

CPU and memory limits are used to avoid our pods consuming all resources on our minikube node.
Since limits resources are "preallocated", it can be a problem in a minikube environment running on low cpu/memory.
