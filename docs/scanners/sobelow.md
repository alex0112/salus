# [Sobelow](https://github.com/nccgroup/sobelow)

Perform static code analysis against Phoenix repositories and detect potentially vulnerable code patterns.

## Ignoring a Finding
Refer to the [false positives](https://github.com/nccgroup/sobelow#false-positives) section in the Sobelow documentation.

Additional configuration will be supported in the future. Currently the command run by the scan here is `mix sobelow --skip --threshhold low --exit low`. Which will report all findings as failures unless they are ignored via a `sobelow_skip` comment.
