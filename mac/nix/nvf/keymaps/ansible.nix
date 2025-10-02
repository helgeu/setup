# Ansible Language Support Keymaps
# Part of lazyvim.plugins.extras.lang.ansible
[
  # nvim-ansible keymaps
  {
    key = "<leader>ta";
    action = "<cmd>lua require('ansible').run()<cr>";
    mode = ["n"];
    desc = "Ansible Run Playbook/Role";
  }
]