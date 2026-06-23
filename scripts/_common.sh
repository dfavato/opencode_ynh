#!/bin/bash

# Get the app system user's home directory
get_app_home() {
    getent passwd "$app" | cut -d: -f6
}

# Path to opencode auth.json (standard location for the app user)
get_auth_file() {
    echo "$(get_app_home)/.local/share/opencode/auth.json"
}

# Write provider API keys to auth.json from YunoHost settings
write_auth_json() {
    local auth_file="$(get_auth_file)"
    local auth_dir="$(dirname "$auth_file")"
    mkdir -p "$auth_dir"

    python3 - "$app" "$auth_file" <<'PYEOF'
import json, os, subprocess, sys

app = sys.argv[1]
auth_file = sys.argv[2]

FIELD_TO_PROVIDER = {
    "opencode": "opencode",
    "opencode_go": "opencode-go",
    "openai": "openai",
    "anthropic": "anthropic",
    "deepseek": "deepseek",
    "openrouter": "openrouter",
    "groq": "groq",
    "togetherai": "togetherai",
    "xai": "xai",
    "huggingface": "huggingface",
    "cerebras": "cerebras",
    "deepinfra": "deepinfra",
    "fireworks_ai": "fireworks-ai",
    "three02_ai": "302ai",
    "baseten": "baseten",
    "cortecs": "cortecs",
    "frogbot": "frogbot",
    "io_net": "io-net",
    "minimax": "minimax",
    "moonshotai": "moonshotai",
    "nebius": "nebius",
    "nvidia": "nvidia",
    "venice": "venice",
    "zai": "zai",
    "zenmux": "zenmux",
    "llmgateway": "llmgateway",
    "helicone": "helicone",
}

result = subprocess.run(['ynh_app_setting_list_keys', app], capture_output=True, text=True)
auth = {}
for key in result.stdout.strip().split('\n'):
    key = key.strip()
    if not key:
        continue
    field_name = key.rsplit('.', 1)[-1] if '.' in key else key
    provider_id = FIELD_TO_PROVIDER.get(field_name)
    if provider_id:
        value = subprocess.run(['ynh_app_setting_get', app, key], capture_output=True, text=True)
        api_key = value.stdout.strip()
        if api_key:
            auth[provider_id] = {"type": "api", "key": api_key}

with open(auth_file, 'w') as f:
    json.dump(auth, f, indent=2)
os.chmod(auth_file, 0o600)
PYEOF

    chown "$app:$app" "$auth_file"
    chmod 600 "$auth_file"
}
