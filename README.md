# Nexus AutoClicker Pro

Ứng dụng auto click native dành cho **Windows 10/11 64-bit**. Repository này chứa tệp chạy EXE, mã nguồn C, các tệp định nghĩa thư viện Windows cần cho quá trình link và script build.

> **Tình trạng kiểm thử:** EXE đã được kiểm tra cấu trúc PE32+ x64 và gói ZIP đã được kiểm tra tính toàn vẹn. Chưa có phiên chạy GUI trên máy Windows thật trong môi trường đóng gói này, vì vậy chưa xác nhận được CPS thực tế, độ ổn định trên mọi máy hoặc khả năng tương thích với mọi ứng dụng đích. Hãy quét tệp bằng Microsoft Defender trước khi chạy.

## Tải xuống

- **[NexusAutoClicker_Pro.exe](./NexusAutoClicker_Pro.exe)** — ứng dụng Windows 64-bit, tải trực tiếp.
- **[NexusAutoClicker_Pro.zip](./NexusAutoClicker_Pro.zip)** — gói đầy đủ gồm EXE, mã nguồn và tệp build.
- [Mã nguồn chính: NexusAutoClicker.c](./NexusAutoClicker.c)

## Tính năng có trong mã nguồn

- Chọn nút chuột: trái, phải hoặc giữa.
- Chọn số lần click trong mỗi chu kỳ: 1, 2 hoặc 3.
- Chọn số chu kỳ lặp hoặc lặp liên tục đến khi người dùng dừng.
- Cấu hình tốc độ từ **1 đến 2.000 click/giây (CPS)**.
- Click tại vị trí con trỏ hiện tại hoặc tại tọa độ cố định X/Y.
- Nút **Chọn vị trí...** cho phép chọn tọa độ trên màn hình.
- Phím nóng mặc định để bật/tắt: phím dấu huyền/backtick (`).
- **F7** gửi lệnh dừng; **F8** lấy vị trí con trỏ hiện tại và chuyển sang chế độ tọa độ cố định.
- Hộp thoại cài phím nóng hỗ trợ phím ` hoặc F1–F12, kèm Ctrl/Alt/Shift.
- Giao diện Windows native; không cần cài Python hay .NET runtime riêng.

### Cơ chế căn thời gian

Luồng click sử dụng QueryPerformanceCounter để theo dõi thời gian hiệu năng cao. Ứng dụng thử tạo high-resolution waitable timer; nếu không tạo được, nó chuyển sang cơ chế dự phòng dùng timeBeginPeriod(1) và chờ ngắn. Luồng click được đặt ưu tiên Above Normal khi chạy.

**Giới hạn quan trọng:** 2.000 CPS là mức tối đa có thể nhập trong giao diện, không phải cam kết rằng Windows hoặc ứng dụng đích sẽ nhận đủ 2.000 click mỗi giây. Tốc độ thực tế phụ thuộc CPU, bộ lập lịch Windows, timer, quyền tiến trình và cách ứng dụng đích xử lý sự kiện. Hãy thử từ mức thấp và tăng dần đến mức ổn định. Tốc độ cao có thể làm ứng dụng đích phản hồi kém hoặc bỏ qua một số sự kiện.

## Hướng dẫn sử dụng

1. Tải EXE hoặc ZIP từ phần **Tải xuống**.
2. Nếu tải ZIP, giải nén toàn bộ vào một thư mục riêng.
3. Chạy `NexusAutoClicker_Pro.exe`. Nếu Windows hiển thị cảnh báo, hãy kiểm tra nguồn tải và quét tệp trước khi chọn chạy.
4. Chọn **Nút chuột** và **Kiểu click**.
5. Chọn **Lặp số lần** rồi nhập số chu kỳ, hoặc chọn **Lặp đến khi dừng**.
6. Nhập tốc độ trong khoảng 1–2.000 CPS.
7. Chọn **Vị trí hiện tại** hoặc **Tọa độ cố định**. Có thể nhấn F8 để lấy vị trí con trỏ hiện tại, hoặc nhấn **Chọn vị trí...** rồi click vị trí cần chọn.
8. Nhấn **Bắt đầu** hoặc phím ` để bắt đầu. Nhấn lại ` hoặc nhấn F7 để dừng.
9. Trước khi dùng trong ứng dụng quan trọng, hãy thử ở tốc độ thấp và kiểm tra kết quả.

### Phím nóng mặc định

| Phím | Tác dụng |
|---|---|
| ` (backtick) | Bật/tắt click |
| F7 | Dừng |
| F8 | Lấy tọa độ con trỏ hiện tại và chọn chế độ tọa độ cố định |

Có thể mở **Cài đặt phím nóng** để đổi phím bật/tắt. F7 và F8 được dành riêng cho thao tác dừng và lấy tọa độ khi không có phím bổ trợ.

## Ghi và phát lại thao tác chuột

Giao diện có nút **Record & Playback**. Phần ghi sử dụng low-level mouse hook và bộ đệm tối đa 60.000 sự kiện. Tuy nhiên, phần phát lại hiện **chưa được xác minh trên Windows thực tế**; trong mã hiện tại, mỗi sự kiện ghi được gửi qua SendInput hai lần. Vì vậy, phát lại có thể tạo sự kiện lặp hoặc hành vi không mong muốn. Hãy coi đây là tính năng thử nghiệm và không dùng cho thao tác quan trọng cho đến khi được sửa và kiểm thử riêng.

## Cấu trúc repository

| Tệp | Mục đích |
|---|---|
| `NexusAutoClicker_Pro.exe` | Bản chạy Windows 10/11 x64 |
| `NexusAutoClicker.c` | Mã nguồn C sử dụng Win32 API |
| `build_exe.bat` | Script biên dịch và link trên Windows |
| `kernel32.def` | Danh sách import từ KERNEL32.dll |
| `user32.def` | Danh sách import từ USER32.dll |
| `winmm.def` | Danh sách import từ WINMM.dll |
| `SHA256.txt` | Hash SHA-256 của EXE trong gói gốc |
| `SHA256SUMS.txt` | Hash SHA-256 của các tệp phát hành ở repository |
| `NexusAutoClicker_Pro.zip` | Gói ZIP đầy đủ đã kiểm tra cấu trúc |

## Biên dịch từ mã nguồn

### Yêu cầu

- Windows 10/11 64-bit.
- LLVM/Clang có lệnh `clang` và `lld-link` trong biến môi trường `PATH`.

### Các bước

1. Tải repository về máy hoặc giải nén `NexusAutoClicker_Pro.zip`.
2. Mở Command Prompt trong thư mục có `build_exe.bat`.
3. Chạy:

```bat
build_exe.bat
```

Script biên dịch `NexusAutoClicker.c` cho target `x86_64-pc-windows-msvc`, sau đó tạo import libraries từ các tệp `.def` và link thành ứng dụng GUI `NexusAutoClicker_Pro.exe`.

Các tệp `.obj`, `.lib` và DLL stub sinh ra trong quá trình build là tệp trung gian; không cần phát hành kèm EXE đã build.

## Kiểm tra SHA-256

Trên Windows PowerShell:

```powershell
Get-FileHash .\NexusAutoClicker_Pro.exe -Algorithm SHA256
Get-FileHash .\NexusAutoClicker_Pro.zip -Algorithm SHA256
```

Đối chiếu kết quả với `SHA256SUMS.txt`. Hash chỉ giúp xác nhận tệp không bị thay đổi so với bản đã công bố; nó **không** tự chứng minh tệp an toàn hoặc không có lỗi.

## Ghi chú an toàn và giới hạn

- Chỉ sử dụng trong ứng dụng và môi trường mà bạn được phép tự động hóa.
- Một số ứng dụng, đặc biệt ứng dụng chạy với quyền cao hơn, game hoặc phần mềm có cơ chế chống tự động hóa, có thể bỏ qua hoặc chặn sự kiện giả lập.
- Không có cam kết tương thích với mọi phần mềm hoặc hệ thống.
- Chưa có số đo benchmark CPS được xác nhận trên máy Windows thật trong quá trình đóng gói.
- Repository hiện chưa kèm tệp LICENSE. Không nên mặc định rằng mã nguồn được cấp phép sử dụng, sửa đổi hoặc phân phối lại nếu chưa có sự cho phép của chủ sở hữu.

## Báo lỗi

Khi báo lỗi, hãy ghi phiên bản Windows, kiến trúc hệ thống, thao tác tái hiện, tốc độ CPS đã chọn và thông báo lỗi nguyên văn. Không gửi thông tin cá nhân hoặc dữ liệu nhạy cảm.
