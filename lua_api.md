Trinium API
===========

The Minetest Lua API, sfinv and cmsg functions are not listed here.

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
* `table.map(tbl, func(value, key))`
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
	trinium.weighted_avg({{5, 2}, {8, 1}}) => 6
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
* `trinium.weighted_random(mas, func)` - func is `math.random` by default

String helpers
--------------
* `trinium.adequate_text(str)`
	Returns string capitalized as it was a sentence.
* `trinium.adequate_text2(str)`
	The same but all underscores are also replaced by spaces.
* `trinium.formspec_restore(str)`
	Reverse of `minetest.formspec_escape`.
* `trinium.get_item_identifier(stack)`
	Stack is of type ItemStack. Similar to `stack:to_string()`, but also cuts
	item amount.
* `trinium.roman_number(num)`
	
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
* `trinium.try_craft(player)` - sets output for player's detached workbench
* `trinium.absolute_draw_recipe(table, num)` - draws `num`th recipe from `table`
	Returns `formspec_str`, `width`, `height`, `amount_of_recipes`, `current_id`
* `trinium.draw_recipe(item, player, id, tbl, method)`
	Draws recipe available to player. Returns the same as function above.
	`tbl` is usually `trinium.recipes.recipes` or `trinium.recipes.usages`.
	`method` can be abscent.
* `trinium.draw_research_recipe(item, num)` - draws recipe for research book

Material API
------------
* `trinium.materials.register_mattype(name, callable(def))`
	Registers a material type. `callable` should register the needed items.
	`def` is a table with following fields:
	* `id`
	* `name` - the material description
	* `color` - color formatted as `'#RRGGBBAA'` (hex string)
	* `color_tbl` - color formatted as `{R, G, B}` (R, G, B are numbers)
	* `formula` - line wrap followed by formula string colored to gray
	* `formula_tbl` - formula formatted as `{{'compound1', count1}, ...}`
	* `data`
	* `types` - list of types material has. No need to check this most time.
* `trinium.materials.register_interaction(name, def)`
	Register an interaction between material types, can be used for e.g.
	setting up recipes.
	`def` is a table with following fields:
	* `requirements` - list of material types
	* `apply(name, data)` - function which is fired when all requirements are
	satisfied. `name` is material id and `data` is its data
* `trinium.materials.new_material(name, def)` - registers material
	`def` is a table with following fields:
	* `formula` - formula formatted as `{{'compound1', count1}, ...}`
	* `types` - list of material types
	* `color` - color formatted as `{R, G, B}` (R, G, B are numbers)
		* If abscent, automatically generates from compounds' colors
	* `description`
	* `data` - optional material data
	Returns object with following methods:
	* `generate_data(id)` - generates data (see `mat.add_data_generator`)
	* `generate_recipe(id)` - generates recipes (see `mat.add_recipe_generator`)
	* `get(id)` - shortcut for writing `"trinium:materials_"..id.."_"..name`
	All methods return object so they can be chained
* `trinium.materials.register_element(name, def)` - registers elementary material
	`def` is a table with following fields:
	* `formula` - string like `"Si"`, `"H"` (not `"H2"`) or `"Nq"`
	* `color` - color formatted as `{R, G, B}` (R, G, B are numbers)
	* Other data fields include:
		* `melting_point` - melting point in Kelvins, -1 where not applicable
* `trinium.materials.add_data_generator(name, callback(material_name))`
	When `object:generate_data(name)` is called on material object, 
	generates `name` data field using `callback` return value
* `trinium.materials.add_recipe_generator(name, callback(material_name))`
	Same as above, except that callback returns nothing and `name` can not be
	recipe method ID
	
Research System
---------------
* `trinium.research.register_chapter(name, def)`
	Registers research chapter. `def` is a table with following fields:
	* `texture` - itemstring
	* `x` - horizontal coordinate, from 0 to 7
	* `y` - vertical coordinate, from 0 to 7
	* `name`
	* `tier` - integer from 1 to 4
	* `create_map` - optional, if present creates a map to use in Enlightener
* `trinium.research.register_research(name, def)`
	Registers research. `def` is a table with following fields:
	* `pre_unlock` - either `true` or not present/`false`. If true research is
		unlocked from beginning.
	* `texture` - itemstring
	* `x` - horizontal coordinate, from 0 to 7
	* `y` - vertical coordinate, any integer
	* `name`
	* `text`
	* Following fields are required when `pre_unlock` is `false` or not present:
		* `color` - either `{R, G, B}` or `'#RRGGBB'`
		* `map` - table of objects with following keys:
			* `x` and `y` - coordinates of the aspect from 1 to 7
			* `aspect`
		* `requires_lens` - table with following keys:
			* `requirement` - if lens is required, false by default
			* `core` - if lens is required, this shows its core material
			* `band_material` - same with band material
			* `core` and `band_material` can be abscent, in that case any
				material can be used
			* `band_tier` - minimal lens tier, 1 by default
			* `band_shape` - needed lens shape, any shape can be used by default
