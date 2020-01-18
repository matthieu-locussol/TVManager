<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="tvmanager.MD5" %>
<%@ page import="tvmanager.User" %>
<%@ page import="tvmanager.Anime" %>
<%@ page import="tvmanager.Movie" %>
<%@ page import="tvmanager.TVShow" %>
<%@ page import="tvmanager.Facade" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>	

<c:choose>
	<c:when test="${user == null}">
		<c:redirect url="login.jsp" />
	</c:when>
</c:choose>

<%
	String URI = request.getRequestURI();
	String filename = URI.substring(URI.lastIndexOf("/") + 1);
	
	String title = null;
	String titleContent = null;
	String titleDescription = null;
	
	switch(filename) {
	case "home.jsp": 
		title = "Home"; 
		titleContent = "Home";
		titleDescription = "Take a look at the latest movies, TV shows and animes suggested.";
		break;
	case "library.jsp": 
		title = "My library"; 
		titleContent = "My library";
		titleDescription = "Manage your movies, TV shows and anime with ease.";
		break;
	case "movies.jsp": 
		title = "Movies"; 
		titleContent = "Movies";
		titleDescription = "Do you want to watch a movie? It's this way.";
		break;
	case "tvshows.jsp": 
		title = "TV Shows"; 
		titleContent = "TV Shows";
		titleDescription = "Oh, are you looking for a TV show to follow? Come take a look.";
		break;
	case "animes.jsp": 
		title = "Animes"; 
		titleContent = "Animes";
		titleDescription = "Would you be tempted by an anime?";
		break;
	case "suggest.jsp": 
		title = "Suggestion"; 
		titleContent = "Suggestion";
		titleDescription = "Are you looking for a missing movie, TV show or anime? Let us know!";
		break;
	
	case "about.jsp": 
		title = "About"; 
		titleContent = "About";
		titleDescription = "Do you have questions about the website or its creator? You are in the right place.";
		break;
	case "contact.jsp": 
		title = "Contact us"; 
		titleContent = "Contact us";
		titleDescription = "You found a bug ? You have a question ? Do not hesitate to contact us.";
		break;
	
	case "profile.jsp": 
		title = "View profile"; 
		
		User userProfile = (User) request.getAttribute("userProfile");
		
		titleContent = "View " + userProfile.getPseudonyme() + "'s profile";
		titleDescription = "";
		break;
	case "settings.jsp": 
		title = "Settings"; 
		titleContent = "Settings";
		titleDescription = "Want to change your e-mail address or password? It's here.";
		break;
	case "admin.jsp":
		%>
		
		<c:choose>
			<c:when test="${user.getRank().getLevel() != 2}">
				<c:redirect url="home.jsp" />
			</c:when>
		</c:choose>
		
		<%
	
		title = "Admin area";
		titleContent = "Admin area";
		titleDescription = "Yes sir !";
		break;
	case "view_movie.jsp": 
		title = "Movie page"; 
		
		Movie viewMovie = (Movie) request.getAttribute("viewMovie");
		
		titleContent = viewMovie.getTitle() + "'s movie page";
		titleDescription = "";
		break;
	case "view_tvshow.jsp": 
		title = "TV Show page"; 
		
		TVShow viewTVShow = (TVShow) request.getAttribute("viewTVShow");
		
		titleContent = viewTVShow.getTitle() + "'s TV show page";
		titleDescription = "";
		break;
	case "view_anime.jsp": 
		title = "Anime page"; 
		
		Anime viewAnime = (Anime) request.getAttribute("viewAnime");
		
		titleContent = viewAnime.getTitle() + "'s anime page";
		titleDescription = "";
		break;
	}

	String homeActive = filename.equals("home.jsp") ? "class=\"active\"" : "";
	String libraryActive = filename.equals("library.jsp") ? "class=\"active\"" : "";
	String moviesActive = filename.equals("movies.jsp") ? "class=\"active\"" : "";
	String tvshowsActive = filename.equals("tvshows.jsp") ? "class=\"active\"" : "";
	String animesActive = filename.equals("animes.jsp") ? "class=\"active\"" : "";
	String suggestActive = filename.equals("suggest.jsp") ? "class=\"active\"" : "";
	String adminActive = filename.equals("admin.jsp") ? "class=\"active\"" : "";
%>

<!DOCTYPE html>

<html lang="en">
<meta http-equiv="content-type" content="text/html;charset=UTF-8" />

<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1, maximum-scale=1">
	
  	<link rel="icon" href="images/favicon.png" type="image/png">
  	
	<title>TVManager - <%= title %></title>
	
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

