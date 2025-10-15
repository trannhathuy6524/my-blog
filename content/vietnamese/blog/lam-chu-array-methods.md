---
title: "Làm chủ Array Methods: map, filter, reduce trong 5 phút"
date: 2025-10-10T23:35:00+07:00
draft: false
image: "/images/js-array-methods.png"
description: "Cách dùng map, filter, reduce để code JavaScript ngắn gọn và xịn hơn, thay thế cho vòng lặp for truyền thống."
categories: ["JavaScript", "Lập trình"]
author: "Một Lập Trình Viên Trẻ"
tags: ["javascript", "es6", "sinh-vien-it"]
---

## Giới thiệu

Khi mới học JavaScript, mình cũng như nhiều bạn khác, hễ cứ đụng đến mảng (array) là lại dùng vòng lặp `for`. Muốn nhân đôi các số trong mảng? Dùng . Muốn lọc ra các số chẵn? Lại dùng `for`. Code thì chạy được, nhưng trông rất dài và đôi khi khó đọc.

Mọi thứ đã thay đổi khi mình biết đến "bộ ba quyền lực" của Array Methods trong ES6: **`map`**, **`filter`**, và **`reduce`**. Chúng giúp xử lý mảng một cách ngắn gọn, dễ hiểu và chuyên nghiệp hơn rất nhiều. Cùng tìm hiểu nhé!

---

## 1. map() - Biến đổi từng phần tử

> **Ý tưởng:** Dùng `map()` khi bạn muốn **biến đổi** tất cả các phần tử trong một mảng và nhận về một mảng mới có cùng số lượng phần tử.

Nó giống như một dây chuyền sản xuất: bạn đưa một loạt nguyên liệu thô vào, dây chuyền biến đổi từng món, và cho ra một loạt sản phẩm mới.

**Ví dụ:** Cho một mảng các số, hãy tạo ra một mảng mới với các số được nhân đôi.

**Cách dùng `for` (kiểu cũ):**
```javascript
const numbers = [1, 2, 3, 4, 5];
const doubledNumbers = [];

for (let i = 0; i < numbers.length; i++) {
  doubledNumbers.push(numbers[i] * 2);
}

// kết quả: doubledNumbers = [2, 4, 6, 8, 10]
```
Cách dùng map() (kiểu mới ✨):
```javascript
const numbers = [1, 2, 3, 4, 5];

const doubledNumbers = numbers.map(function(num) {
  return num * 2;
});

// Hoặc viết bằng arrow function cho ngắn gọn:
const doubledNumbersArrow = numbers.map(num => num * 2);

// kết quả: [2, 4, 6, 8, 10]
```

Thấy không? Ngắn hơn hẳn và rất rõ ràng về mục đích: "ánh xạ" (map) mỗi số thành một số mới.

## 2. filter() - Lọc ra những gì bạn cần
> Ý tưởng: Dùng filter() khi bạn muốn lọc mảng để giữ lại những phần tử thỏa mãn một điều kiện nào đó.
Nó giống như một cái rây: bạn cho tất cả vào, nhưng chỉ những gì lọt qua "lưới điều kiện" mới được giữ lại. Mảng kết quả thường sẽ có ít phần tử hơn mảng ban đầu.

Ví dụ: Cho một mảng các số, chỉ giữ lại các số chẵn.

Cách dùng for (kiểu cũ):
```javascript
const numbers = [1, 2, 3, 4, 5, 6];
const evenNumbers = [];

for (let i = 0; i < numbers.length; i++) {
  if (numbers[i] % 2 === 0) {
    evenNumbers.push(numbers[i]);
  }
}

// kết quả: evenNumbers = [2, 4, 6]
```
Cách dùng filter() (kiểu mới ✨):
```javascript
const numbers = [1, 2, 3, 4, 5, 6];

const evenNumbers = numbers.filter(function(num) {
  return num % 2 === 0; // Trả về true nếu là số chẵn
});

// Dùng arrow function:
const evenNumbersArrow = numbers.filter(num => num % 2 === 0);

// kết quả: [2, 4, 6]
```
## 3. reduce() - "Trùm cuối" gom mảng về một giá trị
>Ý tưởng: Dùng reduce() khi bạn muốn gom tất cả phần tử của mảng lại để tính ra một giá trị duy nhất (ví dụ: tính tổng, tính tích, tìm giá trị lớn nhất...).

