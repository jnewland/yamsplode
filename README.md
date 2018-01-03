# YAM(L)splode

Explodes multi-document Kubernetes YAML files into multiple files, each containing a single YAML document.

#### Motivation

For all sorts of valid reasons, folks seem to like distributing Kubernetes applications as one large file containing multiple YAML documents. I prefer to read (and sometimes edit) these sorts of files before blindly passing them to `kubectl`, and also generally prefer to store them in source control. Both of those things are way easier with a bunch of YAML files containing single documents rather than one large file. Thus, this tool.

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
