# Contributing

Contributions are welcome! Here's how you can help:

- [Contributing code](#code)
- [Reporting issues](#issues)
- [Requesting features](#feature-requests)

## Code

If you are planning to start some significant coding, you would benefit from asking first on [our Discord server](https://discord.gg/Uywr9kc) before starting.

1. [Fork](https://help.github.com/articles/fork-a-repo/) the repository and [clone](https://help.github.com/articles/cloning-a-repository/) your fork.

2. Start coding!
    - Refer to the [Lua API](https://github.com/minetest/minetest/blob/master/doc/lua_api.txt).
    - Follow the [Code Style Guidelines](#code-style).
    - Check your code works as expected and document any API changes to the Lua API.

3. Commit & [push](https://help.github.com/articles/pushing-to-a-remote/) your changes to a new branch (not `master`, one change per branch)
    - Commit messages should:
        - Use the present tense
        - Have a title which begins with a capital letter
        - Be descriptive. (e.g. no `Update init.lua` or `Fix a problem`)
        - Have a first line with less than *80 characters*

4. Once you are happy with your changes, submit a pull request.
     - Open the [pull-request form](https://github.com/MineWitherMC/trinium/pull/new/master)
     - Add a short description explaining briefly what you've done (or if it's a work-in-progress - what you need to do)

##### A pull-request is considered merge-able when:

0. It works.
1. It follows the [Code Style](#code-style).
2. The code's interfaces are well designed, regardless of other aspects that might need more work in the future.
3. It fits the picture of the project.

## Issues

If you experience an issue, we would like to know the details - especially when a stable release is on the way.

1. Do a quick search on GitHub to check if the issue has already been reported.
2. [Open an issue](https://github.com/MineWitherMC/trinium/issues/new) and describe the issue you are having - you could include:
     - Error logs (check the bottom of the `debug.txt` file)
     - Screenshots
     - Ways you have tried to solve the issue, and whether they worked or not
     - Your Minetest version (if it's developer one, include commit (e.g., `0.5.0-dev-2c490ddd`) and Trinium version (again, use commit ID).

After reporting you should aim to answer questions or clarifications as this helps pinpoint the cause of the issue (if you don't do this your issue may be closed after 1 month).

## Feature requests

Feature requests are welcome but take a moment to see if your idea fits the whole picture of the project. You should provide a clear explanation with as much detail as possible.

## Code Style

Note that these are only *guidelines* for more readable code. In some (rare) cases they may result in *less* readable code. Use your best judgement. 

This is largely based on [Minetest Lua Code Style Guidelines](http://dev.minetest.net/Lua_code_style_guidelines).

### Comments

- Don't use too much comments (like [this](https://github.com/MightyAlex200/WiTT/blob/master/init.lua)), the request will be probably rejected.
- Don't comment obvious/trivial things, confusing/non-trivial might be useful.

Example (from research inventory):
```lua
--[[
	define line (x1,y1) => (x2,y2) as y = kx + b
	then, kx1 + b = y1 and kx2 + b = y2
	k(x2-x1) = (y2-y1)
	k = (y2-y1)/(x2-x1)
	b = y1 - kx1 = (x2y1 - x1y2)/(x2-x1)
]]--
```
This is good, while this...
```lua
--[[
	calculate k as (y2 - y1)/(x2 - x1) and b as (x2y1 - x1y2) / (x2 - x1)
]]--
```
...is bad

- Comments should have a space between comment characters and first word. If the comment is inline, it should also have space between comment characters and code.
Example:
```lua
foo() -- A proper comment
```

### Lines. Spaces. Indentation

- Indentation is done using **one tab** per level. Space-indented code will be immediately rejected.
- Lines are wrapped at 120 lines, 105 where possible. Hard limit is 130.
- Breaks around a binary operator should be after it.
Example (from sheet enlightener):
```lua
((index == 1 and name == "trinium:material_dust_stardust") or
(index == 2 and name == "trinium:material_dust_pyrocatalyst") or 
(index == 3 and name == "trinium:material_dust_bifrost") or
(index == 4 and name == "trinium:material_dust_experience_catalyst") or 
(index == 5 and name == "trinium:material_dust_imbued_forcirium") or
(index == 6 and name == "trinium:material_dust_endium"))
```
- Use a single empty line to separate sections of long functions, long tables (e.g, multiblock maps), top-level functions and tables. Don't use them anywhere else.
- Don't use spaces around parenthesis, brackets or braces or before semicolons.
- Spaces are used around ariphmetic operators and aren't used around other operators.

### Misc
- Functions and variables should be named in lowercase_underscore_style. Constructors can also be UpperCamelCase.
- Don't use multiple statements on the same line, unless it's needed.
Example:
```lua
if x1 < -0.5 then x1 = -0.5; y1 = -0.5 * k + b end -- Here it's OK (because splitting it on 4 lines isn't).
if not recipe_selected then
	meta:set_int("active", 0)
	meta:set_string("output", "")
	trinium.recolor_facedir(status, 2)
	T(timer)
	return
end -- But here it wouldn't be
```

### Some notes by me
- When function uses a single argument that is either a constant string or table written with table syntax, don't use parenthesis around it.
Example:
```lua
local x = S"thing.foo" -- Good
local y = S("thing.bar @1", S"thing.baz") -- Good
local z = S("thing.quux") -- Bad
```