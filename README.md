# Yam(l)splode

Explodes multi-document Kubernetes YAML files into multiple files.

#### Motivation

For all sorts of reasons, folks seem to like distributing Kubernetes applications as one large file containing multiple documents. I like storing Kubernetes YAML in source control, and prefer to store each YAML document in an unique file so I can review and edit it before blindingly passing it to `kubectl`. Thus, this tool.

# Usage

`yamsplode` is distributed as a Docker image that expects a single YAML file at `in.yaml`, and a directory at `/out`.

    docker run --rm \
      -v ~/Downloads/istio-0.4.0/install/kubernetes/istio-auth.yaml:/in.yaml \
      -v ~/src/kubernetes-config/istio:/out \
      jnewland/yamsplode

    Writing /out/namespaces/istio-system.yaml ...
    Writing /out/clusterroles/istio-pilot-istio-system.yaml ...
    Writing /out/clusterroles/istio-initializer-istio-system.yaml ...
    Writing /out/clusterroles/istio-mixer-istio-system.yaml ...
    Writing /out/clusterroles/istio-ca-istio-system.yaml ...
    Writing /out/clusterroles/istio-sidecar-istio-system.yaml ...

That's it.
