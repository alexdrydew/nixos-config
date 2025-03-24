_: {
  programs.k9s = {
    enable = true;
    plugin = {
      plugins = {
        debug = {
          shortCut = "Shift-D";
          description = "Add debug container";
          scopes = ["containers"];
          command = "bash";
          background = false;
          confirm = true;
          args = [
            "-c"
            ''
              REGISTRY=$([[ $CONTEXT == prod-* ]] && echo "tlkprodregistry" || echo "tlktestregistry");
              kubectl debug -it -n=$NAMESPACE --context=$CONTEXT $POD --target=$NAME \
                --image=$REGISTRY.azurecr.io/backend/java-debug-light --share-processes -- sh
            ''
          ];
        };
      };
    };
  };
}
