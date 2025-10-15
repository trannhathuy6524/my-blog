---
title: "OOP không khó: Giải mã 4 'trụ cột' của Lập trình Hướng đối tượng trong Java"
date: 2025-10-11T13:45:00+07:00
draft: false
image: "/images/oop-pillars-java.png"
description: "Giải thích 4 tính chất của Lập trình Hướng đối tượng (Đóng gói, Kế thừa, Đa hình, Trừu tượng) bằng ví dụ Java siêu đơn giản cho sinh viên."
categories: ["Java", "Lập trình"]
author: "Một Lập Trình Viên Trẻ"
tags: ["java", "oop", "clean-code", "sinh-vien-it"]
---

## OOP: Không chỉ là "code có class"

Khi mới học Java, chúng ta thường được dạy về `class` và `object`. Chúng ta học cách tạo ra một đối tượng `SinhVien` từ một lớp `SinhVien`. Nhưng Lập trình Hướng đối tượng (OOP) không chỉ dừng lại ở đó. Sức mạnh thật sự của nó nằm ở 4 "trụ cột" hay 4 tính chất cốt lõi.

Hiểu được 4 tính chất này giống như việc bạn có được 4 "siêu năng lực" để xây dựng những chương trình lớn, phức tạp nhưng vẫn dễ quản lý và mở rộng.



Hãy cùng "bẻ khóa" từng cái một nhé!

---

### 1. Tính Đóng gói (Encapsulation) - "Chiếc hộp an toàn" 💊

> **Ý tưởng:** Che giấu thông tin và những xử lý phức tạp bên trong một đối tượng, và chỉ cung cấp một giao diện (các phương thức public) đơn giản để tương tác với nó.

**Tưởng tượng đơn giản:** Hãy nghĩ về chiếc điều khiển TV. Bạn chỉ cần biết nút "tăng âm lượng", "giảm âm lượng", "chuyển kênh". Bạn không cần biết (và cũng không nên biết) vi mạch điện tử bên trong hoạt động ra sao. Mọi thứ phức tạp đã được "đóng gói" an toàn bên trong.

Trong Java, chúng ta thực hiện điều này bằng cách:
-   Để các thuộc tính (dữ liệu) ở chế độ `private`.
-   Tạo ra các phương thức `public` (getter và setter) để truy cập và thay đổi các thuộc-tính đó một cách có kiểm soát.

**Ví dụ:**
```java
public class TaiKhoanNganHang {
    // 1. Dữ liệu được che giấu (private)
    private double soDu;
    private String soTaiKhoan;

    public TaiKhoanNganHang(String stk, double banDau) {
        this.soTaiKhoan = stk;
        // Đảm bảo số dư ban đầu luôn hợp lệ
        if (banDau > 0) {
            this.soDu = banDau;
        } else {
            this.soDu = 0;
        }
    }

    // 2. Cung cấp giao diện public an toàn để tương tác
    public double getSoDu() {
        return this.soDu;
    }

    public void napTien(double soTien) {
        if (soTien > 0) {
            this.soDu += soTien;
            System.out.println("Nạp thành công: " + soTien);
        } else {
            System.out.println("Số tiền nạp không hợp lệ!");
        }
    }

    public void rutTien(double soTien) {
        if (soTien > 0 && soTien <= this.soDu) {
            this.soDu -= soTien;
            System.out.println("Rút thành công: " + soTien);
        } else {
            System.out.println("Giao dịch không thành công!");
        }
    }
}
```
Lợi ích: Dữ liệu soDu được bảo vệ. Người dùng không thể tự ý gán taiKhoan.soDu = -1000000;. Mọi thao tác đều phải thông qua các phương thức napTien và rutTien, nơi chúng ta đã đặt các logic kiểm tra an toàn.

### 2. Tính Kế thừa (Inheritance) - "Con hơn cha là nhà có phúc" 👨‍👧‍👦
>Ý tưởng: Cho phép một lớp (class con) có thể thừa hưởng lại các thuộc tính và phương thức của một lớp khác (class cha).

Tưởng tượng đơn giản: Tất cả các loài động vật đều có chung các đặc điểm như cân nặng, chiều cao và hành động ăn(), ngủ(). Thay vì định nghĩa lại những thứ này cho từng con vật, ta tạo một lớp cha DongVat. Sau đó, các lớp Cho, Meo chỉ cần kế thừa từ DongVat là đã có sẵn các đặc điểm chung đó, và chúng chỉ cần định nghĩa thêm những gì riêng biệt (ví dụ: Cho thì có sua(), Meo thì có keu()).

