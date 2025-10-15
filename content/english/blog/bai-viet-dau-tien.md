---
date: 2025-10-04T17:39:26+07:00
draft: false
title: "Bai Viet Dau Tien"
image: "/images/RESTfulAPI.png"
# --- Them cac truong con thieu duoi day ---
description: "Day la mo ta ngan cho bai viet dau tien cua toi."
categories: ["General"]
author: "Huy"
tags: ["first-post"]
---

## REST API là gì?
API (Application Programming Interface) là cầu nối để các ứng dụng giao tiếp với nhau.

REST (Representational State Transfer) là một phong cách thiết kế API phổ biến, dựa trên giao thức HTTP.

Ví dụ: Khi bạn mở app thời tiết, ứng dụng sẽ gọi API để lấy dữ liệu từ server (nhiệt độ, độ ẩm, dự báo mưa).

## Đặc điểm của REST API
Dùng HTTP method: GET (lấy dữ liệu), POST (thêm), PUT (cập nhật), DELETE (xóa).

Stateless: Mỗi request độc lập, server không lưu trạng thái.

Dữ liệu thường trả về JSON: Dễ đọc và dễ xử lý.

## Ví dụ REST API đơn giản
Mình thử viết một REST API bằng ASP.NET Core để quản lý danh sách xe trong đồ án thuê xe:

GET /api/cars → trả về danh sách xe.

GET /api/cars/1 → lấy thông tin chi tiết xe có ID = 1.

POST /api/cars → thêm một xe mới vào hệ thống.

DELETE /api/cars/1 → xóa xe có ID = 1.

Chỉ cần dùng Postman test API là mình đã thấy dữ liệu trả về dạng JSON cực kỳ rõ ràng.

## Lợi ích khi học REST API
Xây dựng web + mobile dễ dàng: App di động gọi API để lấy dữ liệu từ server.

Tích hợp dịch vụ: Ví dụ tích hợp Google Maps, thanh toán Momo, PayPal… đều qua API.

Kỹ năng quan trọng: Hầu như mọi lập trình viên backend đều cần biết REST API.

## Bài học mình rút ra
Hiểu REST API giúp mình kết nối giữa frontend và backend dễ hơn.

API như “cửa giao tiếp chuẩn” giữa hệ thống, khác với socket “kết nối trực tiếp”.

Thực hành với Postman và viết API CRUD là cách nhanh nhất để học.

Kết
Nếu bạn là sinh viên IT, hãy thử viết một REST API CRUD đơn giản (ví dụ quản lý sinh viên, sản phẩm, hoặc xe như mình). Khi hiểu cách request – response hoạt động, bạn sẽ thấy việc kết nối web và app trở nên “mượt” hơn nhiều.