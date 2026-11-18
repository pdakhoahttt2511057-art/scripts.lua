-- Máy tính cơ bản bằng Lua (Console)
local function tinhToan(a, phepTinh, b)
    if phepTinh == "+" then
        return a + b
    elseif phepTinh == "-" then
        return a - b
    elseif phepTinh == "*" or phepTinh == "x" then
        return a * b
    elseif phepTinh == "/" then
        if b == 0 then
            return nil, "Lỗi: Không thể chia cho 0!"
        end
        return a / b
    elseif phepTinh == "%" then
        if b == 0 then
            return nil, "Lỗi: Không thể chia lấy dư cho 0!"
        end
        return a % b
    elseif phepTinh == "^" then
        return a ^ b
    else
        return nil, "Lỗi: Phép tính không hợp lệ!"
    end
end

print("=== MAY TINH CO BAN LUA ===")
print("Ho tro cac phep tinh: +  -  *  /  %  ^")

while true do
    io.write("\nNhap so thu nhat (hoac go 'q' de thoat): ")
    local inputA = io.read()
    if inputA == "q" or inputA == "Q" then
        print("Da thoat chuong trinh.")
        break
    end

    local a = tonumber(inputA)
    if not a then
        print("Vui long nhap mot so hop le!")
    else
        io.write("Nhap phep tinh (+, -, *, /, %, ^): ")
        local op = io.read()

        io.write("Nhap so thu hai: ")
        local b = tonumber(io.read())

        if not b then
            print("So thu hai khong hop le!")
        else
            local ketQua, loi = tinhToan(a, op, b)
            if loi then
                print(loi)
            else
                print(string.format("Ket qua: %g %s %g = %g", a, op, b, ketQua))
            end
        end
    end
end
