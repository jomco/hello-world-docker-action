#!/bin/sh -e

clojure -Ttools list | grep -q '^nvd ' ||
    clojure -J-Dclojure.main.report=stderr \
            -Ttools install \
            nvd-clojure/nvd-clojure '{:mvn/version "RELEASE"}' :as nvd

ARGS=''
[ -f .nvd-config.json ] && ARGS=':config-filename ".nvd-config.json"'

if [ -n "$1" ]; then
    CP="$1"
else
    CP="$(lein with-profile provided classpath)"
fi

clojure -J-Dclojure.main.report=stderr \
        -J-Dorg.slf4j.simpleLogger.defaultLogLevel=error \
        -Tnvd nvd.task/check \
        :classpath "\"$CP\"" \
        $ARGS
