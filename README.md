app-airfield Cookbook
=====================
Installs and configures airfield web manager for the hipache traffic director.


Requirements
------------
#### packages
-  git
-  nodejs

Attributes
----------
See attributes/default.rb.


Usage
-----
#### app-airfield::default

e.g.
Just include `app-airfield` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[app-airfield]"
  ]
}
```

Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Deathowl
