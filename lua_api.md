Trinium API
===========

Table helpers
-------------
* `table.copy(tbl)`
	Copies table, needed for editing it. The table cannot store userdata, e.g.
	ItemStacks or NodeMetaRefs.
* `table.count(tbl)`
* `table.filter(tbl, func(value, key))`
	Returns table with fields that return true when func is called with them.
	Fields keys are unchanged, as is the given table.
	`func` is called with value as a first argument and key as the second.
	Has the same restrictions as `table.copy`.
* `table.exists(tbl, func(value, key))`
	Returns true if table has a field that returns true when func is called.
	Table iteration is stopped when such element is found.
* `table.every(tbl, func(value, key))`
	Returns true if all table fields return true when func is called.
	Table iteration is stopped when element returning false is found.
* `table.walk(tbl, func(value, key), condition())`
	Runs func on all table elements. If condition returns true, iteration stops.
	Condition argument is optional.
* `table.map(tbl, func(value, key))
	Replaces each element of table with function result and returns resulting
	table. Given table is unchanged.
	Has the same restrictions as `table.copy`.
* `table.remap(tbl)`
	If tbl is a table with integer keys, some of which are shifted, this function
	returns a list with same values. Given table is unchanged.
	All non-integer keys are ignored.
* `table.keys(tbl)`
	Returns list of keys of table. Given one is unchanged.
* `table.asort(tbl, func(a, b))`
	Returns iterator going through all table elements in order their values are
	sorted with func. Useful with associative tables.
	If func is not given, sorts a table normally.
* `table.sum(tbl)`
* `table.tail(tbl)`
	Returns table with first element stripped. Given table is unchanged.
* `table.mtail(tbl, multiplier)`
	Returns table with first `multiplier` elements stripped.
* `trinium.sort_by_param(x)`
	Returns sorting function comparing elements' fields with key `x`.
* `trinium.weighted_avg(table)`
	Table is composed like this: {{a1, b1}, {a2, b2}, ...}
	Then, this function returns weighted average of `a_i` where weights are `b_i`.
	Example:
	trinium.weighted_avg({{5, 2}, {8, 1}}) => 7
* `vector.stringify(vec)`
	Returns `x,y,z` string which can be used in nodemeta ans as more compact
	storage of coordinates.
* `vector.destringify(str)`
	Reverse of previous one.
* `trinium.recipe_stringify(arr)`
	Stringifies recipe. The same format is used in recipes' inputs_string field.
	Can be used if item order matters.
* `trinium.initialize_inventory(inv, arr)`
	Initializes inventory: for all (K,V) pairs from arr inventory list K size is
	set to V.

String helpers
--------------
* `trinium.adequate_text(str)`
	Returns string capitalized as it was a sentence.
* `trinium.adequate_text2(str)`
	The same but all underscores are also replaced by spaces.
* `trinium.formspec_restore(str)`
	Reverse of `minetest.formspec_escape`.
* `trinium.get_item_identifier(stack)`
	Stack is of type ItemStack. Similar to stack:to_string(), but also cuts
	item amount.
	
Recipes, Multiblocks, etc
-------------------------
* `trinium.register_recipe(type, inputs, outputs, data)`
* `trinium.register_recipe_handler(id, def)`
	Registers new recipe method (see Recipe Methods).
* `trinium.can_perform(player_knowledge_crystal, id, method)`
	Basically a wrapper to method's `can_perform`.
	`id` is obtained from recipe registry.
* `trinium.valid_recipe(pattern, method, data)`
	Checks whether the recipe with given pattern exists.
	Returns its ID on success and false on failure.
* `trinium.has_inputs_for_recipe(pattern, inv, list)`
	Checks whether all items needed for recipe are in the given inventory list.
* `trinium.draw_inputs_for_recipe(pattern, inv, list, id)`
	Takes inputs from given inventory list and returns
	output list concatenated by semicolon.
* `trinium.register_multiblock(id, def)`
	Registers new multiblock (see Multiblocks).
* `trinium.mbcr(node_id, multiblock_map)`
	Changes node_id description to have multiblock components there.
* `trinium.recolor_facedir(pos, n)`
* `trinium.get_color_facedir(pos)`

Other
-----
* `trinium.dump(...)` - logs all inputs, which can be tables but without Userdata
* `trinium.modulate(num, mod)` 
	This function is close to `num % mod`, with the only difference being this
	function returning `mod` when `num` is fully divisible by `mod`.
* `trinium.setting_get(name, default)`
* `trinium.lograndom(min, max)` 
	Should return normal-distributed number between min and max, both sides
	included. Not well tested though.
* `trinium.get_data_pointer(player_name, file) - per-world per-player storage
* `trinium.register_fluid(source_name, flowing_name, source_desc, flowing_desc,
		color, def)`
	Registers a fluid.
	`source_name` and `flowing_name` are IDs of source and flowing variants;
	`source_desc` and `flowing_desc` are their descriptions;
	`def` can have any of the fields `minetest.register_node` can get,
	however some of them will be overridden.
	
### Recipe Method
Recipe Method is a table with following keys:
* `input_amount`
* `output_amount`
* `get_input_coords(n)` - should return coords of nth input.
* `get_output_coords(n)`
* `formspec_width`
* `formspec_height`
* `formspec_name`
* `formspec_begin(data)` 
	Can be used to set background/show data/etc.
	Should return string, returns empty one by default.
* `can_perform(player_name, data)`
	Returns true if player can perform the recipe. Always is true if abscent.
	Usually used for checking player's research.
* `test(recipe_data, actual_data)`
	Returns true if non-input requirements - pressure, temperature, catalyst,
	time of day, phase of moon, etc. - are satisfied.
* `callback(inputs, outputs, data)`
	With this key, the recipe can be redirected to other method.
	Should return string if method changes and any other value in the other case.
* `process_inputs(inputs)` - used by wizards, returns actual inputs table.
* `process_outputs(outputs)`
* `process_data(data)`
* `recipe_correct(data)` - called during init phase

### Multiblock
Multiblock Definition is a table with following keys:
* `controller`
* `map`
	A table with values with `x`, `y`, `z`, and `name` fields.
	`x` is offset to the right, `y` is to the top, and `z` is to the back.
	`name` is needed name of the node. These can be any nodes except air/ignore.
	The multiblock will be tested having these nodes around if field is present.
	Also multiblock recipes will be generated in this case.
* `activator(region)` 
	Called in case `map` isn't present.
	Region is a table with following keys:
	* `x` - offset relative to controller
	* `y`
	* `z`
	* `name`
	* `actual_pos`
* `height_d` - bottom offset to check
* `height_u` - top offset to check
* `width` - this is both to the right and left
* `depth_b` - backwards offset
* `depth_f` - front offset
* `after_construct(pos, is_constructed, region)`
	This function is called when multiblock checking tick is done.
	`is_constructed` is a boolean which is true if map is checked.
	`region` format is the same as with activator.