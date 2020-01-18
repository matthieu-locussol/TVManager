<%@ include file="includes/inc_header_logged.jsp" %>

<%@ page import="java.util.List" %>
<%@ page import="tvmanager.Anime" %>
<%@ page import="tvmanager.Movie" %>
<%@ page import="tvmanager.TVShow" %>

<%
	List<Movie> lastMovies = (List<Movie>) request.getAttribute("lastMovies");
	
	Integer movie1_id = (lastMovies.size() >= 1) ? lastMovies.get(0).getId() : 0;
	String movie1_poster = (lastMovies.size() >= 1) ? lastMovies.get(0).getPoster() : "";
	String movie1_title = (lastMovies.size() >= 1) ? lastMovies.get(0).getTitle() : "";
	String movie1_description = (lastMovies.size() >= 1) ? lastMovies.get(0).getDescription().substring(0, 120) + "..." : "";
	
	Integer movie2_id = (lastMovies.size() >= 2) ? lastMovies.get(1).getId() : 0;
	String movie2_poster = (lastMovies.size() >= 2) ? lastMovies.get(1).getPoster() : "";
	String movie2_title = (lastMovies.size() >= 2) ? lastMovies.get(1).getTitle() : "";
	String movie2_description = (lastMovies.size() >= 2) ? lastMovies.get(1).getDescription().substring(0, 120) + "..." : "";
	
	Integer movie3_id = (lastMovies.size() >= 3) ? lastMovies.get(2).getId() : 0;
	String movie3_poster = (lastMovies.size() >= 3) ? lastMovies.get(2).getPoster() : "";
	String movie3_title = (lastMovies.size() >= 3) ? lastMovies.get(2).getTitle() : "";
	String movie3_description = (lastMovies.size() >= 3) ? lastMovies.get(2).getDescription().substring(0, 120) + "..." : "";
	
	List<TVShow> lastTVShows = (List<TVShow>) request.getAttribute("lastTVShows");
	
	Integer tvshow1_id = (lastTVShows.size() >= 1) ? lastTVShows.get(0).getId() : 0;
	String tvshow1_poster = (lastTVShows.size() >= 1) ? lastTVShows.get(0).getPoster() : "";
	String tvshow1_title = (lastTVShows.size() >= 1) ? lastTVShows.get(0).getTitle() : "";
	String tvshow1_description = (lastTVShows.size() >= 1) ? lastTVShows.get(0).getDescription().substring(0, 120) + "..." : "";
	
	Integer tvshow2_id = (lastTVShows.size() >= 2) ? lastTVShows.get(1).getId() : 0;
	String tvshow2_poster = (lastTVShows.size() >= 2) ? lastTVShows.get(1).getPoster() : "";
	String tvshow2_title = (lastTVShows.size() >= 2) ? lastTVShows.get(1).getTitle() : "";
	String tvshow2_description = (lastTVShows.size() >= 2) ? lastTVShows.get(1).getDescription().substring(0, 120) + "..." : "";
	
	Integer tvshow3_id = (lastTVShows.size() >= 3) ? lastTVShows.get(2).getId() : 0;
	String tvshow3_poster = (lastTVShows.size() >= 3) ? lastTVShows.get(2).getPoster() : "";
	String tvshow3_title = (lastTVShows.size() >= 3) ? lastTVShows.get(2).getTitle() : "";
	String tvshow3_description = (lastTVShows.size() >= 3) ? lastTVShows.get(2).getDescription().substring(0, 120) + "..." : "";
	
	List<Anime> lastAnimes = (List<Anime>) request.getAttribute("lastAnimes");
	
	Integer anime1_id = (lastAnimes.size() >= 1) ? lastAnimes.get(0).getId() : 0;
	String anime1_poster = (lastAnimes.size() >= 1) ? lastAnimes.get(0).getPoster() : "";
	String anime1_title = (lastAnimes.size() >= 1) ? lastAnimes.get(0).getTitle() : "";
	String anime1_description = (lastAnimes.size() >= 1) ? lastAnimes.get(0).getDescription().substring(0, 120) + "..." : "";
	
	Integer anime2_id = (lastAnimes.size() >= 2) ? lastAnimes.get(1).getId() : 0;
	String anime2_poster = (lastAnimes.size() >= 2) ? lastAnimes.get(1).getPoster() : "";
	String anime2_title = (lastAnimes.size() >= 2) ? lastAnimes.get(1).getTitle() : "";
	String anime2_description = (lastAnimes.size() >= 2) ? lastAnimes.get(1).getDescription().substring(0, 120) + "..." : "";
	
	Integer anime3_id = (lastAnimes.size() >= 3) ? lastAnimes.get(2).getId() : 0;
	String anime3_poster = (lastAnimes.size() >= 3) ? lastAnimes.get(2).getPoster() : "";
	String anime3_title = (lastAnimes.size() >= 3) ? lastAnimes.get(2).getTitle() : "";
	String anime3_description = (lastAnimes.size() >= 3) ? lastAnimes.get(2).getDescription().substring(0, 120) + "..." : "";
