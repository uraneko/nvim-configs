local turaco_mod = modifiers.turaco_mod

map('n', turaco_mod .. '<cr>', function()
	Turaco.Shuffle(Turaco.Stack)
end, arg)
map('n', turaco_mod .. '<bs>', function()
	Turaco.Default()
end, arg)
map('n', turaco_mod .. '\\', ':lua Turaco.Print(Turaco.Stack)<cr>', arg)
map('n', turaco_mod .. '<Space>', ':lua Turaco.Stack = Turaco.Load()<cr>', arg)
