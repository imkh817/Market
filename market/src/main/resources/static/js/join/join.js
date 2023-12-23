document.getElementById("member_jumin2").addEventListener("input", function() {
	const firstDigit = document.getElementById("member_jumin1").value;
	const input = this.value;

	if (input.length === 1) {
		this.value = input + '******';
	} else {
		this.value = input.charAt(0);
	}
});

document.getElementById("member_jumin2").addEventListener("keydown",
	function(event) {
		if (event.key === "Backspace") {
			event.preventDefault();
			this.value = this.value.slice(0, -1);
		}
	});

