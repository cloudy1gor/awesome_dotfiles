-- Help
local HELP_TEXT = [[
usage: lunaco.lua [-h]

Lua script for a small conky calendar

options:
  -h, --help                show this help message and exit

  --align-body=<value>      set alignment of whole calendar
                            (default: c; options: c, l, r)
  --align-header=<value>    set alignment of calendar header
                            (default: c; options: c, l, r)
                            note: this is the only option
                            still active in combination with
                            the --no-format flag
  --color=<color>           set main text color (hex, omit #)
  --font-family=<font>      set font family (default:
                            Monospace)
  --header-color=<color>    color for header text (hex, omit
                            #)
  --hide-dow                hide days of week in the header
  --hide-month              hide the month in the header
  --hide-year               hide the year in the header
  --no-format               do not include any formatting
                            options
  --size=<num>              set font size (default: 11)
  --today-bold              set today's date in bold text
  --today-color=<color>     color for today's date (hex, omit
                            #)
  --weekend-color=<color>   color for weekend days (hex, omit
                            #)
]]

-- Options
local OPTIONS = {
  ["--align-body"] = "c",
  ["--align-header"] = "c",
  ["--color"] = "",
  ["--font-family"] = "Monospace",
  ["--header-color"] = "",
  ["--hide-dow"] = false,
  ["--hide-month"] = false,
  ["--hide-year"] = false,
  ["--no-format"] = false,
  ["--size"] = 11,
  ["--today-bold"] = false,
  ["--today-color"] = "",
  ["--weekend-color"] = ""
}

local function addOrderedTableEntry(tbl, key, value)
  -- Add entry to a table while preserving
  -- the order. The table will then be printed
  -- in the expected sequence.
  table.insert(tbl, key)
  local index = tbl[#tbl]
  tbl[index] = value
end

local function generateFontTag()
  -- generate font tag
  if not OPTIONS['--no-format'] then
    return "${font " .. OPTIONS['--font-family']
      .. ":size=" .. OPTIONS['--size'] .. "}"
  end
  return ""
end

local function generateColorTag(key)
  -- generate color tag
  local key = key or "--color"
  local targetColor = OPTIONS[key]
  if targetColor:len() > 0 and not OPTIONS['--no-format'] then
    return "${color #" .. targetColor .. "}"
  end
  return ""
end

local function generateAlignTag()
  if not OPTIONS['--no-format'] then
    if OPTIONS['--align-body'] == "l" then
      return ""
    else
      return "$align" .. OPTIONS['--align-body']
    end
  end
  return ""
end

local function getYear()
  -- Return full year as a number
  return tonumber(os.date("%Y"))
end

local function getToday()
  -- Return day as a number
  return tonumber(os.date("%d"))
end

local function dayToString(dayNum)
  local day = tostring(dayNum)
  if day:len() == 1 then return "0" .. day end
  return day
end

local function allMonths()
  -- Return table of all months with
  -- full names
  local monthAlphaTbl = {}
  addOrderedTableEntry(monthAlphaTbl, 1, "January")
  addOrderedTableEntry(monthAlphaTbl, 2, "February")
  addOrderedTableEntry(monthAlphaTbl, 3, "March")
  addOrderedTableEntry(monthAlphaTbl, 4, "April")
  addOrderedTableEntry(monthAlphaTbl, 5, "May")
  addOrderedTableEntry(monthAlphaTbl, 6, "June")
  addOrderedTableEntry(monthAlphaTbl, 7, "July")
  addOrderedTableEntry(monthAlphaTbl, 8, "August")
  addOrderedTableEntry(monthAlphaTbl, 9, "September")
  addOrderedTableEntry(monthAlphaTbl,10, "October")
  addOrderedTableEntry(monthAlphaTbl,11, "November")
  addOrderedTableEntry(monthAlphaTbl,12, "December")
  return monthAlphaTbl
end

local function getMonth(alpha)
  -- false is default for alpha param
  local alpha = alpha or false

  if (not alpha) then
    -- return number version if no alpha
    return tonumber(os.date("%m"))
  end

  -- return full name of month
  local months = allMonths()
  return months[tonumber(os.date("%m"))]
end

local function getWeekday(target)
  -- target defaults to false
  local target = target or false
  
  local weekDayTbl = {}
  addOrderedTableEntry(weekDayTbl, 1, "Sunday")
  addOrderedTableEntry(weekDayTbl, 2, "Monday")
  addOrderedTableEntry(weekDayTbl, 3, "Tuesday")
  addOrderedTableEntry(weekDayTbl, 4, "Wednesday")
  addOrderedTableEntry(weekDayTbl, 5, "Thursday")
  addOrderedTableEntry(weekDayTbl, 6, "Friday")
  addOrderedTableEntry(weekDayTbl, 7, "Saturday")

  -- if a target is specified, return it;
  -- otherwise return the full table of days
  if (not target) then return weekDayTbl end
  return weekDayTbl[target]
end

local function weekdaysHeader()
  -- format header of weekdays
  local weekdays = getWeekday()
  local weekdaysHeaderText = " "
  for _,v in pairs(getWeekday()) do
    weekdaysHeaderText = weekdaysHeaderText .. string.sub(v,1,2) .. " "
  end
  return weekdaysHeaderText
end

local function calendarHeader(year, month)
  -- format full header for calendar
  local weekdaysHeader = weekdaysHeader()
  local maxHeaderLength = weekdaysHeader:len()

  local len = tostring(month):len() + tostring(year):len() +1
  local spacing = " "
  if (not (len % 2 == 0)) then spacing = "  " end
  if OPTIONS['--hide-month'] or OPTIONS['--hide-year'] then spacing = "" end

  local padding = ""
  local paddingLength = (maxHeaderLength - len)/2

  for v=1,paddingLength do
    padding = padding .. " "
  end

  local colorTag = generateColorTag('--header-color')
  if OPTIONS['--no-format'] then colorTag = "" end

  local header = spacing
  if not OPTIONS['--hide-year'] then header = year .. header end
  if not OPTIONS['--hide-month'] then header = header .. month end
  local align = generateAlignTag()
  if (header:len() > maxHeaderLength) then
    print(align .. colorTag .. header)
  else
    if OPTIONS['--align-header'] == "r" then
      padding = ""
      for v=1,(maxHeaderLength - len - spacing:len()) do
        padding = padding .. " "
      end
      print(align .. colorTag .. padding .. header .. " ")
    elseif OPTIONS['--align-header'] == "l" then
      padding = ""
      for v=1,(maxHeaderLength - len - spacing:len()) do
        padding = padding .. " "
      end
      print(align .. colorTag .. " " .. header .. padding)
    else
      print(align .. colorTag .. padding .. header .. padding)
    end
  end
  if not OPTIONS["--hide-dow"] then
    print(align .. colorTag .. weekdaysHeader .. generateColorTag())
  end
end

local function calcDaysInMonth(year, month)
  -- given a month and year, calculate how
  -- many days are in the month
  
  local days = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 }

  -- calculate for leapyear
  if (month == 2) then
    if (year % 4 == 0) then
      if (year % 100 == 0 and year % 400 == 0) then return 29 end
      return 29
    end
  end
  return days[month]
end

local function printMonthCalendar(year, monthAlpha, monthNumber)
  -- given a month and year, print calendar
  -- for the month
  calendarHeader(year, monthAlpha)
  local numDays = calcDaysInMonth(year, monthNumber)
  local lineLength = weekdaysHeader():len()
  local align = generateAlignTag()
  local today = getToday()

  -- day of week to start on
  local startDoW = os.date('*t', os.time{year=year, month=monthNumber, day=1})['wday']
  local currentLine = ""
  local currentLineColorTagCount = 0

  for d=1,numDays do
    local currentWday = os.date('*t', os.time{year=year, month=monthNumber, day=d})['wday']
    if d == 1 then
      local initPadding = ""
      for i=1,((startDoW-1)*3) do
        initPadding = initPadding .. " "
      end
      currentLine = initPadding
    end

    local customTags = ""
    local resetTags = ""

    if (currentWday == 1 or currentWday == 7) and not OPTIONS['--no-format']
      and OPTIONS['--weekend-color']:len() > 0 then
      customTags = "${color #" .. OPTIONS['--weekend-color'] .. "}"
      currentLineColorTagCount = currentLineColorTagCount + 1
    end

    if d == today and not OPTIONS['--no-format'] then
      local boldStatus = ""
      if OPTIONS['--today-bold'] then boldStatus = ":bold" end
      customTags = "${font " .. OPTIONS['--font-family'] .. boldStatus .. ":size=" .. OPTIONS['--size'] .. "}"

      if OPTIONS['--today-color']:len() > 0 then
        customTags = customTags .. "${color #" .. OPTIONS['--today-color'] .. "}"
        currentLineColorTagCount = currentLineColorTagCount + 1
      end
    end

    if customTags:len() > 0 then
      resetTags = "" .. generateFontTag()
      if string.match(customTags, "${color") then
        resetTags = resetTags .. generateColorTag()
        currentLineColorTagCount = currentLineColorTagCount + 1
      end
    end
    currentLine = currentLine .. " " .. customTags .. dayToString(d)
    if currentWday < 7 then currentLine = currentLine .. resetTags end

    if currentWday == 7 then
      local line = align .. currentLine .. generateFontTag() .. " "
      print(line)
      currentLine = ""
      currentLineColorTagCount = 0
    end

    if d == numDays then
      local padding = " "
      for v=1,(7-currentWday)*3 do
        padding = padding .. " "
      end
      print(align .. currentLine .. padding .. "${color}")
    end
  end
end

local function isArgUsed(argPassed, shortArg, fullArg)
  -- check if an arg has been used
  if (argPassed == shortArg or argPassed == fullArg) then
    return true
  end
  return false
end

local function getArgValue(argPassed, argLabel)
  if type(OPTIONS[argLabel]) == "boolean" then return true end
  return string.sub(argPassed, argLabel:len()+2, argPassed:len())
end

local YEAR = getYear()
local MONTH_ALPHA = getMonth(true)
local MONTH_NUM = getMonth()

if isArgUsed(arg[1], "-h", "--help") then
  print(HELP_TEXT)
elseif arg[1] then
  for _,currentArg in pairs(arg) do
    for i,_ in pairs(OPTIONS) do
      if string.sub(currentArg, 1, tostring(i):len()) == tostring(i) then 
        OPTIONS[i] = getArgValue(currentArg, i)
      end
    end
  end

  --for i,v in pairs(OPTIONS) do print(i, v) end

  if not OPTIONS['--no-format'] then print(generateFontTag(), generateColorTag()) end
  printMonthCalendar(YEAR, MONTH_ALPHA, MONTH_NUM)
else
  print("No args passed. Use -h flag for help.")
end
