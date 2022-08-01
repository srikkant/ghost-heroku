#!/bin/bash
#set -e

read -r -d '' js_script <<'EOF'
var URL = require('url').URL;

var url = new URL(arg);

console.log(`database__client=${url.protocol.slice(0, -1)}`);
console.log(`database__connection__database=${url.pathname.substring(1)}`);
console.log(`database__connection__host=${url.host}`);
console.log(`database__connection__password=${url.password}`);
console.log(`database__connection__user=${url.username}`);
EOF

export $(node -e "var arg = '$(printenv $DB_URL_ALIAS)';$js_script" | xargs)
export server__host='0.0.0.0'
export server__port=$PORT

exec docker-entrypoint.sh "$@"
