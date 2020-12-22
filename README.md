
# unified-hosts-creator
Bash script to create unified host file from sources

<br>

## Configs :

- `LOCAL_HOST` : local server to which request is redirected, set to `0.0.0.0` or `127.0.0.1` (default is `0.0.0.0`)
- `OUTPUT_HOST` : output hosts-styled blocklist (default is `hosts.txt`)
- `source.list` : plain text file from which hosts-styled sources is to be fetch
- `source.domain` : plain text file from which only ip/domain sources is to be fetch

**NOTE -**
- `source.list` : should have only host-styled format sources, Ex- `0.0.0.0 www.example.com`
- `source.domain` : should have only ip/domain format sources, Ex- `www.example.com`

**To add local blocklist use `file://` URL**

- Add hosts sources/links in `source.list` and `source.domain`, remember above noted points.
- Add one source/link at each line
- If list has only one entry then add extra empty line at end *(some issue with curl)*
- Run `script.sh`

*(run script in empty folder to avoid issues)*
