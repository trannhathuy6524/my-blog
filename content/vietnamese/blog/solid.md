---
title: "SOLID cho sinh viên: 5 nguyên tắc vàng để code Java 'sạch' hơn"
date: 2025-10-11T12:00:00+07:00
draft: false
image: "/images/solid-principles-java.png"
description: "Giải thích 5 nguyên tắc SOLID một cách đơn giản và dễ hiểu qua các ví dụ Java gần gũi, giúp sinh viên viết code OOP tốt hơn."
categories: ["Java", "Lập trình"]
author: "Một Lập Trình Viên Trẻ"
tags: ["java", "oop", "solid", "clean-code", "sinh-vien-it"]
---

## Code chạy được, nhưng đã "tốt" chưa?

Chào mọi người, hồi năm hai, mình từng rất tự hào khi code xong một chương trình quản lý sinh viên bằng Java. Nó chạy được, thêm, xóa, sửa ngon lành. Nhưng khi thầy giáo yêu cầu thêm một chức năng mới, ví dụ như "xuất danh sách ra file PDF" thay vì chỉ là file text, mình đã phải sửa lại rất nhiều file, và lỡ tay làm hỏng vài chức năng cũ. 😫

Đó là lúc mình nhận ra: code **chạy được** không có nghĩa là code **tốt**. Code tốt là code phải dễ bảo trì, dễ mở rộng và dễ đọc. Và để làm được điều đó, chúng ta cần tới 5 nguyên tắc vàng trong Lập trình Hướng đối tượng (OOP) mang tên **SOLID**.

Trong bài này, mình sẽ giải thích 5 nguyên tắc này theo cách đơn giản nhất có thể nhé!

---

### 1. (S) - Single Responsibility Principle (Nguyên tắc Đơn trách nhiệm)

> **Nội dung:** Một class chỉ nên giữ một trách nhiệm duy nhất.

**Tưởng tượng đơn giản:** Nó giống như một con dao làm bếp so với một con dao đa năng của Thụy Sĩ. Con dao làm bếp chỉ có một nhiệm vụ: cắt. Nó làm việc đó rất tốt. Con dao đa năng có thể làm 10 việc, nhưng cuối cùng bạn sẽ không dùng nó để thái thịt vì nó không đủ chuyên dụng. Một class cũng vậy, chỉ nên làm tốt một việc duy nhất.

**Ví dụ code "chưa tốt":**
```java
// Class này vừa quản lý thông tin sinh viên, vừa tự lưu mình vào database
class SinhVien {
    private String ten;
    private String maSV;

    public void luuVaoDatabase() {
        // Code kết nối database và lưu sinh viên...
        // -> Class này đang làm 2 việc!
    }
}
```
Code "tốt" hơn: Chúng ta tách nó ra làm hai.
```java
// Class này chỉ lo quản lý thông tin
class SinhVien {
    private String ten;
    private String maSV;
    // getters, setters...
}

// Class này chỉ có một nhiệm vụ là lưu trữ SinhVien
class SinhVienRepository {
    public void save(SinhVien sv) {
        // Code kết nối database và lưu sinh viên...
    }
}
```
Bây giờ, nếu bạn muốn đổi từ lưu vào MySQL sang MongoDB, bạn chỉ cần sửa class SinhVienRepository mà không cần đụng tới class SinhVien.

### 2. (O) - Open/Closed Principle (Nguyên tắc Đóng/Mở)
Nội dung: Có thể thoải mái mở rộng một class, nhưng không được sửa đổi bên trong class đó.

Tưởng tượng đơn giản: Giống như điện thoại của bạn có cổng sạc USB-C. Bạn có thể cắm thêm tai nghe, sạc dự phòng, đầu đọc thẻ nhớ... (mở rộng chức năng) mà không cần phải mổ điện thoại ra để hàn thêm dây (sửa đổi bên trong).

