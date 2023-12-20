<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- Geolocation API -->
<script>
	function access_geo(location) {
		/* console.log(location) */
		const location_geo = {
			latitude : location.coords.latitude,
			longitude : location.coords.longitude
		}
		console.log(location_geo)
	}
	function ask_geo() {
		navigator.geolocation.getCurrentPosition(access_geo)
	}
	ask_geo();
</script>

<div class="container-sm mx-5 px-5 my-5 py-5">
	<div class="row row-cols-1 row-cols-md-4 g-4">
		<div class="list_content"></div>
	</div>
</div>