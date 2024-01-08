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
      uses: actions/checkout@v2

    - name: NVD clojure
      uses: jomco/nvd-clojure-action@v0
```

Note: the committer who touched the workflow last receives notifications when the workflow fails.

You can [obtain an API
key](https://nvd.nist.gov/developers/request-an-api-key) in a few
minutes - it's an automated process.

## Attribution

This product uses the NVD API but is not endorsed or certified by the
NVD.
