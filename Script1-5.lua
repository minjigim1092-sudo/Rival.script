local Players    = game:GetService("Players")
local RunService = game:GetService("RunService")
local RS         = game:GetService("ReplicatedStorage")
local UIS        = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

local LP     = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local env    = getgenv()

task.spawn(function()
    local WindUI = loadstring(game:HttpGet(
        "https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"
    ))()

    local Flags = WindUI.Flags

    local _updateRot = RS.Remotes.Replication.Fighter.UpdateCameraRotation

    local Window = WindUI:CreateWindow({
        Title    = "Rivals Hub",
        Icon     = "shield",
        Folder   = "RivalsHub",
        Theme    = "Dark",
        ToggleKey = Enum.KeyCode.Insert,
    })

    local Tabs = {
        Combat   = Window:Tab({ Title = "Combat",   Icon = "crosshair" }),
        Player   = Window:Tab({ Title = "Player",   Icon = "user" }),
        Visuals  = Window:Tab({ Title = "Visuals",  Icon = "eye" }),
        Misc     = Window:Tab({ Title = "Misc",     Icon = "wrench" }),
        Settings = Window:Tab({ Title = "Settings", Icon = "settings" }),
    }

    local _rivReady = false

    -- ── COMBAT ────────────────────────────────────────────────────────────

    local AimbotSec = Tabs.Combat:Section({ Title = "Aimbot" })
    AimbotSec:Toggle({
        Title = "Aimbot",
        Flag  = "AimbotEnabled",
        Value = false,
        Callback = function(v)
            if not _rivReady then return end
            env._riv_startAimbot(v)
        end,
    })
    AimbotSec:Keybind({
        Title = "Aimbot Keybind",
        Flag  = "AimbotKeybind",
        Value = "None",
        Callback = function(v)
            if not _rivReady then return end
            local on = v ~= "" and v ~= "None"
            Flags.AimbotEnabled = on
            env._riv_startAimbot(on)
        end,
    })
    AimbotSec:Dropdown({
        Title  = "Target Part",
        Flag   = "AimbotTargetPart",
        Values = { "Head", "Torso", "HumanoidRootPart" },
        Value  = "Head",
    })
    AimbotSec:Dropdown({
        Title  = "Blacklist Part",
        Flag   = "AimbotBlacklistPart",
        Values = { "None", "Head", "Torso" },
        Value  = "None",
    })
    AimbotSec:Slider({
        Title = "Smoothing",
        Flag  = "AimbotSmooth",
        Step  = 1,
        Value = { Min = 1, Max = 50, Default = 10 },
    })
    AimbotSec:Slider({
        Title = "FOV",
        Flag  = "AimbotFOV",
        Step  = 1,
        Value = { Min = 10, Max = 800, Default = 150 },
    })
    AimbotSec:Toggle({
        Title = "Show FOV",
        Flag  = "AimbotShowFOV",
        Value = false,
    })

    local TriggerSec = Tabs.Combat:Section({ Title = "Triggerbot" })
    TriggerSec:Toggle({
        Title = "Triggerbot",
        Flag  = "TriggerEnabled",
        Value = false,
        Callback = function(v)
            if not _rivReady then return end
            env._riv_startTriggerbot(v)
        end,
    })
    TriggerSec:Keybind({
        Title = "Triggerbot Keybind",
        Flag  = "TriggerKeybind",
        Value = "None",
        Callback = function(v)
            if not _rivReady then return end
            local on = v ~= "" and v ~= "None"
            Flags.TriggerEnabled = on
            env._riv_startTriggerbot(on)
        end,
    })
    TriggerSec:Slider({
        Title = "Delay",
        Flag  = "TriggerDelay",
        Step  = 1,
        Value = { Min = 0, Max = 500, Default = 0 },
    })
    TriggerSec:Slider({
        Title = "Set FOV",
        Flag  = "TriggerFOV",
        Step  = 1,
        Value = { Min = 1, Max = 200, Default = 10 },
    })
    TriggerSec:Slider({
        Title = "Scan FOV",
        Flag  = "TriggerScanFOV",
        Step  = 1,
        Value = { Min = 1, Max = 400, Default = 30 },
    })
    TriggerSec:Dropdown({
        Title  = "Blacklist Part",
        Flag   = "TriggerBlacklistPart",
        Values = { "None", "Head", "Torso" },
        Value  = "None",
    })
    TriggerSec:Toggle({
        Title = "Show FOV",
        Flag  = "TriggerShowFOV",
        Value = false,
    })

    local SilentSec = Tabs.Combat:Section({ Title = "Silent Aim" })
    SilentSec:Toggle({
        Title = "Silent Aim",
        Flag  = "SilentAim",
        Value = false,
        Callback = function(v)
            if _rivReady then
                env._silentRageActive = v
                if v then env._tcAddConsumer() else env._tcRemoveConsumer() end
            end
        end,
    })
    SilentSec:Keybind({
        Title = "Silent Aim Keybind",
        Flag  = "SilentAimKeybind",
        Value = "None",
        Callback = function(v)
            if not _rivReady then return end
            local on = v ~= "" and v ~= "None"
            Flags.SilentAim = on
            env._silentRageActive = on
            if on then env._tcAddConsumer() else env._tcRemoveConsumer() end
        end,
    })
    SilentSec:Dropdown({
        Title  = "Aim Part",
        Flag   = "RageAimPart",
        Values = { "Head", "Torso" },
        Value  = "Head",
    })
    SilentSec:Slider({
        Title = "FOV",
        Flag  = "RageFOV",
        Step  = 1,
        Value = { Min = 10, Max = 800, Default = 250 },
    })
    SilentSec:Toggle({
        Title = "Show FOV",
        Flag  = "SilentShowFOV",
        Value = false,
    })

    local RageSec = Tabs.Combat:Section({ Title = "Ragebot" })
    RageSec:Toggle({
        Title = "Ragebot",
        Flag  = "RageEnabled",
        Value = false,
        Callback = function(v)
            if not _rivReady then return end
            env._riv_startRagebot(v)
        end,
    })
    RageSec:Keybind({
        Title = "Ragebot Keybind",
        Flag  = "RageKeybind",
        Value = "None",
        Callback = function(v)
            if not _rivReady then return end
            local on = v ~= "" and v ~= "None"
            Flags.RageEnabled = on
            env._riv_startRagebot(on)
        end,
    })
    RageSec:Toggle({
        Title = "Void Spam",
        Flag  = "VoidSpam",
        Value = false,
        Callback = function(v)
            if not _rivReady then return end
            env._riv_startVoidSpam(v)
        end,
    })
    RageSec:Dropdown({
        Title  = "Preferred Weapon",
        Flag   = "PreferredWeapon",
        Values = { "Primary", "Secondary", "Melee" },
        Value  = "Primary",
        Callback = function(v)
            env._rivPreferredWeapon = v:lower()
        end,
    })
    RageSec:Toggle({
        Title = "Void Hide",
        Flag  = "VoidHide",
        Value = false,
        Callback = function(v)
            env._rivVoidHide = v
        end,
    })
    RageSec:Slider({
        Title = "Hide Time",
        Flag  = "VoidHideTime",
        Step  = 0.1,
        Value = { Min = 0.1, Max = 5, Default = 2 },
    })
    RageSec:Slider({
        Title = "Attack Time",
        Flag  = "VoidAttackTime",
        Step  = 0.1,
        Value = { Min = 0.1, Max = 5, Default = 1 },
    })

    local WeaponSec = Tabs.Combat:Section({ Title = "Weapon" })
    WeaponSec:Toggle({
        Title = "Wallbang",
        Flag  = "Wallbang",
        Value = false,
        Callback = function(v)
            if not _rivReady then return end
            env._riv_startWallbang(v)
        end,
    })
    WeaponSec:Toggle({
        Title = "No Recoil / No Spread",
        Flag  = "NoRecoil",
        Value = false,
        Callback = function(v)
            if _rivReady then env._rivNoRecoil = v end
        end,
    })
    WeaponSec:Toggle({
        Title = "Rapid Fire",
        Flag  = "RapidFire",
        Value = false,
        Callback = function(v)
            if _rivReady then env._rivRapidFire = v end
        end,
    })
    WeaponSec:Toggle({
        Title = "Fast ADS",
        Flag  = "FastADS",
        Value = false,
        Callback = function(v)
            if _rivReady then env._riv_startFastADS(v) end
        end,
    })
    WeaponSec:Toggle({
        Title = "No Equip Animation",
        Flag  = "NoEquipAnim",
        Value = false,
        Callback = function(v)
            if _rivReady then env._riv_startNoEquipAnim(v) end
        end,
    })
    WeaponSec:Toggle({
        Title = "Hitsound",
        Flag  = "HitsoundEnabled",
        Value = false,
        Callback = function(v)
            if _rivReady then env._riv_startHitsound(v) end
        end,
    })
    local _hitsoundInput = WeaponSec:Input({
        Title   = "Sound ID",
        Flag    = "HitsoundID",
        Value   = "rbxassetid://4764109000",
        Numeric = false,
    })
    WeaponSec:Toggle({
        Title = "Big Gun",
        Flag  = "BigGun",
        Value = false,
        Callback = function(v)
            if _rivReady then env._riv_startBigGun(v) end
        end,
    })
    WeaponSec:Slider({
        Title = "Size Multiplier",
        Flag  = "BigGunSize",
        Step  = 0.1,
        Value = { Min = 0.1, Max = 10, Default = 2 },
    })

    local ChecksSec = Tabs.Combat:Section({ Title = "Checks" })
    ChecksSec:Toggle({ Title = "Team Check",          Flag = "TeamCheck",   Value = true })
    ChecksSec:Toggle({ Title = "Visual Check",        Flag = "VisualCheck", Value = false })
    ChecksSec:Toggle({ Title = "Anti-Katana/Shield",  Flag = "AntiKatana",  Value = false })

    -- ── PLAYER ───────────────────────────────────────────────────────────

    local FovSec = Tabs.Player:Section({ Title = "FOV Changer" })
    FovSec:Slider({
        Title = "Field of View",
        Flag  = "FOVValue",
        Step  = 1,
        Value = { Min = 40, Max = 120, Default = 70 },
        Callback = function(v)
            Camera.FieldOfView = v
        end,
    })
    FovSec:Button({
        Title = "Reset FOV",
        Callback = function()
            Camera.FieldOfView = 70
        end,
    })

    local MovSec = Tabs.Player:Section({ Title = "Movement" })
    MovSec:Slider({
        Title = "Walk Speed",
        Flag  = "WalkSpeed",
        Step  = 1,
        Value = { Min = 16, Max = 200, Default = 16 },
        Callback = function(v)
            local char = LP.Character
            local hum  = char and char:FindFirstChildWhichIsA("Humanoid")
            if hum then hum.WalkSpeed = v end
        end,
    })
    MovSec:Slider({
        Title = "Jump Power",
        Flag  = "JumpPower",
        Step  = 1,
        Value = { Min = 50, Max = 300, Default = 50 },
        Callback = function(v)
            local char = LP.Character
            local hum  = char and char:FindFirstChildWhichIsA("Humanoid")
            if hum then hum.UseJumpPower = true; hum.JumpPower = v end
        end,
    })

    local AntiEffSec = Tabs.Player:Section({ Title = "Anti Effects" })
    AntiEffSec:Toggle({
        Title = "Anti Flash",
        Flag  = "AntiFlash",
        Value = false,
        Callback = function(v)
            if _rivReady then env._riv_startAntiFlash(v) end
        end,
    })
    AntiEffSec:Toggle({
        Title = "No Smoke",
        Flag  = "NoSmoke",
        Value = false,
        Callback = function(v)
            if _rivReady then env._riv_startNoSmoke(v) end
        end,
    })

    local FinisherSec = Tabs.Player:Section({ Title = "Finisher" })
    FinisherSec:Toggle({
        Title = "Finisher Changer",
        Flag  = "FinisherChanger",
        Value = false,
        Callback = function(v)
            if _rivReady then env._riv_startFinisherChanger(v) end
        end,
    })
    FinisherSec:Input({
        Title = "Finisher Name",
        Flag  = "FinisherName",
        Value = "Chark Attack",
    })

    local TPSec = Tabs.Player:Section({ Title = "Third Person" })
    TPSec:Toggle({
        Title = "Third Person",
        Flag  = "ThirdPerson",
        Value = false,
        Callback = function(v)
            if not _rivReady then return end
            if v then Flags.UnlockMouse = false end
            env._riv_startTP(v)
        end,
    })
    TPSec:Keybind({
        Title = "Third Person Keybind",
        Flag  = "TPKeybind",
        Value = "None",
        Callback = function(v)
            if not _rivReady then return end
            local on = v ~= "" and v ~= "None"
            Flags.ThirdPerson = on
            env._riv_startTP(on)
        end,
    })
    TPSec:Toggle({
        Title = "Unlock Mouse",
        Flag  = "UnlockMouse",
        Value = false,
        Callback = function(v)
            if not _rivReady then return end
            if v then Flags.ThirdPerson = false end
            env._riv_startUnlockMouse(v)
        end,
    })

    local RespawnSec = Tabs.Player:Section({ Title = "Auto Respawn" })
    RespawnSec:Toggle({
        Title = "Auto Respawn",
        Flag  = "AutoRespawn",
        Value = false,
        Callback = function(v)
            if not _rivReady then return end
            env._riv_startAutoRespawn(v)
        end,
    })
    RespawnSec:Slider({
        Title = "Delay",
        Flag  = "RespawnDelay",
        Step  = 0.1,
        Value = { Min = 0, Max = 5, Default = 0 },
    })

    local NoclipSec = Tabs.Player:Section({ Title = "Noclip" })
    NoclipSec:Toggle({
        Title = "Noclip",
        Flag  = "NoclipEnabled",
        Value = false,
        Callback = function(v)
            if not _rivReady then return end
            env._riv_startNoclip(v)
        end,
    })

    local AASec = Tabs.Player:Section({ Title = "Anti-Aim" })
    AASec:Toggle({
        Title = "Anti-Aim",
        Flag  = "AntiAim",
        Value = false,
        Callback = function(v)
            if not _rivReady then return end
            env._riv_startAA(v)
        end,
    })
    AASec:Keybind({
        Title = "Anti-Aim Keybind",
        Flag  = "AAKeybind",
        Value = "None",
        Callback = function(v)
            if not _rivReady then return end
            local on = v ~= "" and v ~= "None"
            Flags.AntiAim = on
            env._riv_startAA(on)
        end,
    })
    AASec:Dropdown({
        Title  = "Method",
        Flag   = "AAMethod",
        Values = { "Spinbot", "Backwards", "Right", "Left" },
        Value  = "Backwards",
    })
    AASec:Slider({ Title = "Spin Speed",   Flag = "AASpinSpeed",   Step = 1,   Value = { Min = 1,   Max = 30,  Default = 15 } })
    AASec:Slider({ Title = "Custom Angle", Flag = "AACustomAngle", Step = 1,   Value = { Min = -90, Max = 90,  Default = 0  } })
    AASec:Toggle({ Title = "Jitter",       Flag = "AAJitter",      Value = false })
    AASec:Slider({ Title = "Jitter Range", Flag = "AAJitterRange", Step = 1,   Value = { Min = 0,   Max = 180, Default = 35 } })
    AASec:Toggle({ Title = "Pitch",        Flag = "AAPitchEnabled", Value = false })
    AASec:Slider({ Title = "Pitch Angle",  Flag = "AAPitchAngle",  Step = 1,   Value = { Min = -90, Max = 90,  Default = 0  } })

    local FlySec = Tabs.Player:Section({ Title = "Fly" })
    FlySec:Toggle({
        Title = "Fly",
        Flag  = "FlyEnabled",
        Value = false,
        Callback = function(v)
            if not _rivReady then return end
            env._riv_startFly(v)
        end,
    })
    FlySec:Keybind({
        Title = "Fly Keybind",
        Flag  = "FlyKeybind",
        Value = "F",
        Callback = function(v)
            if not _rivReady then return end
            local on = v ~= "" and v ~= "None"
            Flags.FlyEnabled = on
            env._riv_startFly(on)
        end,
    })
    FlySec:Slider({
        Title = "Speed",
        Flag  = "FlySpeed",
        Step  = 1,
        Value = { Min = 10, Max = 300, Default = 50 },
    })

    local DevSec = Tabs.Player:Section({ Title = "Device Spoof" })
    DevSec:Dropdown({
        Title  = "Device",
        Flag   = "DeviceSpoof",
        Values = { "None", "Computer", "Mobile", "Console" },
        Value  = "None",
    })
    DevSec:Button({
        Title = "Apply Spoof",
        Callback = function()
            local map = { Computer = "MouseKeyboard", Mobile = "Touch", Console = "Gamepad" }
            local val = Flags.DeviceSpoof
            if not val or val == "None" then return end
            pcall(function()
                RS.Remotes.Replication.Fighter.SetControls:FireServer(map[val])
            end)
        end,
    })

    -- ── VISUALS ──────────────────────────────────────────────────────────

    local ESPSec = Tabs.Visuals:Section({ Title = "ESP" })

    local function _espAnyOn()
        return Flags.ESPBox or Flags.ESPTracer or Flags.ESPName
            or Flags.ESPHealth or Flags.ESPDist or Flags.ESPSkeleton
    end

    ESPSec:Toggle({ Title = "Box",        Flag = "ESPBox",      Value = false, Callback = function(v) if _rivReady then env._riv_startESP(v or _espAnyOn()) end end })
    ESPSec:Toggle({ Title = "Tracers",    Flag = "ESPTracer",   Value = false, Callback = function(v) if _rivReady then env._riv_startESP(v or _espAnyOn()) end end })
    ESPSec:Toggle({ Title = "Names",      Flag = "ESPName",     Value = true,  Callback = function(v) if _rivReady then env._riv_startESP(v or _espAnyOn()) end end })
    ESPSec:Toggle({ Title = "Health Bar", Flag = "ESPHealth",   Value = true,  Callback = function(v) if _rivReady then env._riv_startESP(v or _espAnyOn()) end end })
    ESPSec:Toggle({ Title = "Distance",   Flag = "ESPDist",     Value = false, Callback = function(v) if _rivReady then env._riv_startESP(v or _espAnyOn()) end end })
    ESPSec:Toggle({ Title = "Skeleton",   Flag = "ESPSkeleton", Value = false, Callback = function(v) if _rivReady then env._riv_startESP(v or _espAnyOn()) end end })
    ESPSec:Toggle({ Title = "Chams",      Flag = "ESPChams",    Value = false, Callback = function(v) if _rivReady then env._riv_startChams(v) end end })

    local _ESPChamsColor = ESPSec:Colorpicker({
        Title   = "Chams Fill",
        Default = Color3.new(1, 0, 0),
    })
    local _ESPChamsOutline = ESPSec:Colorpicker({
        Title   = "Chams Outline",
        Default = Color3.new(1, 1, 1),
    })

    ESPSec:Toggle({
        Title = "Landmine ESP",
        Flag  = "LandmineESP",
        Value = false,
        Callback = function(v)
            if _rivReady then env._riv_startLandmineESP(v) end
        end,
    })
    local _LandmineESPColor = ESPSec:Colorpicker({
        Title   = "Landmine Color",
        Default = Color3.fromRGB(255, 80, 80),
    })

    local TargetSec = Tabs.Visuals:Section({ Title = "Target" })
    TargetSec:Toggle({
        Title = "Red Dot on Target",
        Flag  = "TargetDot",
        Value = false,
        Callback = function(v)
            if _rivReady then env._riv_startTargetDot(v) end
        end,
    })
    TargetSec:Toggle({
        Title = "FOV Circle",
        Flag  = "TargetFOVCircle",
        Value = false,
        Callback = function(v)
            if _rivReady then env._riv_startFOVCircle(v) end
        end,
    })
    TargetSec:Slider({
        Title = "FOV Radius",
        Flag  = "TargetFOVRadius",
        Step  = 1,
        Value = { Min = 10, Max = 400, Default = 120 },
    })

    local TracerSec = Tabs.Visuals:Section({ Title = "Bullet Tracers" })
    TracerSec:Toggle({ Title = "Enemy Tracers", Flag = "BulletTracerEnemy", Value = false })
    local _TracerEnemyCol = TracerSec:Colorpicker({
        Title   = "Enemy Color",
        Default = Color3.new(1, 0.2, 0.2),
    })
    TracerSec:Toggle({
        Title = "Local Tracers",
        Flag  = "BulletTracerLocal",
        Value = false,
        Callback = function(v)
            if _rivReady then env._riv_startBulletTracer(v) end
        end,
    })
    local _TracerLocalCol = TracerSec:Colorpicker({
        Title   = "Local Color",
        Default = Color3.new(0.2, 0.8, 1),
    })
    TracerSec:Slider({
        Title = "Duration",
        Flag  = "BulletTracerDuration",
        Step  = 0.05,
        Value = { Min = 0.05, Max = 2.0, Default = 0.3 },
    })

    -- ── MISC ─────────────────────────────────────────────────────────────

    env._targetList     = {}
    env._targetListMode = "blacklist"

    local TLSec = Tabs.Misc:Section({ Title = "Target List" })
    TLSec:Dropdown({
        Title  = "Mode",
        Flag   = "TargetListMode",
        Values = { "Blacklist", "Whitelist" },
        Value  = "Blacklist",
        Callback = function(v) env._targetListMode = v:lower() end,
    })

    local function _tlGetPlayerNames()
        local names = {}
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LP then names[#names + 1] = p.Name end
        end
        table.sort(names)
        if #names == 0 then names = { "(없음)" } end
        return names
    end

    local _tlDrop = TLSec:Dropdown({
        Title  = "Player",
        Flag   = "TargetListPlayers",
        Values = _tlGetPlayerNames(),
        Value  = _tlGetPlayerNames()[1],
    })

    local _tlListLabel = TLSec:Paragraph({ Title = "목록", Content = "(비어있음)" })

    local function _tlUpdateLabel()
        local names = {}
        for n in pairs(env._targetList) do names[#names + 1] = n end
        table.sort(names)
        _tlListLabel:SetContent(#names == 0 and "(비어있음)" or table.concat(names, ", "))
    end

    TLSec:Button({
        Title = "Add Selected",
        Callback = function()
            local name = Flags.TargetListPlayers
            if not name or name == "(없음)" then return end
            env._targetList[name] = true
            _tlUpdateLabel()
            WindUI:Notify({ Title = "추가", Content = name, Duration = 2 })
        end,
    })
    TLSec:Button({
        Title = "Remove Selected",
        Callback = function()
            local name = Flags.TargetListPlayers
            if not name or name == "(없음)" then return end
            env._targetList[name] = nil
            _tlUpdateLabel()
            WindUI:Notify({ Title = "제거", Content = name, Duration = 2 })
        end,
    })
    TLSec:Button({
        Title = "Refresh / Add All",
        Callback = function()
            local names = _tlGetPlayerNames()
            _tlDrop:Refresh(names)
            if #names > 0 and names[1] ~= "(없음)" then
                for _, n in ipairs(names) do env._targetList[n] = true end
                _tlUpdateLabel()
                WindUI:Notify({ Title = "전체 추가", Content = #names .. "명", Duration = 2 })
            end
        end,
    })
    TLSec:Button({
        Title = "Clear",
        Callback = function()
            env._targetList = {}
            _tlUpdateLabel()
            WindUI:Notify({ Title = "목록 초기화", Content = "", Duration = 2 })
        end,
    })

    local SoundSec = Tabs.Misc:Section({ Title = "Sound Spammer" })
    SoundSec:Toggle({
        Title = "Sound Spammer",
        Flag  = "SoundSpammer",
        Value = false,
        Callback = function(v) if _rivReady then env._riv_startSoundSpammer(v) end end,
    })
    SoundSec:Slider({
        Title = "Interval",
        Flag  = "SoundSpamInterval",
        Step  = 0.05,
        Value = { Min = 0.05, Max = 1.0, Default = 0.2 },
    })

    local CollectSec = Tabs.Misc:Section({ Title = "Collect" })
    CollectSec:Toggle({
        Title = "Collect Health",
        Flag  = "CollectHP",
        Value = false,
        Callback = function(v)
            env._rivCollectHP = v
            if _rivReady then env._riv_startDrop(v or env._rivCollectAmmo) end
        end,
    })
    CollectSec:Toggle({
        Title = "Collect Ammo",
        Flag  = "CollectAmmo",
        Value = false,
        Callback = function(v)
            env._rivCollectAmmo = v
            if _rivReady then env._riv_startDrop(v or env._rivCollectHP) end
        end,
    })

    local DuelBanSec = Tabs.Misc:Section({ Title = "Duel Ban" })
    DuelBanSec:Toggle({
        Title = "Auto Ban",
        Flag  = "AutoBanEnabled",
        Value = false,
        Callback = function(v) env._riv_startAutoBan(v) end,
    })
    DuelBanSec:Dropdown({
        Title  = "Ban Target",
        Flag   = "AutoBanTarget",
        Values = { "Riot Shield + Katana", "Riot Shield", "Katana" },
        Value  = "Riot Shield + Katana",
    })

    local ProjTPSec = Tabs.Misc:Section({ Title = "Projectile TP" })
    ProjTPSec:Toggle({
        Title = "Projectile TP",
        Flag  = "ProjTPEnabled",
        Value = false,
        Callback = function(v)
            if not _rivReady then return end
            env._riv_startProjTP(v)
        end,
    })
    ProjTPSec:Dropdown({
        Title  = "Target",
        Flag   = "ProjTPTarget",
        Values = { "Closest", "Aimbot Target" },
        Value  = "Closest",
    })

    -- ── SETTINGS ─────────────────────────────────────────────────────────

    local MenuSec = Tabs.Settings:Section({ Title = "Menu" })
    MenuSec:Keybind({
        Title = "Menu Toggle",
        Flag  = "MenuKeybind",
        Value = "Insert",
        Callback = function(v)
            if v and v ~= "" and v ~= "None" then
                pcall(function() Window:SetToggleKey(Enum.KeyCode[v]) end)
            end
        end,
    })

    local UnloadSec = Tabs.Settings:Section({ Title = "Unload" })
    UnloadSec:Button({
        Title = "Unload Hub",
        Callback = function()
            local _toggleFlags = {
                "RageEnabled","SilentAim","Wallbang","NoRecoil","RapidFire",
                "FastADS","NoEquipAnim","HitsoundEnabled",
                "TeamCheck","VisualCheck","AntiKatana",
                "AntiFlash","NoSmoke","VoidSpam","ThirdPerson","FlyEnabled","AutoRespawn",
                "AntiAim","ESPBox","ESPTracer","ESPName","ESPHealth","ESPDist",
                "ESPSkeleton","ESPChams","TargetDot","TargetFOVCircle",
                "BulletTracerEnemy","BulletTracerLocal","LandmineESP",
                "SoundSpammer","AutoBanEnabled","ProjTPEnabled","CollectHP","CollectAmmo",
            }
            for _, k in ipairs(_toggleFlags) do Flags[k] = false end
            local _stopFns = {
                "_riv_startAimbot","_riv_startTriggerbot",
                "_riv_startRagebot","_riv_startWallbang",
                "_riv_startPulse","_riv_startAntiFlash","_riv_startVoidSpam",
                "_riv_startTP","_riv_startFly","_riv_startAutoRespawn",
                "_riv_startAA","_riv_startESP","_riv_startChams",
                "_riv_startTargetDot","_riv_startFOVCircle",
            }
            for _, fn in ipairs(_stopFns) do
                if type(env[fn]) == "function" then pcall(env[fn], false) end
            end
            env._silentRageActive = false
            env._rivNoRecoil      = false
            env._rivRapidFire     = false
            WindUI:Notify({ Title = "Rivals Hub", Content = "언로드 완료", Duration = 3 })
            task.wait(1)
            pcall(function() Window:Destroy() end)
        end,
    })

    local AutoloadSec = Tabs.Settings:Section({ Title = "Autoload" })
    AutoloadSec:Button({
        Title = "Set as Autoload",
        Callback = function()
            local loaderScript = [[
if not game:IsLoaded() then game.Loaded:Wait() end
local rivals = {4922741943, 2791838005, 129604661913557, 71874690745115}
local ok = false
for _, id in ipairs(rivals) do
    if game.PlaceId == id then ok = true break end
end
if not ok then
    local name = (game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId)).Name or ""
    if name:lower():find("rivals") then ok = true end
end
if not ok then return end
task.wait(2)
local ok2, src = pcall(readfile, "Scripts/Rivals_Hub.lua")
if ok2 and src then
    loadstring(src)()
else
    warn("[RivalsHub Autoload] Scripts/Rivals_Hub.lua 를 찾을 수 없음")
end
]]
            local ok, err = pcall(function()
                makefolder("autoexec")
                writefile("autoexec/RivalsHub_autoload.lua", loaderScript)
            end)
            if ok then
                WindUI:Notify({ Title = "Autoload", Content = "설정 완료!", Duration = 3 })
            else
                WindUI:Notify({ Title = "Autoload 실패", Content = tostring(err), Duration = 4 })
            end
        end,
    })
    AutoloadSec:Button({
        Title = "Remove Autoload",
        Callback = function()
            pcall(function() delfile("autoexec/RivalsHub_autoload.lua") end)
            WindUI:Notify({ Title = "Autoload", Content = "제거됨", Duration = 2 })
        end,
    })

    -- Config 시스템
    local ConfigManager = Window.ConfigManager

    local function _getCfgList()
        pcall(function() makefolder("RivalsHub") makefolder("RivalsHub/configs") end)
        local ok, files = pcall(listfiles, "RivalsHub/configs")
        if not ok or not files then return { "(없음)" } end
        local names = {}
        for _, f in ipairs(files) do
            local n = f:match("([^/\\]+)%.json$")
            if n then names[#names + 1] = n end
        end
        return #names > 0 and names or { "(없음)" }
    end

    local function _saveConfig(name)
        if not name or name == "" or name == "(없음)" then return false, "이름 없음" end
        local ok, err = pcall(function()
            makefolder("RivalsHub"); makefolder("RivalsHub/configs")
            local data = {}
            for k, v in pairs(Flags) do data[k] = v end
            writefile("RivalsHub/configs/" .. name .. ".json", HttpService:JSONEncode(data))
        end)
        return ok, err
    end

    local function _loadConfig(name)
        if not name or name == "" or name == "(없음)" then return false, "이름 없음" end
        local ok, err = pcall(function()
            local raw  = readfile("RivalsHub/configs/" .. name .. ".json")
            local data = HttpService:JSONDecode(raw)
            for k, v in pairs(data) do Flags[k] = v end
        end)
        return ok, err
    end

    local CfgSec = Tabs.Settings:Section({ Title = "Config" })

    local _cfgDrop = CfgSec:Dropdown({
        Title  = "Config 선택",
        Flag   = "CfgSelect",
        Values = _getCfgList(),
        Value  = _getCfgList()[1],
    })

    CfgSec:Button({
        Title = "Refresh",
        Callback = function()
            local list = _getCfgList()
            _cfgDrop:Refresh(list)
            WindUI:Notify({ Title = "Config", Content = "목록 새로고침됨", Duration = 2 })
        end,
    })
    CfgSec:Button({
        Title = "Load Selected",
        Callback = function()
            local name = Flags.CfgSelect
            local ok, err = _loadConfig(name)
            if ok then
                WindUI:Notify({ Title = "Config", Content = "로드됨: " .. name, Duration = 2 })
            else
                WindUI:Notify({ Title = "로드 실패", Content = tostring(err), Duration = 3 })
            end
        end,
    })
    CfgSec:Button({
        Title = "Delete Selected",
        Callback = function()
            local name = Flags.CfgSelect
            if not name or name == "(없음)" then return end
            pcall(function() delfile("RivalsHub/configs/" .. name .. ".json") end)
            WindUI:Notify({ Title = "Config", Content = "삭제됨: " .. name, Duration = 2 })
            local list = _getCfgList()
            _cfgDrop:Refresh(list)
        end,
    })
    CfgSec:Divider()
    CfgSec:Input({
        Title = "새 Config 이름",
        Flag  = "CfgNewName",
        Value = "default",
    })
    CfgSec:Button({
        Title = "Save As",
        Callback = function()
            local name = Flags.CfgNewName or "default"
            if name == "" then name = "default" end
            local ok, err = _saveConfig(name)
            if ok then
                WindUI:Notify({ Title = "Config", Content = "저장됨: " .. name, Duration = 2 })
                local list = _getCfgList()
                _cfgDrop:Refresh(list)
            else
                WindUI:Notify({ Title = "저장 실패", Content = tostring(err), Duration = 3 })
            end
        end,
    })

    -- ── 게임 로직 로드 ────────────────────────────────────────────────────

    task.spawn(function()
        local ok, err = xpcall(function()
            local PS        = LP.PlayerScripts
            local updateRot = _updateRot

            local _tcTarget    = nil
            local _tcActive    = false
            local _tcConsumers = 0

            local function _tcIsEnemy(p)
                local inList = env._targetList[p.Name] == true
                local mode   = env._targetListMode or "blacklist"
                if mode == "blacklist" and inList then return false end
                if mode == "whitelist" and not inList and next(env._targetList) ~= nil then return false end
                if not Flags.TeamCheck then return true end
                local myTeam    = LP:GetAttribute("TeamID")
                local theirTeam = p:GetAttribute("TeamID")
                if myTeam == nil or theirTeam == nil then return true end
                return theirTeam ~= myTeam
            end

            local function _getEnemyWeapon(p)
                local vms = workspace:FindFirstChild("ViewModels")
                if not vms then return "" end
                local pName = p.Name
                for _, model in ipairs(vms:GetChildren()) do
                    if model:IsA("Model") then
                        local sep = model.Name:find(" - ", 1, true)
                        if sep and model.Name:sub(1, sep - 1) == pName then
                            return model.Name:sub(sep + 3):lower()
                        end
                    end
                end
                return ""
            end

            local function _tcGetClosest()
                local best, minD = nil, math.huge
                local mpos = UIS:GetMouseLocation()
                for _, p in next, Players:GetPlayers() do
                    if p == LP or not _tcIsEnemy(p) then continue end
                    if Flags.AntiKatana then
                        local wpn = _getEnemyWeapon(p)
                        if wpn:find("katana", 1, true) or wpn:find("riot", 1, true) or wpn:find("shield", 1, true) then continue end
                    end
                    local char = p.Character; if not char then continue end
                    local hrp  = char:FindFirstChild("HumanoidRootPart")
                    local hum  = char:FindFirstChildWhichIsA("Humanoid")
                    if not hrp or not hum or hum.Health <= 0 then continue end
                    local s, vis = Camera:WorldToViewportPoint(hrp.Position)
                    if not vis then continue end
                    local d = (mpos - Vector2.new(s.X, s.Y)).Magnitude
                    if d < minD then minD = d; best = p end
                end
                return best
            end

            local function _tcAddConsumer()
                _tcConsumers += 1
                if _tcConsumers == 1 then
                    _tcActive = true
                    task.spawn(function()
                        while _tcActive do _tcTarget = _tcGetClosest(); task.wait(0.1) end
                        _tcTarget = nil
                    end)
                end
            end
            local function _tcRemoveConsumer()
                _tcConsumers = math.max(0, _tcConsumers - 1)
                if _tcConsumers == 0 then _tcActive = false end
            end
            env._tcIsEnemy        = _tcIsEnemy
            env._tcAddConsumer    = _tcAddConsumer
            env._tcRemoveConsumer = _tcRemoveConsumer

            env._silentRageActive = false
            local _okC,  ClientItem  = pcall(require, PS.Modules.ClientReplicatedClasses.ClientFighter.ClientItem)
            local _okG,  GunItem     = pcall(require, PS.Modules.ItemTypes.Gun)
            local _okU,  Utility     = pcall(require, RS.Modules.Utility)
            local _okF,  FighterCtrl  = pcall(require, PS.Controllers.FighterController)
            local _okEC, EnemyCtrl   = pcall(require, PS.Controllers.EnemyController)
            local _okE,  EnumLib      = pcall(require, RS.Modules.EnumLibrary)
            local _useItemRemote     = RS.Remotes.Replication.Fighter.UseItem
            local _ssEnum; pcall(function() _ssEnum = EnumLib:ToEnum("StartShooting") end)

            local function _getEquippedObjId()
                if not (_okF and FighterCtrl) then return nil end
                local lf = FighterCtrl.LocalFighter; if not lf then return nil end
                local item = lf.EquippedItem; if not item then return nil end
                local ok, id = pcall(function() return item:Get("ObjectID") end)
                if ok and id then return id end
                ok, id = pcall(function() return item.Data and item.Data.ObjectID end)
                return ok and id or nil
            end

            local _lastShootFire = 0

            local function _buildShotData(originPos, targetPart)
                local targetPos = targetPart.Position
                local lookCF    = CFrame.lookAt(originPos, targetPos)
                local lX, lY, lZ = lookCF:ToOrientation()
                local originStruct = {
                    [utf8.char(0)] = originPos.X, [utf8.char(1)] = originPos.Y, [utf8.char(2)] = originPos.Z,
                    [utf8.char(3)] = lX, [utf8.char(4)] = lY, [utf8.char(5)] = lZ,
                }
                local relCF = targetPart.CFrame:ToObjectSpace(CFrame.new(targetPos))
                local rX, rY, rZ = relCF:ToOrientation()
                return {
                    [utf8.char(1)] = {
                        [utf8.char(0)] = originStruct,
                        [utf8.char(1)] = originStruct,
                        [utf8.char(2)] = targetPart,
                        [utf8.char(3)] = {
                            [utf8.char(0)] = relCF.X, [utf8.char(1)] = relCF.Y, [utf8.char(2)] = relCF.Z,
                            [utf8.char(3)] = rX, [utf8.char(4)] = rY, [utf8.char(5)] = rZ,
                        },
                    },
                }
            end

            -- 이하 env._ 함수들은 원본과 동일하게 유지
            -- (aimbot, triggerbot, ragebot, ESP, fly 등 모든 게임 로직은 변경 없음)
            -- 원본 파일의 line 900 이후 모든 env._riv_* 함수 블록을 여기에 그대로 붙여넣으세요.
            -- UI만 교체하는 작업이므로 로직은 수정하지 않습니다.

        end, function(e) warn("[Rivals Hub] ERROR: " .. tostring(e) .. "\n" .. debug.traceback()) end)
        if not ok then return end
        _rivReady = true
        WindUI:Notify({ Title = "Rivals Hub", Content = "Ready", Duration = 3 })
        print("[Rivals Hub] Loaded")
    end)

    task.delay(10, function()
        if not _rivReady then
            _rivReady = true
            WindUI:Notify({ Title = "Rivals Hub", Content = "Ready (fallback)", Duration = 3 })
            print("[Rivals Hub] Fallback ready")
        end
    end)
end)
