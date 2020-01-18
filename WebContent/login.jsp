<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:choose>
	<c:when test="${user != null}">
		<c:redirect url="http://localhost:8080/TVManager/TVManager?action=home" />
	</c:when>
</c:choose>

<!DOCTYPE html>

<html lang="fr">
<meta http-equiv="content-type" content="text/html;charset=UTF-8" />

<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1, maximum-scale=1">
	
  	<link rel="icon" href="images/favicon.png" type="image/png">
  	
	<title>TVManager - Log in</title>
	
	<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css">
	<link href="css/londinium-theme.css" rel="stylesheet" type="text/css">
	<link href="css/styles.css" rel="stylesheet" type="text/css">
	<link href="css/icons.css" rel="stylesheet" type="text/css">
	
	<link href="http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700&amp;subset=latin,cyrillic-ext" rel="stylesheet" type="text/css">
	
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.2/jquery-ui.min.js"></script>
	
	<script type="text/javascript" src="js/plugins/charts/sparkline.min.js"></script>
	
	<script type="text/javascript" src="js/plugins/forms/uniform.min.js"></script>
	<script type="text/javascript" src="js/plugins/forms/select2.min.js"></script>
	<script type="text/javascript" src="js/plugins/forms/inputmask.js"></script>
	<script type="text/javascript" src="js/plugins/forms/autosize.js"></script>
	<script type="text/javascript" src="js/plugins/forms/inputlimit.min.js"></script>
	<script type="text/javascript" src="js/plugins/forms/listbox.js"></script>
	<script type="text/javascript" src="js/plugins/forms/multiselect.js"></script>
	<script type="text/javascript" src="js/plugins/forms/validate.min.js"></script>
	<script type="text/javascript" src="js/plugins/forms/tags.min.js"></script>
	<script type="text/javascript" src="js/plugins/forms/switch.min.js"></script>
	
	<script type="text/javascript" src="js/plugins/forms/uploader/plupload.full.min.js"></script>
	<script type="text/javascript" src="js/plugins/forms/uploader/plupload.queue.min.js"></script>
	
	<script type="text/javascript" src="js/plugins/forms/wysihtml5/wysihtml5.min.js"></script>
	<script type="text/javascript" src="js/plugins/forms/wysihtml5/toolbar.js"></script>
	
	<script type="text/javascript" src="js/plugins/interface/daterangepicker.js"></script>
	<script type="text/javascript" src="js/plugins/interface/fancybox.min.js"></script>
	<script type="text/javascript" src="js/plugins/interface/moment.js"></script>
	<script type="text/javascript" src="js/plugins/interface/jgrowl.min.js"></script>
	<script type="text/javascript" src="js/plugins/interface/datatables.min.js"></script>
	<script type="text/javascript" src="js/plugins/interface/colorpicker.js"></script>
	<script type="text/javascript" src="js/plugins/interface/fullcalendar.min.js"></script>
	<script type="text/javascript" src="js/plugins/interface/timepicker.min.js"></script>
	
	<script type="text/javascript" src="js/bootstrap.min.js"></script>
	<script type="text/javascript" src="js/application.js"></script>
</head>

<body class="full-width page-condensed">

	<div class="navbar navbar-inverse" role="navigation">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-right">
				<span class="sr-only">Show/Hide</span>
				<i class="icon-grid3"></i>
			</button>
			<a class="navbar-brand" href="#"><img src="images/logo.png" width="144" height="36" alt="TVManager"></a>
		</div>
	</div>
	
	<div class="login-wrapper">
	   	<form action="http://localhost:8080/TVManager/TVManager" method="POST" role="form">
			<div class="popup-header">
				<span class="text-semibold">Log in</span>
			</div>
			<div class="well">
				<input type="hidden" name="action" value="login">
			
				<div class="form-group has-feedback">
					<label>E-Mail address</label>
					<input type="text" class="form-control" placeholder="E-Mail address" name="mail">
					<i class="icon-users form-control-feedback"></i>
				</div>
	
				<div class="form-group has-feedback">
					<label>Password</label>
					<input type="password" class="form-control" placeholder="Password" name="password">
					<i class="icon-lock form-control-feedback"></i>
				</div>
	
				<div class="row form-actions">
					<div class="col-xs-6">
						<button type="submit" class="btn btn-primary left">Log in</button>
					</div>
					<div class="col-xs-6">
						<a href="sign_up.jsp" class="btn btn-link pull-right"><i class="icon-user-plus2"></i> Need an account ?</a>
					</div>
				</div>
			</div>
	   	</form>
	</div>

    <div class="footer clearfix">
        <div class="pull-left">&copy; 2017-2020. TVManager by Matthieu Locussol</div>
    </div>

</body>

</html>