local cheatsEnabled = {}
local waypoints = {}
local autoAmmo = {}
local infiniteAmmo = infiniteAmmo or {}

local ammoTypes = {
    "Pistol", "SMG1", "SMG1_Grenade", "AR2", "AR2AltFire", "Buckshot", "357",
    "Grenade", "GrenadeHE", "Battery", "XBowBolt", "SniperRound", "AirboatGun",
    "CombineCannon", "RPG_Round", "RPG_Missile", "Flare", "AlyxGun", "SMG1_Grenade"
}

local minAmmo = 500
local maxAmmo = 1000
--configde hileler açılırsa buraya da getir
--if MRTFConfig.HilelerVarsayilanAktif then
--  cheatsEnabled[ply] = true
--end

hook.Add("PlayerSay", "MRTFCheats", function(ply, text)
    -- . ile başlayan komutlar için kontrol
    if string.sub(text,1,1) == "." then
        local args = string.Explode(" ", text)
        local cmd = string.sub(args[1], 2):lower()

        if cmd == "give" then
            local wepName = args[2]
            if not wepName then
                ply:ChatPrint("yanlış yazdın, Örnek: .give manhack_welder")
                return ""
            end
            ply:Give(wepName)
            ply:ChatPrint("al: " .. wepName)
            return ""
        end
    end

    text = string.lower(text)
    if text == "/v" or text == "/vanish" then
        ply:AddEffects(EF_NODRAW)
        ply:SetNoTarget(true)
        ply:SetNotSolid(true)
        ply:DrawShadow(false)
        ply:ChatPrint("Görünmez oldun. /uv ile görünür olabilirsin.")
        return ""
    elseif text == "/uv" then
        ply:RemoveEffects(EF_NODRAW)
        ply:SetNoTarget(false)
        ply:SetNotSolid(false)
        ply:DrawShadow(true)
        ply:ChatPrint("Tekrar görünürsün.")
        return ""
    elseif text == "/enable" or text == "/e" or text == "/" then
        cheatsEnabled[ply] = true
        ply:ChatPrint("Hileler aktif")
        return ""
    elseif not cheatsEnabled[ply] then
        ply:ChatPrint("Önce /enable yaz")
        return ""
    elseif text == "/god" or text == "/sudo" then
        ply:GodEnable()
        ply:ChatPrint("God modu aktif!")
        return ""
    elseif text == "/ungod" then
        ply:GodDisable()
        ply:ChatPrint("God modu kapandı")
        return ""
    elseif text == "/noclip" then
        ply:SetMoveType(MOVETYPE_NOCLIP)
        ply:ChatPrint("Noclip aktif!")
        return ""
    elseif text == "/kill" then
        ply:Kill()
        return ""
    elseif text == "/ammo" then
        infiniteAmmo[ply] = true
        ply:ChatPrint("Otomatik mermi aktif, kapatmak için /ammo_off yaz.")
        return ""
    elseif text == "/ammo_off" then
        infiniteAmmo[ply] = false
        --autoAmmo[ply] = false
        ply:ChatPrint("Otomatik mermi kapandı.")
        return ""
    elseif text == "/help" then
        ply:ChatPrint(" ------TEMEL KOMUTLAR:--------")
        ply:ChatPrint("  /enable = hileleri aktif et")
        ply:ChatPrint("  /disable = hileleri kapat")
        ply:ChatPrint("  /help = bu yardım menüsü")
        ply:ChatPrint("  /god = ölümsüzlük modu aç")
        ply:ChatPrint("  /ungod = ölümsüzlük modu kapat")
        ply:ChatPrint("  /noclip = duvarlarda geçme modu")
        ply:ChatPrint("  /notarget = NPC'lerden görünmez ol")
        ply:ChatPrint("  /target = tekrar görünür ol")
        ply:ChatPrint("-----")
        ply:ChatPrint("HIZ AYARLARI: /help_speed ile ulaş")
        ply:ChatPrint(" ZIPLAMA AYARLARI: /help_gravity ile ulaş")
        ply:ChatPrint("--------")
        ply:ChatPrint("-----------MERMİ SİSTEMİ:---------------------")
        ply:ChatPrint("  /ammo = otomatik mermi doldurma aç(mermin 500'ün altına düşmez)")
        ply:ChatPrint("  /ammo_off = otomatik mermi doldurma kapat")
        ply:ChatPrint("")
        ply:ChatPrint(" --------OYUNCU KONTROLÜ:----------------------")
        ply:ChatPrint("  /sethp [sayı] = canını ayarla")
        ply:ChatPrint("  /kill = kendini öldür")
        ply:ChatPrint("  /freeze = donma")
        ply:ChatPrint("  /unfreeze = donmayı çöz")
        ply:ChatPrint("  /ignite = kendini yak")
        ply:ChatPrint("  /water = ateşi söndür")
        ply:ChatPrint("  /clear = envanteri temizle")
        ply:ChatPrint("  /tp [oyuncu adı] = oyuncuya ışınlan")
        ply:ChatPrint("  /tp list = aktif oyuncuları listele")
        ply:ChatPrint("")
        ply:ChatPrint(" ------------NPC KONTROLÜ:----------------------")
        ply:ChatPrint("  /summon [npc_adı] = NPC çağır")
        ply:ChatPrint("  /rm @e = tüm NPC'leri temizle")
        ply:ChatPrint("")
        ply:ChatPrint(" ------------WAYPOINT KOMUTLARI:----------------")
        ply:ChatPrint("  /waypoint [isim] = waypoint oluştur")
        ply:ChatPrint("  /tpw [isim] = waypoint'e ışınlan")
        ply:ChatPrint("  /tpw_list = waypoint listesini göster")
        return ""

    elseif text == "/help_speed" then
        ply:ChatPrint("------------speed---------------")
        ply:ChatPrint("/speed = hız arttır")
        ply:ChatPrint("/speed_normal = hız normal")
        ply:ChatPrint("/speed_turbo = hız arttır++")
        ply:ChatPrint("/speed_flash = hız premium arttır++")
        ply:ChatPrint("/speed_sudo = hız premium arttır++ pro max 512 gb")
        ply:ChatPrint("/speed_custom = custom hız değeri")
        return ""
    elseif text == "/help_gravity" then
        ply:ChatPrint("------------gravity-------------")
        ply:ChatPrint("/gravity = restore gravity normal")
        ply:ChatPrint("/gravity_add = birazcık zıplatıyo")
        ply:ChatPrint("/gravity_moon = ay gravity'si")
        ply:ChatPrint("/gravity_space = uzay gravity'si")
        ply:ChatPrint("/gravity_max = ZIPLAMAYAN.... ")
        return ""
    elseif text == "/disable" then
        cheatsEnabled[ply] = false
        ply:ChatPrint("Hileler kapandı")
        return ""
    elseif text == "/clear" then
        for _, wep in ipairs(ply:GetWeapons()) do
            wep:Remove()
        end
        ply:ChatPrint("Tüm itemler kaldırıldı.")
        return ""
    elseif text == "/notarget" then
        ply:SetNoTarget(true)
        ply:ChatPrint("NPC'lere karşı görünmezsin, /target ile görünür olursun.")
        return ""
    elseif text == "/target" then
        ply:SetNoTarget(false)
        ply:ChatPrint("Artık görünürsün.")
        return ""
    elseif text == "/freeze" then
        ply:Freeze(true)
        ply:ChatPrint("Dondun, /unfreeze ile çözersin.")
        return ""
    elseif text == "/unfreeze" then
        ply:Freeze(false)
        ply:ChatPrint("Çözüldün.")
        return ""
    elseif string.sub(text, 1, 8) == "/summon " then
        local npcName = string.sub(text, 9)
        local trace = ply:GetEyeTrace()

        local npc = ents.Create(npcName)
        if not IsValid(npc) then
            ply:ChatPrint("Geçersiz NPC adı: " .. npcName)
            return ""
        end

        npc:SetPos(trace.HitPos + Vector(0, 0, 10))
        npc:Spawn()
        ply:ChatPrint(npcName .. " çağrıldı.")
        return ""
    elseif string.sub(text, 1, 9) == "/waypoint" then
        local name = string.Trim(string.sub(text, 10))
        if name == "" then
            ply:ChatPrint("Waypoint ismi yaz!")
            return ""
        end
        waypoints[name] = ply:GetPos()
        ply:ChatPrint("Waypoint '" .. name .. "' oluşturuldu.")
        return ""
    elseif string.sub(text, 1, 4) == "/tpw" then
        local name = string.Trim(string.sub(text, 5))
        if name == "" then
            ply:ChatPrint("Waypoint ismi yaz!")
            return ""
        end
        if not waypoints[name] then
            ply:ChatPrint("Böyle bir waypoint yok: " .. name)
            return ""
        end
        ply:SetPos(waypoints[name] + Vector(0, 0, 50))
        ply:ChatPrint("Waypoint '" .. name .. "'e ışınlandın.")
        return ""
    elseif text == "/ls_way" or text == "/lsway" or text == "/lsw" then
        ply:ChatPrint("Mevcut waypointler:")
        for name, _ in pairs(waypoints) do
            ply:ChatPrint("- " .. name)
        end
        return ""
    elseif string.sub(text, 1, 6) == "/kill " then
        local npcClass = string.sub(text, 7):lower()
        local killed = 0

        for _, ent in ipairs(ents.GetAll()) do
            if ent:IsNPC() and ent:GetClass():lower() == npcClass then
                ent:TakeDamage(ent:Health(), ply, ply)
                killed = killed + 1
            end
        end

        if killed > 0 then
            ply:ChatPrint(npcClass .. " sınıfından " .. killed .. " NPC öldürüldü.")
        else
            ply:ChatPrint("NPC bulunamadı: " .. npcClass)
        end

        return ""
    elseif text == "/rm @e" then
        local count = 0

        for _, ent in ipairs(ents.GetAll()) do
            if ent:IsNPC() or ent:IsNextBot() then
                ent:Remove()
                count = count + 1
            end
        end

        ply:ChatPrint("Tüm NPC ve NextBot'lar temizlendi. Toplam: " .. count)
        return ""
    elseif text == "/tp list" then
        ply:ChatPrint("aktif oyuncular:")
        for _, p in ipairs(player.GetAll()) do
            ply:ChatPrint("• " .. p:Nick())
        end
        return ""
    elseif text == "/speed" then
        ply:SetWalkSpeed(400)
        ply:SetRunSpeed(800)
        ply:ChatPrint("Hız arttırıldı!")
        return ""
    elseif text == "/speed_normal" or text == "/speedn" or text == "/speed_n" or text == "/spdn" then
        ply:SetWalkSpeed(200)
        ply:SetRunSpeed(400)
        ply:ChatPrint("Hız normale döndü.")
        return ""
    elseif text == "/speed_turbo" then
        ply:SetWalkSpeed(600)
        ply:SetRunSpeed(1200)
        ply:ChatPrint("Hız turbo mod")
        return ""
    elseif text == "/speed_flash" then
        ply:SetWalkSpeed(1200 * 2)
        ply:SetRunSpeed(2400 * 2)
        ply:ChatPrint("Hız flash oldu")
        return ""
    elseif text == "/speed_sudo" then
        ply:SetWalkSpeed(9600 * 2)
        ply:SetRunSpeed(19200 * 2)
        ply:ChatPrint("hız oba çok fena")
        return ""
    elseif text == "/gravity" then
        ply:SetJumpPower(200)
        ply:ChatPrint("zıplaman normal")
        return ""
    elseif text == "/gravity_add" then
        ply:SetJumpPower(400)
        ply:ChatPrint("zıplaman arttı!")
        return ""
    elseif text == "/gravity_moon" then
        ply:SetJumpPower(600)
        ply:ChatPrint("ay'daki gibi")
        return ""
    elseif text == "/gravity_space" then
        ply:SetJumpPower(1200 * 2)
        ply:ChatPrint("uzaydaki gibi")
        return ""
    elseif text == "/gravity_max" then
        ply:SetJumpPower(9600 * 5)
        ply:ChatPrint("ZIPLA ZIPLA ZIPLAMAYAN............")
        return ""
    elseif text == "/ignite" then
        ply:Ignite(9999999999999999)
        ply:ChatPrint("Yandın!")
        return ""
    elseif text == "/water" then
        ply:Extinguish()
        ply:ChatPrint("Söndün.")
        return ""
        -- kit kısmı
    elseif text == "/kit" or text == "/kit_normal" then
        ply:SetJumpPower(200)
        ply:SetWalkSpeed(200)
        ply:SetRunSpeed(400)
        ply:ChatPrint("Default silahlar veriliyor")
        ply:Give("weapon_crowbar")
        ply:Give("weapon_pistol")
        ply:Give("weapon_smg1")
        ply:Give("weapon_ar2")
        ply:Give("weapon_shotgun")
        ply:Give("weapon_physcannon")
        ply:Give("weapon_physgun")
        ply:Give("gmod_tool")
        ply:Give("weapon_357")
        ply:Give("weapon_crossbow")
        ply:Give("weapon_frag")
        ply:Give("weapon_rpg")
        ply:Give("gmod_camera")
        return ""
    elseif text == "/kitsp" or text == "/kit_speedrun" or text == "/kit_dream" or text == "/kitd" then
        ply:SetWalkSpeed(400)
        ply:SetRunSpeed(800)
        ply:SetJumpPower(300)
        for _, wep in ipairs(ply:GetWeapons()) do
            wep:Remove()
        end
        return ""

    elseif string.sub(text, 1, 4) == "/tp " then
        local targetName = string.sub(text, 5):lower()
        local found = false

        for _, target in ipairs(player.GetAll()) do
            if string.find(target:Nick():lower(), targetName, 1, true) then
                ply:SetPos(target:GetPos() + Vector(0, 0, 50))
                ply:ChatPrint("Işınlandın → " .. target:Nick())
                found = true
                break
            end
        end

        if not found then
            ply:ChatPrint("Oyuncu bulunamadı: " .. targetName)
        end

        return ""
    end

    -- /sethp 100 gibi komutlar için
    local hp = string.match(text, "^/sethp%s+(%d+)$")
    if hp then
        hp = tonumber(hp)
        if hp and hp >= -999999 then
            ply:SetHealth(hp)
            ply:ChatPrint("Canın artık " .. hp)
        else
            ply:ChatPrint("Geçerli bir sayı gir.")
        end
        return ""
    end

    -- /speed_custom 500 gibi komutlar için
    local speedVal = string.match(text, "^/speed_custom%s+(%d+)$")
    if speedVal then
        speedVal = tonumber(speedVal)
        if speedVal and speedVal > 0 then
            ply:SetWalkSpeed(speedVal)
            ply:SetRunSpeed(speedVal * 2)
            ply:ChatPrint("Yürüyüş hızı: " .. speedVal .. ", Koşu hızı: " .. (speedVal * 2))
        else
            ply:ChatPrint("Geçerli bir sayı gir.")
        end
        return ""
    end

    -- /gravity_custom 500 gibi komutlar için
    local jumpVal = string.match(text, "^/gravity_custom%s+(%d+)$")
    if jumpVal then
        jumpVal = tonumber(jumpVal)
        if jumpVal and jumpVal > 0 then
            ply:SetJumpPower(jumpVal)
            ply:ChatPrint("Zıplama gücü " .. jumpVal .. " olarak ayarlandı.")
        else
            ply:ChatPrint("Geçerli bir sayı gir.")
        end
        return ""
    end
end)