Ví dụ:
```java
// Lớp cha có các thuộc tính và phương thức chung
public class NhanVien {
    protected String ten;
    protected double luongCoBan;

    public NhanVien(String ten, double luong) {
        this.ten = ten;
        this.luongCoBan = luong;
    }

    public void tinhLuong() {
        System.out.println("Lương của " + ten + " là: " + luongCoBan);
    }
}

// Lớp con kế thừa từ NhanVien bằng từ khóa 'extends'
public class LapTrinhVien extends NhanVien {
    private int soGioLamThem;

    public LapTrinhVien(String ten, double luong, int gioLamThem) {
        // Gọi constructor của lớp cha để khởi tạo ten và luongCoBan
        super(ten, luong);
        this.soGioLamThem = gioLamThem;
    }

    // Ghi đè (Override) phương thức của lớp cha để có cách tính lương riêng
    @Override
    public void tinhLuong() {
        double luongThucTe = luongCoBan + (soGioLamThem * 200000);
        System.out.println("Lương của lập trình viên " + ten + " là: " + luongThucTe);
    }
}
```
Lợi ích: Tái sử dụng code, tránh lặp lại, tạo ra một hệ thống phân cấp logic và dễ quản lý.

### 3. Tính Đa hình (Polymorphism) - "Một ứng vạn biến" 🎭
>Ý tưởng: Một đối tượng có thể thể hiện dưới nhiều hình thái khác nhau. Hay nói cách khác, cùng một hành động (tên phương thức) nhưng các đối tượng khác nhau sẽ có cách thực thi khác nhau.

Tưởng tượng đơn giản: Hành động "kêu". Con chó sẽ "gâu gâu", con mèo sẽ "meo meo", con vịt sẽ "quạc quạc". Cùng là hành động keu(), nhưng kết quả lại khác nhau tùy vào đối tượng là con gì.

Tính đa hình trong Java thường được thể hiện qua Overriding (ghi đè phương thức - như ví dụ ở phần Kế thừa) và Overloading (nạp chồng phương thức).

Ví dụ về sức mạnh của đa hình:
```java
public class QuanLyNhanSu {
    public static void main(String[] args) {
        // Một tham chiếu kiểu NhanVien...
        NhanVien nv1 = new NhanVien("An", 1000); 
        // ...có thể trỏ tới một đối tượng LapTrinhVien
        NhanVien ltv1 = new LapTrinhVien("Bình", 2000, 10);

        // Cùng gọi phương thức tinhLuong()
        nv1.tinhLuong(); // Output: Lương của An là: 1000.0
        ltv1.tinhLuong(); // Output: Lương của lập trình viên Bình là: 4000000.0

        // Java đủ thông minh để biết cần gọi phương thức của đối tượng nào
        // (NhanVien hay LapTrinhVien) tại thời điểm chạy.
    }
}
```
Lợi ích: Giúp code trở nên linh hoạt và dễ mở rộng. Bạn có thể viết một hàm xử lý một danh sách các NhanVien mà không cần quan tâm trong đó có bao nhiêu loại nhân viên khác nhau.

### 4. Tính Trừu tượng (Abstraction) - "Chỉ cần biết cái chung, bỏ qua chi tiết" ☁️
>Ý tưởng: Che giấu sự phức tạp không cần thiết và chỉ đưa ra những đặc điểm, chức năng cốt lõi của một đối tượng.

Tưởng tượng đơn giản: Khi bạn lái xe hơi, bạn chỉ cần biết về vô-lăng, chân ga, chân phanh. Bạn không cần biết piston di chuyển ra sao, xăng được đốt như thế nào. Giao diện lái xe đã được "trừu tượng hóa" để ai cũng có thể sử dụng.

Trong Java, tính trừu tượng được thể hiện qua Abstract Class và Interface.

- Abstract Class: Là một lớp "chưa hoàn thiện", có thể chứa cả phương thức có thân hàm và phương thức trừu tượng (chưa có thân hàm).

- Interface: Là một bản "hợp đồng" 100% trừu tượng, chỉ chứa các phương thức trừu tượng. Bất kỳ lớp nào "ký" vào hợp đồng này (implements interface) đều phải định nghĩa lại tất cả các phương thức đó.

Ví dụ về Interface:
```java
// Hợp đồng quy định bất kỳ hình nào cũng phải có khả năng tính chu vi và diện tích
public interface IShape {
    void tinhChuVi();
    void tinhDienTich();
}

// Lớp HinhTron ký vào hợp đồng và phải thực thi nó
public class HinhTron implements IShape {
    private double banKinh;

    @Override
    public void tinhChuVi() {
        // code tính chu vi hình tròn...
    }

    @Override
    public void tinhDienTich() {
        // code tính diện tích hình tròn...
    }
}
```
Lợi ích: Giảm độ phức tạp, tăng tính linh hoạt và giúp thiết lập một "bộ quy tắc chung" cho các lớp có liên quan.

## Kết luận

Bốn tính chất này không hoạt động riêng lẻ, chúng kết hợp và bổ trợ cho nhau để tạo nên sức mạnh của OOP.

- Đóng gói bảo vệ dữ liệu.

- Kế thừa tái sử dụng code.

- Đa hình tạo ra sự linh hoạt.

- Trừu tượng che giấu sự phức tạp.

Nắm vững 4 "trụ cột" này, bạn không chỉ đang viết code Java, mà bạn đang thiết kế phần mềm một cách chuyên nghiệp. Hãy thử áp dụng chúng vào project tiếp theo của mình nhé!