local _tl_compat; if (tonumber((_VERSION or ''):match('[%d.]*$')) or 0) < 5.3 then local p, m = pcall(require, 'compat53.module'); if p then _tl_compat = m end end; local ipairs = _tl_compat and _tl_compat.ipairs or ipairs; local pairs = _tl_compat and _tl_compat.pairs or pairs; local string = _tl_compat and _tl_compat.string or string; local table = _tl_compat and _tl_compat.table or table















local function parse_args(argv)
   local args = {
      flags = {},
      options = {},
      positional = {},
   }

   local prefix = "luacmdsargs: parse_args:"

   if type(argv) ~= "table" then
      error(prefix .. " need to pass an array of strings")
   end

   for i = 1, #argv do
      local a = argv[i]

      local eq = a:find("=", 2, true)
      local d = a:sub(1, 1) == "-"
      local dd = a:sub(1, 2) == "--"

      if eq then
         if a:sub(1, 2) == "--" then
            local name = a:sub(3, eq - 1)
            local value = a:sub(eq + 1)
            args.options[name] = value
         elseif a:sub(1, 1) == "-" and eq == 3 then
            local name = a:sub(2, 2)
            local value = a:sub(4)
            args.options[name] = value
         else
            error(prefix .. " malformed arg: " .. a)
         end

      elseif dd then
         local name = a:sub(3)
         args.flags[name] = true

      elseif d then
         local name = a:sub(2)
         args.flags[name] = true

      else
         table.insert(args.positional, a)
      end
   end

   return args
end

if arg[1] == "--demo" then

   local args = parse_args({ "--verbose", "input1", "--output=file.txt", "-i=data.in", "-q", "input2", "input3" })
   print("flags:")
   for k, _ in pairs(args.flags) do
      print("  " .. k)
   end
   print("options:")
   for k, v in pairs(args.options) do
      print("  " .. k .. "=" .. v)
   end
   print("positional:")
   for _, p in ipairs(args.positional) do
      print("  " .. p)
   end
end

return {
   parse_args = parse_args,
}
