-- luacmdargs.tl
-- A simple library for extracting options, flags and positional args
-- * flags set a boolean or a count for a named arg
--           : -x
--           : -xv       "stacks" the flags, -xv == -x -v
--           : -vvv      returns the count
--           : --name
-- * options set a value for a named arg
--           : -x=value        (must be a single char after '-')
--           : --name=value    (one or more chars after '--')
-- * anything else is a positional argument

local record Args
   flags      : {string:boolean|integer}
   options    : {string:string}
   positional : {string}
end

local function parse_args(argv: {string}): Args
   local args: Args = {
      flags      = {},
      options    = {},
      positional = {}
   }

   local prefix = "luacmdsargs: parse_args:"

   if type(argv) ~= "table" then
     error(prefix.." need to pass an array of strings")
   end

   for i = 1, #argv do
      local a = argv[i]

      local eq = a:find("=", 2, true)              -- equal location
      local d  = a:sub(1,1) == "-"                 -- dash?
      local dd = a:sub(1,2) == "--"                -- double dash?

      if eq then                                   -- indicates an option 
        if dd then
          local name = a:sub(3, eq - 1)
          local value = a:sub(eq + 1)
          args.options[name] = value
        elseif d and eq == 3 then
          local name = a:sub(2, 2)
          local value = a:sub(4)
          args.options[name] = value
        else
          error(prefix.." malformed arg: "..a)
        end

      elseif dd then                               -- a "--" flag (since not an option)
        local name = a:sub(3)
        args.flags[name] = true

      elseif d then                                -- a "-" flag
        local name = a:sub(2)
        -- step through each letter
        for j = 1, #name do
           local f = name:sub(j,j)
           if args.flags[f] == nil then
              args.flags[f] = true
           elseif args.flags[f] == true then
              args.flags[f] = 2
           else
              args.flags[f] = args.flags[f] as integer + 1
           end
         end
      else                                         -- positional argument
         table.insert(args.positional, a)
      end  -- sorting this argument
   end  -- looping over array of argument strings

   return args
end

if arg[1] == "--demo" then
  -- Example usage
  local args = parse_args({ "-vvv", "-ll", "input1", "-zv", "--output=file.txt", "-i=data.in", "-q", "input2", "input3" })
  print("flags:")
  for k, v in pairs(args.flags) do
    print("  " .. k .. ": " .. tostring(v))
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
