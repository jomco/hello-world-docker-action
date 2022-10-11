#!/bin/sh -x

clojure -Ttools list | grep -q '^nvd ' ||
    clojure -Ttools install \
            nvd-clojure/nvd-clojure '{:mvn/version "RELEASE"}' :as nvd

clojure -J-Dorg.slf4j.simpleLogger.defaultLogLevel=error \
        -Tnvd nvd.task/check \
        :classpath "\"$(lein classpath)\"" \
        :config-filename "\".nvd-config.json\""
