<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="container">
	<footer
		class="d-flex flex-wrap justify-content-between py-3 my-3 border-top">
		<div class="row" style="font-size: 14px">
			<p class="col text-body-tertiary" style="font-size: 14px">
				Copyright &copy; 2023 <font color="#000">(주)양배추마켓</font> All Rights
				Reserved
			</p>
		</div>
		<div class="btn_up" onclick="window.scrollTo(0,0)">
			<span class="fw-bold">Scroll to Top</span>
		</div>
	</footer>
</div>

<!-- Scroll to Top -->
<script>
	$(function() {
		$("#navbar_toggle_btn").click(function() {
			$("#navbar_menu").toggle();
			$("#navbar_icons").toggle();
		});
	});
</script>
<!-- bootstrap -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
	crossorigin="anonymous"></script>