Ví dụ code "chưa tốt":
```java
// Mỗi lần có loại khách hàng mới, ta lại phải sửa hàm này
class TinhGiamGia {
    public double tinhToan(String loaiKhachHang, double tongTien) {
        if (loaiKhachHang.equals("VIP")) {
            return tongTien * 0.2; // Giảm 20%
        }
        if (loaiKhachHang.equals("THUONG")) {
            return tongTien * 0.1; // Giảm 10%
        }
        return tongTien;
    }
}
```
Thêm khách "VANG", "BAC", "DONG" nữa thì cái if-else này sẽ dài vô tận. Rất dễ gây lỗi!

Code "tốt" hơn: Dùng interface.
```java
// 1. Tạo một "tiêu chuẩn" chung
interface IChinhSachGiamGia {
    double tinhGiamGia(double tongTien);
}

// 2. Mở rộng cho từng loại khách hàng
class GiamGiaVIP implements IChinhSachGiamGia {
    public double tinhGiamGia(double tongTien) { return tongTien * 0.2; }
}

class GiamGiaThuong implements IChinhSachGiamGia {
    public double tinhGiamGia(double tongTien) { return tongTien * 0.1; }
}

// Giờ thêm khách hàng VÀNG? Chỉ cần tạo class mới, không cần sửa code cũ!
class GiamGiaVang implements IChinhSachGiamGia {
    public double tinhGiamGia(double tongTien) { return tongTien * 0.15; }
}
```
### 3. (L) - Liskov Substitution Principle (Nguyên tắc Thay thế Liskov)
Nội dung: Các đối tượng của class con có thể thay thế cho các đối tượng của class cha mà không làm thay đổi tính đúng đắn của chương trình.

Tưởng tượng đơn giản: Bạn có một cái điều khiển TV (class cha). Nó hoạt động tốt với TV thường. Khi bạn mua một cái Smart TV (class con), cái điều khiển đó vẫn phải thực hiện được các chức năng cơ bản (tăng giảm âm lượng, bật tắt) một cách đúng đắn. Sẽ rất kỳ cục nếu nút "Tắt" trên điều khiển lại làm TV... mở YouTube.

Ví dụ code "chưa tốt": Vấn đề kinh điển "Hình chữ nhật và Hình vuông".
```java
class HinhChuNhat {
    protected int chieuRong;
    protected int chieuDai;

    public void setChieuRong(int width) { this.chieuRong = width; }
    public void setChieuDai(int height) { this.chieuDai = height; }
    public int tinhDienTich() { return chieuRong * chieuDai; }
}

// Hình vuông LÀ MỘT HÌNH CHỮ NHẬT? Có vẻ đúng, nhưng...
class HinhVuong extends HinhChuNhat {
    // Để đảm bảo 2 cạnh bằng nhau, ta phải "ép" hành vi
    @Override
    public void setChieuRong(int width) {
        super.setChieuRong(width);
        super.setChieuDai(width);
    }
    @Override
    public void setChieuDai(int height) {
        super.setChieuRong(height);
        super.setChieuDai(height);
    }
}
// Vấn đề:
HinhChuNhat hcn = new HinhVuong();
hcn.setChieuRong(5);
hcn.setChieuDai(10);
// Ta mong đợi diện tích là 50, nhưng thực tế nó là 100! -> Chương trình chạy sai!
```
Class HinhVuong không thể thay thế cho HinhChuNhat một cách an toàn.

Cách sửa: Không cho HinhVuong kế thừa HinhChuNhat. Hãy tạo một interface chung như IHinhHoc.

### 4. (I) - Interface Segregation Principle (Nguyên tắc Phân tách Interface)
Nội dung: Thay vì dùng một interface lớn, ta nên tách thành nhiều interface nhỏ, chuyên biệt hơn.

Tưởng tượng đơn giản: Thay vì đưa cho khách hàng một menu nhà hàng "khổng lồ" bao gồm cả món sáng, trưa, tối, tráng miệng, đồ uống... thì hãy đưa cho họ menu bữa sáng nếu họ đến vào buổi sáng. Đừng bắt một client phải "biết" đến những phương thức mà nó không dùng.

