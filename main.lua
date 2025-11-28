local gui = Instance.new("ScreenGui")
gui.Name = "TriplesixxxObfuscatorGUI"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false

task.spawn(function()
    local Players = game:GetService("Players")
    repeat task.wait() until Players.LocalPlayer and Players.LocalPlayer:FindFirstChild("PlayerGui")
    gui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
end)

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 380, 0, 280)
frame.Position = UDim2.new(0.5, -190, 0.5, -140)
frame.BackgroundColor3 = Color3.fromRGB(15, 0, 0) -- Dark red/black
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = gui

Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

-- Title Bar
local titleBar = Instance.new("Frame", frame)
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.Position = UDim2.new(0, 0, 0, 0)
titleBar.BackgroundColor3 = Color3.fromRGB(40, 0, 0) -- Dark red
titleBar.BorderSizePixel = 0
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel", titleBar)
title.Size = UDim2.new(1, -60, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.Text = "Triplesixxx Simple Obfuscator"
title.TextColor3 = Color3.fromRGB(255, 255, 255) -- White
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextXAlignment = Enum.TextXAlignment.Left

local closeBtn = Instance.new("TextButton", titleBar)
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -30, 0, 3)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 60, 60) -- Bright red
closeBtn.BackgroundColor3 = Color3.fromRGB(80, 0, 0) -- Dark red
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 16
closeBtn.BorderSizePixel = 0
closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)

local input = Instance.new("TextBox", frame)
input.Position = UDim2.new(0, 10, 0, 40)
input.Size = UDim2.new(1, -20, 0, 80)
input.Text = "-- paste your script here"
input.ClearTextOnFocus = true
input.MultiLine = true
input.TextWrapped = true
input.TextColor3 = Color3.fromRGB(255, 255, 255) -- White
input.BackgroundColor3 = Color3.fromRGB(30, 0, 0) -- Dark red
input.Font = Enum.Font.Code
input.TextSize = 14
input.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
Instance.new("UICorner", input).CornerRadius = UDim.new(0, 8)

local output = Instance.new("TextBox", frame)
output.Position = UDim2.new(0, 10, 0, 130)
output.Size = UDim2.new(1, -20, 0, 80)
output.ClearTextOnFocus = false
output.MultiLine = true
input.TextWrapped = true
output.TextXAlignment = Enum.TextXAlignment.Left
output.TextYAlignment = Enum.TextYAlignment.Top
output.TextColor3 = Color3.fromRGB(255, 60, 60) -- Bright red
output.BackgroundColor3 = Color3.fromRGB(10, 0, 0) -- Very dark red/black
output.Font = Enum.Font.Code
output.TextSize = 14
Instance.new("UICorner", output).CornerRadius = UDim.new(0, 8)

local obBtn = Instance.new("TextButton", frame)
obBtn.Position = UDim2.new(0, 10, 1, -35)
obBtn.Size = UDim2.new(0.5, -15, 0, 25)
obBtn.Text = "Obfuscate"
obBtn.TextColor3 = Color3.fromRGB(255, 255, 255) -- White
obBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0) -- Medium red
obBtn.Font = Enum.Font.GothamBold
obBtn.TextSize = 14
Instance.new("UICorner", obBtn).CornerRadius = UDim.new(0, 6)

-- Hover effects for obfuscate button
obBtn.MouseEnter:Connect(function()
    obBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0) -- Brighter red
end)

obBtn.MouseLeave:Connect(function()
    obBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0) -- Original red
end)

local copyBtn = Instance.new("TextButton", frame)
copyBtn.Position = UDim2.new(0.5, 5, 1, -35)
copyBtn.Size = UDim2.new(0.5, -15, 0, 25)
copyBtn.Text = "Copy"
copyBtn.TextColor3 = Color3.fromRGB(255, 255, 255) -- White
copyBtn.BackgroundColor3 = Color3.fromRGB(80, 0, 0) -- Dark red
copyBtn.Font = Enum.Font.GothamBold
copyBtn.TextSize = 14
Instance.new("UICorner", copyBtn).CornerRadius = UDim.new(0, 6)

-- Hover effects for copy button
copyBtn.MouseEnter:Connect(function()
    copyBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 0) -- Brighter red
end)

copyBtn.MouseLeave:Connect(function()
    copyBtn.BackgroundColor3 = Color3.fromRGB(80, 0, 0) -- Original red
end)

copyBtn.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(output.Text)
    else
        warn("Clipboard not supported!")
    end
end)