%>

            <!-- Derniers films -->
            <h6><i class="icon-movie"></i> Latest movies</h6>
			<div class="row">
				<div class="col-lg-4 col-md-6 col-sm-6">
					<div class="block">
					    <div class="thumbnail thumbnail-boxed">
					    	<div class="thumb">
								<img alt="" src="<%= movie3_poster %>" height="350">
						    </div>
					    	<div class="caption">
					    		<a href="http://localhost:8080/TVManager/TVManager?action=viewMovie&id=<%= movie3_id %>" title="" class="caption-title"><%= movie3_title %></a>
					    		<%= movie3_description %>
					    	</div>
					    </div>
					</div>
				</div>

				<div class="col-lg-4 col-md-6 col-sm-6">
					<div class="block">
					    <div class="thumbnail thumbnail-boxed">
					    	<div class="thumb">
								<img alt="" src="<%= movie2_poster %>" height="350">
						    </div>
					    	<div class="caption">
					    		<a href="http://localhost:8080/TVManager/TVManager?action=viewMovie&id=<%= movie2_id %>" title="" class="caption-title"><%= movie2_title %></a>
					    		<%= movie2_description %>
					    	</div>
					    </div>
					</div>
				</div>
				
				<div class="col-lg-4 col-md-6 col-sm-6">
					<div class="block">
					    <div class="thumbnail thumbnail-boxed">
					    	<div class="thumb">
								<img alt="" src="<%= movie1_poster %>" height="350">
						    </div>
					    	<div class="caption">
					    		<a href="http://localhost:8080/TVManager/TVManager?action=viewMovie&id=<%= movie1_id %>" title="" class="caption-title"><%= movie1_title %></a>
					    		<%= movie1_description %>
					    	</div>
					    </div>
					</div>
				</div>
			</div>
            <!-- /Derniers films -->

            <!-- Dernières séries -->
            <h6><i class="icon-tv"></i> Latest TV shows</h6>
			<div class="row">
				<div class="col-lg-4 col-md-6 col-sm-6">
					<div class="block">
					    <div class="thumbnail thumbnail-boxed">
					    	<div class="thumb">
								<img alt="" src="<%= tvshow3_poster %>" height="350">
						    </div>
					    	<div class="caption">
					    		<a href="http://localhost:8080/TVManager/TVManager?action=viewTVShow&id=<%= tvshow3_id %>" title="" class="caption-title"><%= tvshow3_title %></a>
					    		<%= tvshow3_description %>
					    	</div>
					    </div>
					</div>
				</div>

				<div class="col-lg-4 col-md-6 col-sm-6">
					<div class="block">
					    <div class="thumbnail thumbnail-boxed">
					    	<div class="thumb">
								<img alt="" src="<%= tvshow2_poster %>" height="350">
						    </div>
					    	<div class="caption">
					    		<a href="http://localhost:8080/TVManager/TVManager?action=viewTVShow&id=<%= tvshow2_id %>" title="" class="caption-title"><%= tvshow2_title %></a>
					    		<%= tvshow2_description %>
					    	</div>
					    </div>
					</div>
				</div>
				
				<div class="col-lg-4 col-md-6 col-sm-6">
					<div class="block">
					    <div class="thumbnail thumbnail-boxed">
					    	<div class="thumb">
								<img alt="" src="<%= tvshow1_poster %>" height="350">
						    </div>
					    	<div class="caption">
					    		<a href="http://localhost:8080/TVManager/TVManager?action=viewTVShow&id=<%= tvshow1_id %>" title="" class="caption-title"><%= tvshow1_title %></a>
					    		<%= tvshow1_description %>
					    	</div>
					    </div>
					</div>
				</div>
			</div>
            <!-- /Dernières séries -->

            <!-- Derniers animes -->
            <h6><i class="icon-movie2"></i> Latest animes</h6>
			<div class="row">
				<div class="col-lg-4 col-md-6 col-sm-6">
					<div class="block">
					    <div class="thumbnail thumbnail-boxed">
					    	<div class="thumb">
								<img alt="" src="<%= anime3_poster %>" height="350">
						    </div>
					    	<div class="caption">
					    		<a href="http://localhost:8080/TVManager/TVManager?action=viewAnime&id=<%= anime3_id %>" title="" class="caption-title"><%= anime3_title %></a>
					    		<%= anime3_description %>
					    	</div>
					    </div>
					</div>
				</div>

				<div class="col-lg-4 col-md-6 col-sm-6">
					<div class="block">
					    <div class="thumbnail thumbnail-boxed">
					    	<div class="thumb">
								<img alt="" src="<%= anime2_poster %>" height="350">
						    </div>
					    	<div class="caption">
					    		<a href="http://localhost:8080/TVManager/TVManager?action=viewAnime&id=<%= anime2_id %>" title="" class="caption-title"><%= anime2_title %></a>
					    		<%= anime2_description %>
					    	</div>
					    </div>
					</div>
				</div>
				
				<div class="col-lg-4 col-md-6 col-sm-6">
					<div class="block">
					    <div class="thumbnail thumbnail-boxed">
					    	<div class="thumb">
								<img alt="" src="<%= anime1_poster %>" height="350">
						    </div>
					    	<div class="caption">
					    		<a href="http://localhost:8080/TVManager/TVManager?action=viewAnime&id=<%= anime1_id %>" title="" class="caption-title"><%= anime1_title %></a>
					    		<%= anime1_description %>
					    	</div>
					    </div>
					</div>
				</div>
			</div>
            <!-- /Derniers animes -->

	        <!-- Pied de page -->
		    <div class="footer clearfix">
		        <div class="pull-left">&copy; 2017-2020. TVManager by Matthieu Locussol</div>
		    </div>
	        <!-- /Pied de page -->
		</div>
		<!-- /Contenu -->
	</div>
	<!-- /Conteneur -->
</body>

</html>