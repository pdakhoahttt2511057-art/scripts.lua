-- Máy tính cơ bản cho GameGuardian
local phepTinhList = {"Cộng (+)", "Trừ (-)", "Nhân (*)", "Chia (/)"}

while true do
    -- Tạo hộp thoại nhập liệu trực quan
    local input = gg.prompt(
        {
            "Nhập số thứ nhất:",
            "Chọn phép tính [1: +, 2: -, 3: *, 4: /]:",
            "Nhập số thứ hai:",
            "Thoát máy tính"
        },
        {0, 1, 0, false},
        {"number", "number", "number", "checkbox"}
    )

    -- Nếu nhấn Hủy (Cancel) hoặc tích chọn Thoát
    if input == nil or input[4] == true then
        gg.toast("Đã đóng máy tính")
        break
    end

    local a = tonumber(input[1])
    local op = tonumber(input[2])
    local b = tonumber(input[3])

    if not a or not b then
        gg.alert("⚠️ Vui lòng nhập số hợp lệ!")
    else
        local ketQua = 0
        local kyHieu = ""
        local hopLe = true

        if op == 1 then
            ketQua = a + b
            kyHieu = "+"
        elseif op == 2 then
            ketQua = a - b
            kyHieu = "-"
        elseif op == 3 then
            ketQua = a * b
            kyHieu = "*"
        elseif op == 4 then
            if b == 0 then
                gg.alert("❌ Lỗi: Không thể chia cho 0!")
                hopLe = false
            else
                ketQua = a / b
                kyHieu = "/"
            end
        else
            gg.alert("⚠️ Vui lòng chọn phép tính từ 1 đến 4!")
            hopLe = false
        end

        if hopLe then
            local thongBao = string.format("Phép tính: %g %s %g\nKết quả = %g", a, kyHieu, b, ketQua)
            local luaChon = gg.alert(thongBao, "Tính tiếp", "Sao chép KQ", "Thoát")
            
            if luaChon == 2 then
                gg.copyText(tostring(ketQua))
                gg.toast("Đã sao chép: " .. tostring(ketQua))
            elseif luaChon == 3 then
                break
            end
        end
    end
end