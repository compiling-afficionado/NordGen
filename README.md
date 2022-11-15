# NordGen
This is a quick and dirty rewrite of the [NordVPN-IP-Tool](https://github.com/RackunSec/nordvpn-ip-tool) by RackunSec into Powershell.

## Purpose
This tool generates a CSV file of specific country's NordVPN servers in the format `hostname,ip` in script location. This is intended to be used for blocklists/detection logic. It does not depend on any external libraries and uses DNS requests made via `nslookup.exe`.

## Usage
```
.\nordgen.ps1 <country_code> <start_index> <end_index>
```
Where `<country_code>` is an [Alpha-2 country code](https://www.iban.com/country-codes) (e.g. `us`), `<start_index>` is the initial server number, and `<end_index>` is the last server number to scan for.

Example with variables which works fast at the time of writing:
```powershell
.\nordgen.ps1 dk 150 200
```
This will then create 2 files, the CSV file named according to country code used, e.g. `dk.csv`, and `Out-Null` (this is a garbage file which should be automatically removed in the future).

### Continuing queries
You can resume a query/run a query in batches if you'd like, as the script *appends* to the CSV file rather than overwrite. Example:
```powershell
.\nordgen.ps1 dk 0 100
.\nordgen.ps1 dk 101 200
```
This allows for checking the CSV file for output and/or continuing jobs. Remember to start `1` above the last range used to avoid duplicates.

## Suggestions
When searching for search ranges it's best to use [Nord's online Server tool](https://nordvpn.com/servers/tools/) to check for numbers of servers online and aim for a range larger by one order of magnitude. E.g. if there were 6 servers available in Denmark, it's good practice to search:
```powershell
.\nordgen.ps1 dk 0 100
```
**However** it's probably best to either settle for the minimum range of `0 1000` (as some countries only start at server number 500 or higher) or one order of magnitude higher than the "best server" returned by the [server tool](https://nordvpn.com/servers/tools/), as the lowest server number is not a given.
