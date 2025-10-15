---
title: "Tại sao code JS của tôi chạy không đúng thứ tự? Hiểu về Bất đồng bộ, Promise và async/await"
date: 2025-10-11T13:07:24+07:00
draft: false
image: "/images/javascript-async-await-promise.png"
description: "Giải thích khái niệm bất đồng bộ trong JavaScript một cách dễ hiểu cho sinh viên. Học cách sử dụng Promise và async/await để xử lý tác vụ tốn thời gian như gọi API."
categories: ["JavaScript", "Lập trình"]
author: "Một Lập Trình Viên Trẻ"
tags: ["javascript", "async", "promise", "api", "es6", "sinh-vien-it"]
---

## Vấn đề: "Đợi đã, sao lại là `undefined`?"

Chắc chắn bạn đã từng gặp trường hợp này: bạn dùng `fetch` để lấy dữ liệu từ một API, rồi `console.log` kết quả ngay dòng bên dưới, và BÙM... kết quả là `undefined` hoặc một thứ khó hiểu như `Promise {<pending>}`.

```javascript
function layDuLieuUser() {
  const data = fetch('[https://api.github.com/users/google](https://api.github.com/users/google)'); // Lấy dữ liệu user Google
  console.log(data); // 😱 Kết quả không như mong đợi!
}

layDuLieuUser();
```

Đây không phải là lỗi. Đây là một trong những khái niệm quan trọng và mạnh mẽ nhất của JavaScript: Bất đồng bộ (Asynchronous).

Tưởng tượng đơn giản: Bạn vào một quán cà phê.

- Đồng bộ (Synchronous): Bạn order, rồi đứng yên tại quầy chờ, không làm gì cả cho đến khi nhân viên pha xong và đưa nước cho bạn. Rất lãng phí thời gian.

- Bất đồng bộ (Asynchronous): Bạn order, nhân viên đưa bạn một cái thẻ báo rung. Bạn cầm thẻ về bàn ngồi lướt điện thoại, nói chuyện với bạn bè. Khi nào nước được pha xong, thẻ sẽ rung lên và bạn ra lấy. Đây chính là cách JavaScript hoạt động với các tác vụ tốn thời gian (như gọi API, đọc file).

## 1. "Cái thẻ báo rung" - Promise
Trong JavaScript, "cái thẻ báo rung" đó được gọi là Promise.

Một Promise là một đối tượng đại diện cho một tác vụ chưa hoàn thành, nhưng hứa hẹn sẽ trả về kết quả trong tương lai. Nó có 3 trạng thái:

- pending: Chờ. (Nhân viên đang pha cà phê).

- fulfilled: Hoàn thành thành công. (Bạn đã nhận được ly cà phê).

- rejected: Thất bại. (Quán hết cà phê).

Vậy làm sao để xử lý khi "thẻ báo rung"? Chúng ta dùng .then() và .catch().

- .then(data => { ... }): Hàm này sẽ được gọi khi Promise fulfilled (thành công). data chính là kết quả trả về.

- .catch(error => { ... }): Hàm này sẽ được gọi khi Promise rejected (thất bại).

Hãy sửa lại ví dụ ban đầu bằng Promise:
```javascript
console.log("1. Bắt đầu order cà phê...");

fetch('[https://api.github.com/users/google](https://api.github.com/users/google)')
  .then(response => {
    // fetch trả về một response, ta cần chuyển nó thành JSON
    return response.json();
  })
  .then(data => {
    // Đây là lúc dữ liệu thực sự có thể dùng được!
    console.log("3. Cà phê đã tới! Dữ liệu user:", data.name);
  })
  .catch(error => {
    // Xử lý nếu có lỗi mạng hoặc API sập
    console.error("3. Quán hết cà phê rồi! Lỗi:", error);
  });

console.log("2. Trong lúc chờ, mình đi lướt điện thoại...");
```

Nếu bạn chạy code trên, bạn sẽ thấy thứ tự in ra console là: 1, 2, rồi mới đến 3. Điều này chứng tỏ JavaScript không hề chờ fetch làm xong, nó chạy tiếp dòng code console.log số 2 ngay lập tức!

## 2. async/await - Cách viết code "thanh lịch" hơn
Dùng .then() nhiều lúc sẽ tạo ra các chuỗi lồng vào nhau rất khó đọc (còn gọi là "callback hell"). ES7 đã giới thiệu một cú pháp "ngọt ngào" hơn để làm việc với Promise, đó là async/await.

Nó giúp bạn viết code bất đồng bộ mà trông y hệt như code đồng bộ.

- async: Đặt từ khóa này trước một hàm để báo hiệu rằng hàm đó có chứa các tác vụ bất đồng bộ. Hàm async luôn luôn trả về một Promise.

- await: Chỉ có thể được dùng bên trong một hàm async. Nó ra lệnh cho JavaScript: "Dừng lại ở đây, đợi cho cái Promise này giải quyết xong rồi hãy đi tiếp."

Hãy xem lại ví dụ trên được viết bằng async/await:
```javascript
console.log("1. Bắt đầu order cà phê...");

// Bọc code trong một hàm async
async function layDuLieuUser() {
  try {
    // 1. Đợi fetch hoàn thành
    const response = await fetch('[https://api.github.com/users/google](https://api.github.com/users/google)');
    
    // 2. Đợi việc chuyển đổi sang JSON hoàn thành
    const data = await response.json();

    console.log("3. Cà phê đã tới! Dữ liệu user:", data.name);
  } catch (error) {
    console.error("3. Quán hết cà phê rồi! Lỗi:", error);
  }
}

// Gọi hàm async
layDuLieuUser();

console.log("2. Trong lúc chờ, mình đi lướt điện thoại...");
```

Code trông tuần tự, sạch sẽ và dễ đọc hơn rất nhiều đúng không? try...catch được dùng để bắt lỗi, thay thế cho .catch() của Promise.

## Bài học mình rút ra
- JavaScript không chờ đợi ai cả: Nó được thiết kế để không bị "treo" khi xử lý các tác vụ chậm. Đây là một thế mạnh, không phải là lỗi.

- Hiểu Promise là nền tảng: async/await chỉ là một cách viết khác cho Promise. Hãy chắc chắn rằng bạn hiểu cách .then() và .catch() hoạt động.

- Luôn xử lý lỗi: Các tác vụ mạng luôn có thể thất bại. Luôn dùng .catch() hoặc try...catch để chương trình của bạn không bị "sập" một cách bất ngờ. Đây là thói quen của một lập trình viên chuyên nghiệp.

## Kết luận
Hiểu về bất đồng bộ là một bước ngoặt lớn đối với bất kỳ ai học JavaScript. Nó mở ra cánh cửa để làm việc với API, tương tác với server và xây dựng các ứng dụng web phức tạp.

Lần tới khi bạn dùng fetch để lấy dữ liệu, đừng console.log ngay bên dưới. Hãy bọc nó trong một hàm async và dùng await để chờ "lời hứa" được thực hiện. Bạn sẽ thấy code của mình hoạt động đúng như mong đợi và dễ quản lý hơn rất nhiều.