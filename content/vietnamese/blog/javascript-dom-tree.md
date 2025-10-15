---
title: "JavaScript và DOM: 'Phù phép' cho trang web HTML của bạn"
date: 2025-10-11T14:05:27+07:00
draft: false
image: "/images/javascript-dom-tree.png"
description: "Hướng dẫn cách JavaScript tương tác và thay đổi HTML thông qua DOM. Học cách truy xuất, thay đổi phần tử và xử lý sự kiện click một cách dễ hiểu."
categories: ["JavaScript", "Frontend"]
author: "Một Lập Trình Viên Trẻ"
tags: ["javascript", "dom", "frontend", "html", "sinh-vien-it"]
---

## HTML tĩnh, JavaScript động123

Bạn đã học HTML và CSS. Bạn có thể xây dựng một trang web trông rất đẹp, có bố cục hẳn hoi. Nhưng nó có một vấn đề: nó "chết". Nó là một tài liệu tĩnh. Bạn bấm vào một cái nút, không có gì xảy ra. Bạn điền vào một form, nó cứ trơ trơ ra đó.

Để thổi hồn vào trang web, làm cho nó trở nên sống động và tương tác được, chúng ta cần đến **JavaScript**. Nhưng làm thế nào để JavaScript có thể "nhìn thấy" và "chạm vào" các thẻ HTML mà bạn đã viết?

Câu trả lời nằm ở **DOM**.

> **DOM (Document Object Model)** là một giao diện lập trình, một "bản đồ" dạng cây mà trình duyệt tạo ra từ file HTML của bạn. JavaScript không đọc trực tiếp file HTML, thay vào đó, nó đọc và tương tác với cái "bản đồ" DOM này.

**Tưởng tượng đơn giản:** Hãy nghĩ DOM như một cái cây gia phả của trang web.
-   Gốc cây là `document`.
-   Các cành lớn là `<html>`, `<body>`, `<head>`.
-   Các cành nhỏ hơn và lá là `<h1>`, `<p>`, `<div>`, `<a>`, v.v.

JavaScript, với vai trò là người làm vườn, có thể đi đến bất kỳ cành lá nào trên cái cây này để thay đổi nó: đổi màu lá, thêm một cành mới, hoặc chặt bỏ một cành cũ.



---

### 1. "Đi tìm kho báu" - Truy xuất các phần tử HTML

Trước khi có thể thay đổi một thứ gì đó, bạn phải tìm thấy nó đã. JavaScript cung cấp nhiều cách để "chộp" lấy một phần tử trên cây DOM.

#### Cách truyền thống
-   `getElementById('id-duy-nhat')`: Nhanh và chính xác nhất. Giống như tìm người bằng số Căn cước công dân.
-   `getElementsByClassName('ten-class')`: Tìm tất cả các phần tử có cùng một class.
-   `getElementsByTagName('p')`: Tìm tất cả các phần tử có cùng một tên thẻ (ví dụ: tất cả thẻ `<p>`).

#### Cách hiện đại và mạnh mẽ (Nên dùng!)
-   `querySelector('css-selector')`: Tìm **phần tử đầu tiên** khớp với bộ chọn CSS bạn đưa vào. Cực kỳ linh hoạt!
-   `querySelectorAll('css-selector')`: Tìm **tất cả** các phần tử khớp với bộ chọn.

```javascript
// Tìm phần tử có id là 'header'
const header = document.getElementById('header');

// Tìm phần tử đầu tiên có class 'hero-title'
const heroTitle = document.querySelector('.hero-title');

// Tìm tất cả các nút bấm trong trang
const allButtons = document.querySelectorAll('button');
```
Lời khuyên: Hãy làm quen với querySelector và querySelectorAll. Chúng có thể làm được mọi thứ mà các phương thức cũ làm được và còn hơn thế nữa.