obBtn.MouseButton1Click:Connect(function()
    task.spawn(function()
        local src = input.Text
        if not src or src == "" or src == "-- paste your script here" then
            output.Text = "-- insert script first"
            return
        end
        
        local success, result = pcall(function()
            local bit = bit32 or bit

            local function generateCustomBase64()
                local chars = {}
                local base = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

                for i = 1, #base do
                    chars[i] = base:sub(i,i)
                end
                for i = #chars, 2, -1 do
                    local j = math.random(1, i)
                    chars[i], chars[j] = chars[j], chars[i]
                end
                return table.concat(chars), base
            end
            
            local customChars, originalChars = generateCustomBase64()
            
            local function encodeCustomBase64(data)
                local result = {}
                for i = 1, #data, 3 do
                    local a, b, c = data:byte(i, i+2)
                    local n = (a or 0) * 65536 + (b or 0) * 256 + (c or 0)
                    
                    local s1 = customChars:sub((math.floor(n / 262144) % 64) + 1, (math.floor(n / 262144) % 64) + 1)
                    local s2 = customChars:sub((math.floor(n / 4096) % 64) + 1, (math.floor(n / 4096) % 64) + 1)
                    local s3 = customChars:sub((math.floor(n / 64) % 64) + 1, (math.floor(n / 64) % 64) + 1)
                    local s4 = customChars:sub((n % 64) + 1, (n % 64) + 1)
                    
                    table.insert(result, s1 .. s2 .. s3 .. s4)
                end
                return table.concat(result)
            end

            local function multiXOREncrypt(data, layers)
                local encrypted = data
                local allKeys = {}
                local allFlags = {}
                
                for layer = 1, layers do
                    local layerKeys = {}
                    local layerFlags = {}
                    local temp = {}
                    
                    for i = 1, #encrypted do
                        local c = encrypted:byte(i)
                        local k = math.random(1, 255)
                        table.insert(temp, bit.bxor(c, k))
                        table.insert(layerKeys, k)
                        table.insert(layerFlags, 1)

                        if math.random() < 0.4 then
                            table.insert(temp, math.random(0, 255))
                            table.insert(layerKeys, math.random(1, 255))
                            table.insert(layerFlags, 0)
                        end
                    end
                    
                    encrypted = string.char(table.unpack(temp))
                    table.insert(allKeys, layerKeys)
                    table.insert(allFlags, layerFlags)
                end
                
                return encrypted, allKeys, allFlags
            end

            local function randomVarName(length)
                local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
                local name = ""
                for i = 1, length do
                    name = name .. chars:sub(math.random(1, #chars), math.random(1, #chars))
                end
                return name
            end

            local encryptedData, keysTable, flagsTable = multiXOREncrypt(src, 2)
            local function safeChar(data)
                local chunks, step = {}, 1500
                for i = 1, #data, step do
                    local chunk = {data:byte(i, math.min(i + step - 1, #data))}
                    table.insert(chunks, string.char(table.unpack(chunk)))
                end
                return table.concat(chunks)
            end

            local b64Data = encodeCustomBase64(safeChar(encryptedData))

            local varBit = randomVarName(6)
            local varChars = randomVarName(6)
            local varDict = randomVarName(6)
            local varI = randomVarName(3)
            local varB64 = randomVarName(6)
            local varRaw = randomVarName(6)
            local varTemp = randomVarName(6)
            local varOut = randomVarName(6)
            
            local decoder = "local "..varBit.."=bit32 or bit "
            decoder = decoder.."local "..varChars.."='"..customChars.."' "
            decoder = decoder.."local "..varDict.."={} "
            decoder = decoder.."for "..varI.."=1,#"..varChars.." do "
            decoder = decoder..varDict.."["..varChars..":sub("..varI..","..varI..")]="..varI.."-1 end "

            for i = 1, #keysTable do
                local keysStr = "{"..table.concat(keysTable[i], ",").."}"
                local flagsStr = "{"..table.concat(flagsTable[i], ",").."}"
                decoder = decoder.."local k"..i.."="..keysStr.." "
                decoder = decoder.."local f"..i.."="..flagsStr.." "
            end
            
            decoder = decoder.."local "..varB64.."='"..b64Data.."' "
            decoder = decoder.."local "..varRaw.."='' "

            decoder = decoder.."for "..varI.."=1,#"..varB64.."-3,4 do "
            decoder = decoder.."local n="..varBit..".bor("
            decoder = decoder..varBit..".lshift("..varDict.."["..varB64..":sub("..varI..","..varI..")],18),"
            decoder = decoder..varBit..".lshift("..varDict.."["..varB64..":sub("..varI.."+1,"..varI.."+1)],12),"
            decoder = decoder..varBit..".lshift("..varDict.."["..varB64..":sub("..varI.."+2,"..varI.."+2)],6),"
            decoder = decoder..varDict.."["..varB64..":sub("..varI.."+3,"..varI.."+3)] or 0) "
            decoder = decoder..varRaw.."="..varRaw.."..string.char("
            decoder = decoder..varBit..".rshift(n,16),"
            decoder = decoder..varBit..".rshift(n,8)%256,"
            decoder = decoder.."n%256) end "

            for i = #keysTable, 1, -1 do
                local prevVar = (i == #keysTable) and varRaw or "dec"..(i+1)
                local currVar = "dec"..i
                
                decoder = decoder.."local "..currVar.."={} "
                decoder = decoder.."local j=1 "
                decoder = decoder.."for i=1,#f"..i.." do "
                decoder = decoder.."if f"..i.."[i]==1 then "
                decoder = decoder.."table.insert("..currVar..",string.char("
                decoder = decoder..varBit..".bxor("..prevVar..":byte(j),k"..i.."[i]))) "
                decoder = decoder.."j=j+1 "
                decoder = decoder.."else j=j+1 end end "
                decoder = decoder..currVar.."=table.concat("..currVar..") "
            end
            
            decoder = decoder.."loadstring(dec1)()"
            
            return "-- Obfuscated by Triplesixxx Obfuscator\n"..decoder
        end)
        
        output.Text = success and result or "-- ERROR: "..tostring(result)
    end)
end)
