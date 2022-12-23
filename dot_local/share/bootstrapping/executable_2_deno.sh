source "$(dirname $0)/_utility.sh"
exit_if_installed deno

set -e

curl -fsSL https://deno.land/x/install/install.sh | sh


# install plugos-bundle
export PATH="$HOME/.deno/bin:$PATH"
deno install -f -A --unstable --importmap https://deno.land/x/silverbullet/import_map.json https://deno.land/x/silverbullet/plugos/bin/plugos-bundle.ts

# install silverbullet
deno install -f --name silverbullet -A --unstable https://get.silverbullet.md