### 2. "Thay hình đổi dạng" - Thay đổi nội dung và style
Khi đã "chộp" được phần tử mình muốn, bạn có thể làm rất nhiều trò ảo thuật.

Thay đổi nội dung bên trong
```javascript
const welcomeMessage = document.querySelector('#welcome');

// Thay đổi chỉ text, an toàn hơn
welcomeMessage.textContent = "Chào mừng bạn đã trở lại!"; 

// Thay đổi cả HTML, có thể chèn thêm thẻ khác
welcomeMessage.innerHTML = "<strong>Chào mừng</strong> bạn đã trở lại!";
```
Thay đổi thuộc tính và style
```javascript
const profileImage = document.querySelector('#profile-pic');
const link = document.querySelector('#my-link');

// Thay đổi ảnh
profileImage.src = 'images/new-avatar.png';

// Thay đổi link
link.setAttribute('href', '[https://github.com](https://github.com)');

// Thay đổi style trực tiếp (không khuyến khích dùng nhiều)
heroTitle.style.color = 'blue';

// Cách tốt hơn: Thay đổi class, để CSS lo phần style
heroTitle.classList.add('active'); // Thêm class 'active'
heroTitle.classList.remove('inactive'); // Xóa class 'inactive'
heroTitle.classList.toggle('highlight'); // Nếu có class thì xóa, không có thì thêm
```
Mẹo hay: Luôn ưu tiên thay đổi class (classList) thay vì can thiệp trực tiếp vào style. Cách này giúp code của bạn sạch sẽ, dễ bảo trì hơn rất nhiều.

### 3. "Lắng nghe và phản hồi" - Xử lý sự kiện
Đây là phần làm cho trang web của bạn thực sự "sống". Bạn có thể ra lệnh cho JavaScript "lắng nghe" một sự kiện nào đó xảy ra trên một phần tử.

Tưởng tượng: Nó giống như bạn cài một người bảo vệ (EventListener) đứng canh một cánh cửa (element). Bạn dặn người bảo vệ: "Khi nào (event) có người bấm chuông (click), hãy thực hiện hành động (function) mở cửa".
```javascript
// 1. Tìm cái nút bấm
const myButton = document.querySelector('#myButton');
const message = document.querySelector('#message');

// 2. Thêm một "người bảo vệ" lắng nghe sự kiện 'click'
myButton.addEventListener('click', function() {
  // 3. Hành động sẽ thực hiện khi nút được bấm
  message.textContent = "Bạn vừa bấm vào nút! Phép thuật đã xảy ra!";
  message.classList.add('success');
});
```
Các sự kiện phổ biến khác bao gồm: 'mouseover' (di chuột qua), 'keydown' (nhấn phím), 'submit' (gửi form),...

## Bài học mình rút ra
- DOM là cây cầu tối quan trọng: Nắm vững DOM là bạn đã nắm được chìa khóa để xây dựng các ứng dụng web tương tác.

- querySelector là bạn thân: Hãy ưu tiên sử dụng nó vì sự linh hoạt và cú pháp giống hệt CSS quen thuộc.

- Thao tác với class tốt hơn style: Tách biệt rõ ràng vai trò: JavaScript lo về hành vi, CSS lo về giao diện.

- Mọi tương tác đều bắt đầu từ addEventListener: Đây là cốt lõi của một trang web động.

## Kết luận
Hiểu về DOM chính là sự khác biệt giữa một người chỉ biết "cú pháp JavaScript" và một người có thể "xây dựng ứng dụng web". Nó không hề phức tạp, chỉ là một tập hợp các công cụ để bạn có toàn quyền điều khiển trang HTML của mình.

Thử thách nhỏ: Hãy tạo một file HTML đơn giản với một nút bấm và một đoạn văn. Sau đó, dùng JavaScript để bắt sự kiện click vào nút và thay đổi nội-dung của đoạn văn đó. Cảm giác "ra lệnh" cho trang web thật sự rất tuyệt vời đấy!