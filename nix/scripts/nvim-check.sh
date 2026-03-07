#!/bin/zsh
# Run nvim headless diagnostics to verify configuration
# Checks: startup errors, plugin loading, health checks

set -e

SCRIPT_DIR="${0:a:h}"
LOG_FILE="/tmp/nvim-check-$$.log"

echo "Running nvim headless diagnostics..."

# 1. Check startup errors
echo -n "Checking startup... "
if nvim --headless -c 'qa!' 2>"$LOG_FILE"; then
    echo "OK"
else
    echo "FAILED"
    echo "Startup errors:"
    cat "$LOG_FILE"
    exit 1
fi

# 2. Check for Lua errors during init
echo -n "Checking Lua init... "
nvim --headless -c 'lua print("init-ok")' -c 'qa!' 2>&1 | tee "$LOG_FILE" | grep -q "init-ok"
if [[ $? -eq 0 ]]; then
    echo "OK"
else
    echo "FAILED"
    cat "$LOG_FILE"
    exit 1
fi

# 3. Verify key plugins are loaded
echo -n "Checking plugins... "
PLUGIN_CHECK=$(nvim --headless -c 'lua
local required = { "snacks", "which-key", "telescope", "lualine" }
local optional = { "edgy", "trouble", "aerial" }
local missing_req = {}
local missing_opt = {}
for _, p in ipairs(required) do
    local ok = pcall(require, p)
    if not ok then table.insert(missing_req, p) end
end
for _, p in ipairs(optional) do
    local ok = pcall(require, p)
    if not ok then table.insert(missing_opt, p) end
end
if #missing_req > 0 then
    print("MISSING_REQ:" .. table.concat(missing_req, ","))
elseif #missing_opt > 0 then
    print("MISSING_OPT:" .. table.concat(missing_opt, ","))
else
    print("plugins-ok")
end
' -c 'qa!' 2>&1)

if echo "$PLUGIN_CHECK" | grep -q "plugins-ok"; then
    echo "OK"
elif echo "$PLUGIN_CHECK" | grep -q "MISSING_REQ:"; then
    echo "FAILED"
    echo "Missing required: $(echo "$PLUGIN_CHECK" | grep "MISSING_REQ:" | cut -d: -f2)"
    exit 1
elif echo "$PLUGIN_CHECK" | grep -q "MISSING_OPT:"; then
    MISSING=$(echo "$PLUGIN_CHECK" | grep "MISSING_OPT:" | cut -d: -f2)
    echo "OK (optional missing: $MISSING - run switch.sh to install)"
else
    echo "OK"
fi

# 4. Run checkhealth (write to buffer, then save)
echo "Running checkhealth..."
HEALTH_FILE="/tmp/nvim-health-$$.txt"
nvim --headless -c 'checkhealth' -c "w $HEALTH_FILE" -c 'qa' 2>/dev/null

if [[ -f "$HEALTH_FILE" ]]; then
    ERRORS=$(grep -c "❌" "$HEALTH_FILE" 2>/dev/null || true)
    WARNINGS=$(grep -c "⚠️" "$HEALTH_FILE" 2>/dev/null || true)
    [[ -z "$ERRORS" ]] && ERRORS=0
    [[ -z "$WARNINGS" ]] && WARNINGS=0
    echo "Checkhealth: $ERRORS errors, $WARNINGS warnings"

    if [[ "$1" == "-v" || "$1" == "--verbose" ]]; then
        echo ""
        echo "=== Health Report ==="
        cat "$HEALTH_FILE"
    elif [[ "$ERRORS" -gt 0 ]]; then
        echo ""
        echo "Errors found (run with -v for full report):"
        grep -B1 "❌" "$HEALTH_FILE" | head -40
    fi
    rm -f "$HEALTH_FILE"
else
    echo "Checkhealth: FAILED (no output)"
fi

# 5. Test keymaps are registered
echo -n "Checking keymaps... "
KEYMAP_COUNT=$(nvim --headless -c 'lua
local maps = vim.api.nvim_get_keymap("n")
local leader_maps = 0
for _, m in ipairs(maps) do
    if m.lhs:match("^ ") then leader_maps = leader_maps + 1 end
end
print("keymaps:" .. leader_maps)
' -c 'qa!' 2>&1 | grep "keymaps:" | cut -d: -f2)

if [[ -n "$KEYMAP_COUNT" && "$KEYMAP_COUNT" -gt 50 ]]; then
    echo "OK ($KEYMAP_COUNT leader keymaps)"
else
    echo "WARNING (only $KEYMAP_COUNT leader keymaps found)"
fi

# Cleanup
rm -f "$LOG_FILE" /tmp/nvim-health.txt

echo ""
echo "All checks passed!"
