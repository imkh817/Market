<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>마이 페이지</title>
    
   
    
    <!-- Custom styles for this template -->
</head>
<body>

<div class="d-flex flex-column flex-shrink-0 p-3 text-dark bg-white" style="width: 280px;">
    <a href="/" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto text-dark text-decoration-none">
      <svg class="bi me-2" width="40" height="32"><use xlink:href="#bootstrap"></use></svg>
      <span class="fs-4">마이 페이지</span>
    </a>
    <hr>
    <ul class="nav nav-pills flex-column mb-auto">
      <li class="nav-item">
        <a href="#" class="nav-link active" aria-current="page">
          <svg class="bi me-2" width="16" height="16" onClick="location.href='mypage_form'"><use xlink:href="#home"></use></svg>
          판매 내역
        </a>
      </li><br>
      <li>
        <a href="#" class="nav-link text-dark">
          <svg class="bi me-2" width="16" height="16"><use xlink:href="#speedometer2"></use></svg>
          관심 상품
        </a>
      </li><br>
      <li>
        <a href="#" class="nav-link text-dark">
          <svg class="bi me-2" width="16" height="16"><use xlink:href="#table"></use></svg>
          회원 탈퇴
        </a>
      </li>
    </ul>
  </div>

</body>
</html>