Đây là phương thức khó hiểu nhất ban đầu nhưng lại cực kỳ mạnh mẽ. Hãy tưởng tượng bạn đang nấu một nồi súp: bạn có một cái nồi (accumulator) và lần lượt cho từng nguyên liệu (currentValue) vào rồi khuấy đều. Cuối cùng bạn có một nồi súp duy nhất.

reduce nhận vào 2 tham số chính:

Một hàm callback với 2 đối số: accumulator (biến tích lũy) và currentValue (phần tử đang xét).

Giá trị khởi tạo cho accumulator (tùy chọn).

Ví dụ: Tính tổng các số trong một mảng.

Cách dùng for (kiểu cũ):
```javascript
const numbers = [1, 2, 3, 4, 5];
let sum = 0; // biến tích lũy

for (let i = 0; i < numbers.length; i++) {
  sum += numbers[i];
}

// kết quả: sum = 15
```
Cách dùng reduce() (kiểu mới ✨):
```javascript
const numbers = [1, 2, 3, 4, 5];

const sum = numbers.reduce(function(accumulator, currentValue) {
  return accumulator + currentValue;
}, 0); // 0 là giá trị khởi tạo cho accumulator

// Dùng arrow function:
const sumArrow = numbers.reduce((acc, cur) => acc + cur, 0);

// kết quả: 15
```
Sức mạnh khi kết hợp chúng
Điều tuyệt vời nhất là bạn có thể "xâu chuỗi" (chaining) các phương thức này lại với nhau.

Bài toán: Cho một mảng các số. Hãy tính tổng của các số lẻ sau khi đã nhân đôi chúng.
```javascript
const numbers = [1, 2, 3, 4, 5];

const result = numbers
  .map(num => num * 2)       // [2, 4, 6, 8, 10]
  .filter(num => num % 2 !== 0) // Mảng này sẽ rỗng vì không có số lẻ nào
  .reduce((acc, cur) => acc + cur, 0); // kết quả sẽ là 0

// Một ví dụ khác: Tính tổng bình phương của các số chẵn
const result2 = numbers
    .filter(num => num % 2 === 0) // [2, 4]
    .map(num => num * num)        // [4, 16]
    .reduce((acc, cur) => acc + cur, 0); // 4 + 16 = 20
```
Chỉ với một dòng code, chúng ta đã giải quyết được một bài toán phức tạp một cách cực kỳ dễ đọc.

## Bài học mình rút ra
Code ngắn hơn, sạch hơn: Không còn các biến tạm như i, mảng rỗng [] hay biến sum = 0.

Dễ đọc hơn: Tên của phương thức (map, filter) đã tự nói lên mục đích của nó. Bạn đọc code và hiểu ngay luồng xử lý dữ liệu.

Tư duy lập trình hàm: Học cách dùng map, filter, reduce là bước đầu tiên để bạn tiếp cận với tư duy Lập trình hàm (Functional Programming) - một kỹ năng rất quan trọng trong phát triển phần mềm hiện đại, đặc biệt khi làm việc với các thư viện/framework như React.

## Kết luận
Nếu bạn vẫn còn đang dùng vòng lặp for cho mọi tác vụ với mảng, hãy thử dừng lại một chút. Lần tới, hãy tự hỏi: "Mình đang muốn biến đổi, lọc, hay gom mảng này lại?". Câu trả lời sẽ cho bạn biết nên dùng map, filter, hay reduce.

Hãy mở ngay editor lên và thử dùng chúng để "refactor" lại những vòng lặp for cũ của bạn. Bạn sẽ bất ngờ vì code của mình trở nên "xịn" hơn nhiều đấy! Chúc các bạn thành công.