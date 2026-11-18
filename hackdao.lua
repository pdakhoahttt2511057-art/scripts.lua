local ranges = gg.getRangesList('libcocos2dcpp.so')
if #ranges == 0 then
    gg.alert("❌ Không tìm thấy game (libcocos2dcpp.so)!")
    os.exit()
end

local so = ranges[1].start
local py = 0x263DB60
local id = 0
local show = true

function loadvalue()
    gg.loadResults({{ address = so + py, flags = gg.TYPE_DWORD }})
end

function setvalue(address, flags, value)
    gg.setValues({{ address = address, flags = flags, value = value }})
end

function Menu()
    local choice = gg.choice({"TCS (Tăng chỉ số)", "Auto Vượt Đảo", "Mở Ô Pet", "Thoát"}, nil, "MENU VƯỢT ĐẢO ⚡")
    if choice == 1 then TCS()
    elseif choice == 2 then Auto()
    elseif choice == 3 then MoOPet()
    elseif choice == 4 then Exit()
    end
    show = false
end

function MoOPet()
    local add = so + 0x79D434EE1880
    setvalue(add, gg.TYPE_DWORD, 999)
    gg.toast("✅ Mở Ô Pet thành công!")
end

function Auto()
    loadvalue()
    local result = gg.getResults(1)
    if #result == 0 then
        gg.alert("⚠️ Không nhận diện được tiến độ!")
        return
    end

    local val = result[1].value
    local name = "???"
    id = 0

    if val > 30 and val < 230 then name, id = "Blue Mushroom", 1
    elseif val > 280 and val < 480 then name, id = "Hala Island", 2
    elseif val > 530 and val < 730 then name, id = "Polar Day", 3
    end

    local choice = gg.choice({"[ Auto ] " .. name .. " (Khó)", "Trở về"}, nil, "Tự động phát hiện đảo 👁️‍🗨️")
    if choice == 1 then
        if id == 1 then vuotMoc(30, 39, 229, 230)
        elseif id == 2 then vuotMoc(280, 289, 479, 480)
        elseif id == 3 then vuotMoc(530, 539, 729, 730)
        else gg.alert("⚠️ Hãy vào đảo trước!") end
    elseif choice == 2 then
        Menu()
    end
end

function vuotMoc(minVal, bossVal, preEndVal, endVal)
    TCS()
    loadvalue()
    while true do
        local result = gg.getResults(1)
        if #result == 0 then break end
        local v = result[1].value

        if v > minVal and v < bossVal then
            result[1].value = bossVal
            gg.setValues(result)
            gg.sleep(120)
        elseif v > bossVal and v < preEndVal then
            result[1].value = preEndVal
            gg.setValues(result)
            gg.toast("⚔️ Đang Kill Boss...")
            gg.sleep(120)
        elseif v == endVal then
            gg.sleep(600)
            HOPNV()
            break
        end
        gg.sleep(100)
    end
end

function TCS()
    gg.clearResults()
    gg.setRanges(gg.REGION_ANONYMOUS | gg.REGION_C_ALLOC)
    gg.searchNumber("1065353219;3::25", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1, 1)
    local p = gg.getResults(1)
    if #p == 0 then
        gg.toast("⚠️ Không tìm thấy địa chỉ chỉ số!")
        return
    end

    local base = p[1].address
    gg.setValues({
        { address = base + 12, flags = gg.TYPE_DWORD, value = 999999999 },
        { address = base + 8,  flags = gg.TYPE_DWORD, value = 999999999 },
        { address = base + 20, flags = gg.TYPE_DWORD, value = 999999999 },
        { address = base + 16, flags = gg.TYPE_DWORD, value = 999999999 },
        { address = base + 32, flags = gg.TYPE_DWORD, value = 500 },
        { address = base + 36, flags = gg.TYPE_DWORD, value = 999999999 }
    })
    gg.clearResults()
    gg.toast("💪 Đã tăng chỉ số!")
end

function HOPNV()
    local old = gg.getRanges()
    
    gg.clearResults()
    gg.setRanges(gg.REGION_C_ALLOC)
    gg.searchNumber("90010110;1~20::5", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1, 100)
    gg.refineNumber("1~20", gg.TYPE_DWORD)
    if gg.getResultsCount() > 0 then
        gg.getResults(gg.getResultsCount())
        gg.editAll("80", gg.TYPE_DWORD)
        gg.toast("✅ Awaken Gift")
    end
    
    gg.clearResults()
    gg.searchNumber("80061;90061;90010110;1~20::2000", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1, 1)
    gg.refineNumber("1~20", gg.TYPE_DWORD)
    if gg.getResultsCount() > 0 then
        gg.getResults(gg.getResultsCount())
        gg.editAll("20", gg.TYPE_DWORD)
        gg.toast("📦 Đã nhận quà")
    end
    
    gg.setRanges(old)
    gg.clearResults()
    loadvalue()
end

function Exit()
    gg.clearList()
    gg.clearResults()
    print("Cảm ơn đã sử dụng script! (zl0382805094)")
    os.exit()
end

while true do
    if gg.isVisible(true) then
        show = true
        gg.setVisible(false)
    end
    if show then
        Menu()
    end
    gg.sleep(100)
end