Ví dụ code "chưa tốt":
```java
interface IWorker {
    void work();
    void eat();
}

class Human implements IWorker {
    public void work() { /* làm việc */ }
    public void eat() { /* ăn uống */ }
}

// Robot thì không cần ăn! Nhưng vẫn phải implement hàm eat()
class Robot implements IWorker {
    public void work() { /* làm việc */ }
    public void eat() { /* không làm gì cả, lãng phí! */ }
}
```
Code "tốt" hơn: Tách interface ra.
```java
interface IWorkable {
    void work();
}

interface IFeedable {
    void eat();
}

class Human implements IWorkable, IFeedable {
    // ...
}

class Robot implements IWorkable { // Chỉ làm việc, không cần ăn!
    // ...
}
```
### 5. (D) - Dependency Inversion Principle (Nguyên tắc Đảo ngược Phụ thuộc)
Nội dung: Các module cấp cao không nên phụ thuộc vào các module cấp thấp. Cả hai nên phụ thuộc vào một "abstraction" (interface hoặc abstract class).

Tưởng tượng đơn giản: Cái đèn bàn của bạn không được hàn chết vào dây điện trong tường. Thay vào đó, nó có một cái phích cắm (abstraction), và bạn cắm nó vào ổ điện (abstraction). Nhờ vậy, bạn có thể cắm bất cứ thiết bị nào (laptop, sạc điện thoại) vào ổ điện, và cũng có thể cắm cái đèn đó vào bất kỳ ổ điện nào.

Ví dụ code "chưa tốt": Phụ thuộc trực tiếp.
```java
// Module cấp thấp
class EmailService {
    public void sendEmail() {
        System.out.println("Gửi email...");
    }
}

// Module cấp cao, phụ thuộc trực tiếp vào EmailService
class ThongBao {
    private EmailService emailService;

    public ThongBao() {
        this.emailService = new EmailService(); // Bị "hàn chết" vào EmailService!
    }

    public void guiThongBao() {
        emailService.sendEmail();
    }
}
// Giờ muốn đổi sang gửi SMS? Phải sửa lại class ThongBao.
```
Code "tốt" hơn: Dùng "ổ cắm" (interface).
```java
// 1. Tạo ra "ổ cắm"
interface IMessageService {
    void sendMessage();
}

// 2. Tạo các "thiết bị" cắm vào
class EmailService implements IMessageService {
    public void sendMessage() { System.out.println("Gửi email..."); }
}

class SmsService implements IMessageService {
    public void sendMessage() { System.out.println("Gửi SMS..."); }
}

// 3. Class cấp cao giờ chỉ cần "ổ cắm"
class ThongBao {
    private IMessageService service;

    // "Cắm" thiết bị vào qua constructor (Dependency Injection)
    public ThongBao(IMessageService service) {
        this.service = service;
    }

    public void guiThongBao() {
        service.sendMessage();
    }
}
// Giờ muốn dùng cái nào thì cắm cái đó vào:
// ThongBao tbEmail = new ThongBao(new EmailService());
// ThongBao tbSms = new ThongBao(new SmsService());
```
## Bài học mình rút ra
SOLID không phải là luật, nó là kim chỉ nam: Nó giúp chúng ta suy nghĩ và thiết kế code một cách có hệ thống hơn.

Code dễ thở hơn: Áp dụng SOLID giúp code của bạn linh hoạt, ít "giòn" hơn khi có thay đổi. Thêm chức năng mới không còn là một cơn ác mộng.

Là điểm cộng khi đi phỏng vấn: Hiểu và giải thích được SOLID cho thấy bạn không chỉ biết code, mà còn biết cách viết code "sạch" và chuyên nghiệp.

## Kết luận
SOLID ban đầu có vẻ hơi trừu tượng và phức tạp, nhưng đừng lo. Cứ mỗi lần bạn tạo một class hay một hàm mới, hãy thử dừng lại một giây và tự hỏi: "Nó có đang làm quá nhiều việc không? (S)", "Nếu sau này cần thêm chức năng, mình có phải sửa lại class này không? (O)".

Dần dần, việc thiết kế theo SOLID sẽ trở thành một phản xạ tự nhiên, và bạn sẽ thấy kỹ năng lập trình của mình lên một tầm cao mới. Chúc các bạn học tốt!