timer.Create("MRTF_InfiniteAmmo_Reserve", 1, 0, function()
    for ply, enabled in pairs(infiniteAmmo) do
        if enabled and IsValid(ply) and ply:Alive() then
            local wep = ply:GetActiveWeapon()
            if IsValid(wep) then
                local ammoType = wep:GetPrimaryAmmoType()
                if ammoType ~= -1 then
                    ply:SetAmmo(9999, ammoType)
                end

                local sec = wep:GetSecondaryAmmoType()
                if sec ~= -1 then
                    ply:SetAmmo(9999, sec)
                end
            end
        end
    end
end)

hook.Add("EntityFireBullets", "MRTF_InfiniteAmmo_NoDecrease", function(ent, data)
    if not ent:IsPlayer() then return end
    if not infiniteAmmo[ent] then return end

    timer.Simple(0, function()
        if not IsValid(ent) then return end

        local wep = ent:GetActiveWeapon()
        if not IsValid(wep) then return end

        -- CLIP KİLİT
        if wep:Clip1() >= 0 then
            wep:SetClip1(wep:GetMaxClip1())
        end

        -- SECONDARY CLIP (varsA)
        if wep:Clip2() and wep:Clip2() >= 0 then
            wep:SetClip2(wep:GetMaxClip2())
        end
    end)
end)

hook.Add("PlayerDisconnected", "CleanAutoAmmo", function(ply)
    infiniteAmmo[ply] = nil
    autoAmmo[ply] = nil
    cheatsEnabled[ply] = nil
end)