* `trinium.research.grant(pn, name)` - gives player research if all requirements
	are satisfied
* `trinium.research.grant_force(pn, name)` - gives player research and all its
	requirements
* `trinium.research.register_aspect(name, def)`
	Registers an aspect. `def` is a table with following fields:
	* `texture` - not an itemstring, but a texture!
	* `name`
	* `req1` - one of the requirements, aspect is basic if this is not present
	* `req2` - same as above
	
Tool System
-----------
* `trinium.tool_system.register_tool_material(name, def)`
	Registers a tool head material. `def` is a table with following fields:
	* `name`
	* `durability` - note that durability decrease is calculated as 1/(d * 3^l)
	* `level`
	* `time_mult` - material speed, tools made from stone and sticks only have
		`time_mult` value of 10, speed scales linearly with this
	`name` is an itemstring.
* `trinium.tool_system.register_tool_rod(name, def)`
	Similar to the method above, except for following:
	* This item can be used as a tool rod, not a tool head material
	* Final item properties are calculated as material_stats * rod_stats
* `trinium.tool_system.register_template(name, def)`
	Registers a tool template.
	`name` is a alphanumeric string. Item texture is `tool_<name>.png`.
	`def` is a table with following fields:
	* `name(inputs)` - `inputs` is some list of given materials
	* `schematic` - string describing tool scheme:
		* This is a string which has spaces inside it, 1 word = 1 crafting line.
		* All non-space symbols can be either `_`, `R` or `M`.
		* `_` means that no item should be put there.
		* `R` is for Rod and `M` is for Material.
	* `apply(stack, capabilities)` - function which sets tool capabilities
		`stack` is a ItemStack.
		`capabilities` is a table with following fields:
		* `time_mult`
		* `durability`
		* `level`

Other
-----
* `trinium.S(string, ...)` - a general translator
* `trinium.dump(...)` - logs all inputs, which can be tables but without Userdata
* `trinium.modulate(num, mod)` 
	This function is close to `num % mod`, with the only difference being this
	function returning `mod` when `num` is fully divisible by `mod`.
* `trinium.setting_get(name, default)`
* `trinium.lograndom(min, max)` 
	Should return normal-distributed number between min and max, both sides
	included. Not well tested though.
* `trinium.get_data_pointer(player_name, file)` - per-world per-player storage
* `trinium.register_fluid(source_name, flowing_name, source_desc, flowing_desc,
		color, def)`
	Registers a fluid.
	`source_name` and `flowing_name` are IDs of source and flowing variants;
	`source_desc` and `flowing_desc` are their descriptions;
	`def` can have any of the fields `minetest.register_node` can get,
	however some of them will be overridden.
* `trinium.register_vein(name, params)`
	Registers an ore vein. `name` is an ID which is not used for now, `params` is
	a table with following fields:
	* `ore_list` - list of nodenames to generate
	* `ore_chances` - list of relative chances of the nodes
	* `density` - percentage to change a stone node to ore
	* `weight` - relative weight of node. Generally 1-3 for very rare,
		10 for rare, 50 for common, 100 for very common
	* `min_height`
	* `max_height`
* `trinium.pulsenet.import_to_controller(pos)` - puts controller internal item 
	to network.
* `trinium.advanced_search(begin, serialize(item), vertex(current_item))`
	Performs BFS on graph whose vertices connected to vertice A are in list
	`vertex(A)`.
	`serialize` is a function that returns item in string/etc form.
	Returns list of `{element, step}`, where `step >= 2` - distance from begin.
	Beginning element is not in the list.
* `trinium.search(begin, serialize(item), vertex(item))`
	Same as previous function, but returns list of `element` instead of pairs.

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
	Can also return -1 to stop recipe registration.
* `process_outputs(outputs)` - can also return -1
* `process_data(data)` - can also return -1
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
	Region is a table of objects with following keys:
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

### DataMesh
DataMesh is a table that can have chained methods.
The possible methods are:
* `new()`
* `data()` - gets data
* `data(smth)` - sets data
* `filter(func(v, k))`
* `map(func(v, k))`
* `forEach(func(v, k))`
* `exists(func(v, k))`
* `serialize()`
* `copy()`
* `push(element)`