# NVD Clojure Github Action

Very basic GH action to run [nvd-clojure](https://github.com/rm-hull/nvd-clojure) on a codebase.  This action expects a leiningen managed project at the root of the repository this action will be invoked on.

This action depends on [DeLaGuardo/setup-clojure](https://github.com/DeLaGuardo/setup-clojure) to install Clojure CLI and expects leiningen to be available.  The action fails when nvd-clojure finds an issue.

## Usage

Here's an example workflow to run nvd-clojure every Monday morning:

```yaml
name: Check deps for vulnerabilities

on:
  schedule:
    - cron: '0 0 * * 1'

jobs:
  deps:
    runs-on: ubuntu-latest

    env:
      NVD_API_TOKEN: ${{ secrets.NVD_API_TOKEN }}

    steps:

    - name: Checkout code
      uses: actions/checkout@v4

    - name: NVD clojure
      uses: jomco/nvd-clojure-action@v4
```

Note: the committer who touched the workflow last receives notifications when the workflow fails.

You can [obtain an API
key](https://nvd.nist.gov/developers/request-an-api-key) in a few
minutes - it's an automated process.

There seems to be an issue with nvd-clojure preventing the token to be loaded from the environment when no configuration file is provided.  This action automatically picks up a configuration file named `.nvd-config.json`, please use the following:

```json
{"nvd": {"suppression-file": ".nvd-suppressions.xml"}}
```

and provide the accompanying suppressions file named `.nvd-suppressions.xml` as your start points:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<suppressions xmlns="https://jeremylong.github.io/DependencyCheck/dependency-suppression.1.3.xsd">
</suppressions>
```

## Attribution

This product uses the NVD API but is not endorsed or certified by the
NVD.
