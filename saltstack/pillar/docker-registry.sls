docker-containers:
  lookup:
    registry:
      image: "registry:2"
      cmd:
      runoptions:
        - "-e REGISTRY_LOG_LEVEL=debug"
        - "-e REGISTRY_HTTP_DEBUG_ADDR=0.0.0.0:5001"
        - "-p 5000:5000 -p 5001:5001"
        - "--restart=always"
        - "--name registry"