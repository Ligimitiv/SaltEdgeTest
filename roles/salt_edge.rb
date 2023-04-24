name "salt_edge"
description "Test task by SaltEdge"
run_list    "recipe[salt_edge::ruby]",
            "recipe[salt_edge::mongo]",
            "recipe[salt_edge::errbit]",
            "recipe[salt_edge::tests]"