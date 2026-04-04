The Vy Renovate bot baseline
===

Contains a collection of baseline configurations
that other projects can extend with or without any custom overrides.

It is inspired by [trafficinfo-renovate](https://github.com/nsbno/trafficinfo-renovate).

# Usage

Create the file `renovate.json` in the root of your project, and paste in the following code:

```json5
// renovate.json
{
  "$schema": "https://docs.renovatebot.com/renovate-schema.json",
  "extends": [
    // 'default' is the "default", but we can create other alternatives based on preference and requests
    "github>nsbno/vy-renovate-baseline:default",
  ]
}
```

This should be sufficient for most teams, without any need for reconfiguration

## Where does Renovate run?

It is an app installed in Github, and running through mend.io's
servers. The URL is https://developer.mend.io/github/nsbno. 
