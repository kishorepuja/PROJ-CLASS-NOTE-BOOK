<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">


<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/jquery.validate.min.js"></script>
<script>
	$(function() {
		$("#email").blur(function(event){
			var email = $('#email').val();
			event.preventDefault();
			ajaxPost();
		});

		function ajaxPost() {
			$.ajax({
				type : "GET",
				url : window.location + "/checkUniqueEmail",
				data : 'email='+$('#email').val(),
				success : function(result) {
					if(result=='DUPLICATE'){
						var divContainer = document.getElementById("emailMsg");
						divContainer.innerHTML = "Given Email Already Taken By Someone";
						$('#email').focus();
						event.preventDefault();
					}
				},
				error : function(e) {
				}
			});
		}
		
		$('form[id="regCWForms"]').validate({
			rules : {
				firstName : 'required',
				lastName : 'required',
				email : {
					required : true,
					email : true,
				},
				pwd : {
					required : true,
					minlength : 8,
				},
				dob:'required',
				userRole:'required',
				phno:'required'
			},
			messages : {
				firstName : 'Please enter first name',
				lastName : 'please enter last name',
				email : 'Please enter a valid email',
				pwd : {
					required :'Please enter password',
					minlength : 'Password must be at least 8 characters long'
				},
				dob:'Please select dob',
				userRole:'Please select a role',
				phno:'Please enter Phno'
			},
			submitHandler : function(form) {
				form.submit();
			}
		});

		$("#datepicker").datepicker({
			changeMonth : true,
			changeYear : true,
			dateFormat : 'dd/mm/yy',
			maxDate : new Date()
		});
	});
</script>

<style>
form .error {
  color: #ff0000;
}
</style>

<title>Insert title here</title>
</head>
<body>

	<form:form action="regUser" method="POST" modelAttribute="um"
		id="regCWForm" name="regCWForm">
		<table>
			<tr>
				<td>First Name:</td>
				<td><form:input path="firstName" /></td>
			</tr>
			<tr>
				<td>Last Name:</td>
				<td><form:input path="lastName" /></td>
			</tr>

			<tr>
				<td>Email:</td>
				<td><form:input path="email" /><font color='red'><span id="emailMsg"></span></font></td>
			</tr>

			<tr>
				<td>Password</td>
				<td><form:password path="pwd" /></td>
			</tr>

			<tr>
				<td>DOB:</td>
				<td><form:input path="dob" id="datepicker" readonly="true" /></td>
			</tr>

			<tr>
				<td>Phno:</td>
				<td><form:input path="phno" /></td>
			</tr>

			<tr>
				<td>Select Role:</td>
				<td><form:select items="${rolesList}" path="role" /></td>
			</tr>


			<tr>
				<td><input type="reset" value="Reset" class="reset" /></td>
				<td><input type="Submit" value="Submit" class="button button2" /></td>
			</tr>
		</table>
	</form:form>

</body>
</html>