<body>
	<!-- Barre du haut -->
	<div class="navbar navbar-inverse" role="navigation">

		<div class="navbar-header">
			<a class="navbar-brand" href="#"><img src="images/logo.png" width="144" height="36" alt="Londinium"></a>
			<a class="sidebar-toggle"><i class="icon-paragraph-justify2"></i></a>
			<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar-icons">
				<span class="sr-only">Toggle navbar</span>
				<i class="icon-grid3"></i>
			</button>
			<button type="button" class="navbar-toggle offcanvas">
				<span class="sr-only">Toggle navigation</span>
				<i class="icon-paragraph-justify2"></i>
			</button>
		</div>

		<ul class="nav navbar-nav navbar-right collapse" id="navbar-icons">
			<li>
				<a href="about.jsp"><i class="icon-question"></i> About</a>
			</li>

			<li>
				<a href="contact.jsp"><i class="icon-mail2"></i> Contact us</a>
			</li>

			<li class="user dropdown">
				<a class="dropdown-toggle" data-toggle="dropdown">
					<img src="https://www.gravatar.com/avatar/${user.getHashMail()}?size=32" alt="">
					<span>${user.getPseudonyme()}</span>
					<i class="caret"></i>
				</a>
				<ul class="dropdown-menu dropdown-menu-right icons-right">
					<li><a href="http://localhost:8080/TVManager/TVManager?action=profile&id=${user.getId()}"><i class="icon-user"></i> Profile</a></li>
					<li><a href="settings.jsp"><i class="icon-cog"></i> Settings</a></li>
					<li><a href="logout.jsp"><i class="icon-exit"></i> Logout</a></li>
				</ul>
			</li>
		</ul>
	</div>
	<!-- /Barre du haut -->

	<!-- Conteneur -->
 	<div class="page-container">
		<!-- Barre de gauche -->
		<div class="sidebar">
			<div class="sidebar-content">

				<!-- Menu utilisateur -->
				<div class="user-menu dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown">
						<img src="https://www.gravatar.com/avatar/${user.getHashMail()}" alt="">
						<div class="user-info">
							${user.getPseudonyme()} <span>${user.getRank().getName()}</span>
						</div>
					</a>
					<div class="popup dropdown-menu dropdown-menu-right">
					    <div class="thumbnail">
					    	<div class="thumb">
								<img alt="" src="https://www.gravatar.com/avatar/${user.getHashMail()}?size=188">
						    </div>
					    
					    	<div class="caption text-center">
					    		<h6>${user.getPseudonyme()} <small>${user.getRank().getName()}</small></h6>
					    	</div>
				    	</div>

				    	<ul class="list-group">
							<li class="list-group-item"><i class="icon-movie text-muted"></i> Movies seen <span class="label label-success">${user.getMoviesSeen()}</span></li>
							<li class="list-group-item"><i class="icon-tv text-muted"></i> TV Shows seen <span class="label label-danger">${user.getTVShowsSeen()}</span></li>
							<li class="list-group-item"><i class="text-muted"></i> &nbsp;&#x21b3; Episodes seen <span class="label label-danger">${user.getTVShowsEpisodesSeen()}</span></li>
							<li class="list-group-item"><i class="icon-movie2 text-muted"></i> Animes seen <span class="label label-primary">${user.getAnimesSeen()}</span></li>
							<li class="list-group-item"><i class="text-muted"></i> &nbsp;&#x21b3; Episodes seen <span class="label label-primary">${user.getAnimesEpisodesSeen()}</span></li>
							<li class="list-group-item"><i class="icon-clock3 text-muted"></i> TOTAL <h5 class="pull-right text-danger">${user.getTimeSpent()} hours</h5></li>
						</ul>
					</div>
				</div>
				<!-- /Menu utilisateur -->

				<!-- Menu de gauche -->
				<ul class="navigation">
					<li <%= homeActive %>><a href="http://localhost:8080/TVManager/TVManager?action=home"><span>Home</span> <i class="icon-screen2"></i></a></li>
					<li <%= libraryActive %>><a href="library.jsp"><span>My library</span> <i class="icon-bookmark3"></i></a></li>
					<li <%= moviesActive %>><a href="http://localhost:8080/TVManager/TVManager?action=movies"><span>Movies</span> <i class="icon-movie"></i></a></li>
					<li <%= tvshowsActive %>><a href="http://localhost:8080/TVManager/TVManager?action=tvshows"><span>TV Shows</span> <i class="icon-tv"></i></a></li>
					<li <%= animesActive %>><a href="http://localhost:8080/TVManager/TVManager?action=animes"><span>Animes</span> <i class="icon-movie2"></i></a></li>
					<li <%= suggestActive %>><a href="suggest.jsp"><span>Suggestion</span> <i class="icon-lamp3"></i></a></li>
					<c:choose>
						<c:when test="${user.getRank().getLevel() == 2}">
							<li <%= adminActive %>><a href="http://localhost:8080/TVManager/TVManager?action=admin"><span class="text-danger"><strong>Admin area</strong></span> <i class="icon-crown"></i></a></li>
						</c:when>
					</c:choose>
				</ul>
				<!-- /Menu de gauche -->
			</div>
		</div>
		<!-- /Barre de gauche -->

		<!-- Contenu -->
	 	<div class="page-content">
			<!-- Message de bienvenue -->
			<div class="page-header">
				<div class="page-title">
					<h3><%= titleContent %> <small><%= titleDescription %></small></h3>
				</div>
			</div>
			<!-- /Message de bienvenue -->

			<!-- Fil de navigation -->
			<div class="breadcrumb-line">
				<ul class="breadcrumb">
					<li>TVManager</li>
					<li class="active"><%= title %></li>
				</ul>

				<div class="visible-xs breadcrumb-toggle">
					<a class="btn btn-link btn-lg btn-icon" data-toggle="collapse" data-target=".breadcrumb-buttons"><i class="icon-menu2"></i></a>
				</div>
			</div>
			<!-- /Fil de navigation -->