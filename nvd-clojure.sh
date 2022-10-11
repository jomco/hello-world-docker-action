#!/bin/sh -e

clojure -Ttools list | grep -q '^nvd ' ||
    clojure -J-Dclojure.main.report=stderr \
            -Ttools install \
            nvd-clojure/nvd-clojure '{:mvn/version "RELEASE"}' :as nvd

ARGS=''
[ -f .nvd-config.json ] && ARGS=':config-filename ".nvd-config.json"'

clojure -J-Dclojure.main.report=stderr \
        -J-Dorg.slf4j.simpleLogger.defaultLogLevel=error \
        -Tnvd nvd.task/check \
        :classpath "\"$(lein classpath)\"" \
        $ARGS
