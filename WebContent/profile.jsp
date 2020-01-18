<%@ include file="includes/inc_header_logged.jsp" %>

<%@ page import="tvmanager.Movie" %>
<%@ page import="tvmanager.MovieData" %>
<%@ page import="tvmanager.TVShow" %>
<%@ page import="tvmanager.TVShowData" %>
<%@ page import="tvmanager.Anime" %>
<%@ page import="tvmanager.AnimeData" %>

<%
	User userProfile = (User) request.getAttribute("userProfile");
%>

			<!-- Profil -->
			<div class="row">
				<div class="col-lg-2">

					<!-- Statistiques -->
				    <div class="block">

			    		<div class="block">
						    <div class="thumbnail">
						    	<div class="thumb">
									<img alt="" src="https://www.gravatar.com/avatar/<%= userProfile.getHashMail() %>?size=244">
							    </div>
						    
						    	<div class="caption text-center">
						    		<h6><%= userProfile.getPseudonyme() %> <small><%= userProfile.getRank().getName() %></small></h6>
						    	</div>
					    	</div>
					    </div>

					    <span class="subtitle">Stats</span>

						<ul class="list-group">
							<li class="list-group-item">
								<span class="label label-success"><%= userProfile.getMoviesSeen() %></span>
								Movies
							</li>
							<li class="list-group-item">
								<span class="label label-danger"><%= userProfile.getTVShowsSeen() %></span>
								TV shows
							</li>
							<li class="list-group-item">
								<span class="label label-danger"><%= userProfile.getTVShowsEpisodesSeen() %></span>
								&nbsp;&#x21b3; Episodes seen
							</li>
							<li class="list-group-item">
								<span class="label label-primary"><%= userProfile.getAnimesSeen() %></span>
								Animes
							</li>
							<li class="list-group-item">
								<span class="label label-danger"><%= userProfile.getAnimesEpisodesSeen() %></span>
								&nbsp;&#x21b3; Episodes seen
							</li>
							<li class="list-group-item">
								<span class="badge"><%= userProfile.getTimeSpent() %> hours</span>
								TOTAL
							</li>
						</ul>
					</div>
					<!-- /Statistiques -->

				</div>

				<div class="col-lg-10">

			        <!-- M&eacute;diath&egrave;que de l'utilisateur -->
					<div class="tabbable page-tabs">
		                <ul class="nav nav-tabs">
			                <li class="active"><a href="#movies" data-toggle="tab"><i class="icon-movie"></i> Movies</a></li>
		                    <li><a href="#tvshows" data-toggle="tab"><i class="icon-tv"></i> TV shows</a></li>
		                    <li><a href="#animes" data-toggle="tab"><i class="icon-movie2"></i> Animes</a></li>
		                </ul>

		                <div class="tab-content">
		                	<!-- Films -->
		                	<div class="tab-pane active fade in" id="movies">
					            <div class="panel panel-default">
					                <div class="panel-heading"><h6 class="panel-title"><i class="icon-bookmark3"></i> ${user.getPseudonyme()}'s library</h6></div>
					                <div class="datatable">
						                <table class="table table-bordered table-hover">
						                    <thead>
						                        <tr>
						                            <th>Movie name</th>
						                            <th>Release date</th>
						                            <th>State</th>
						                            <th>Actions</th>
						                        </tr>
						                    </thead>
						                    <tbody>
					                    	<%
					                    		for(MovieData md : userProfile.getMovieDatas()) {
	
					                    			if(md.getState() != 0) {
						                    			String stateString = (md.getState() == 1) ? "SEEN" : "TO SEE";
						                    			String cellType = (md.getState() == 1) ? "success" : "warning";
								                    	%>
									                        <tr class="<%= cellType %>">
									                            <td><%= md.getMovie().getTitle() %></td>
									                            <td><%= md.getMovie().getDate() %></td>
									                            <td><%= stateString %></td>
									                            <td>
									                            	<div class="text-center">
																		<a href="http://localhost:8080/TVManager/TVManager?action=viewMovie&id=<%= md.getMovie().getId() %>"><button type="button" class="btn btn-icon btn-primary"><i class="icon-file"></i></button></a>
																	</div>
									                            </td>
									                        </tr>
								                        <%
					                        		}
					                        	}
					                        %>
						                    </tbody>
						                </table>
					                </div>
						        </div>
						    </div>

		                	<!-- S&eacute;ries TV -->
		                	<div class="tab-pane fade in" id="tvshows">
					            <div class="panel panel-default">
					                <div class="panel-heading"><h6 class="panel-title"><i class="icon-bookmark3"></i> ${user.getPseudonyme()}'s library</h6></div>
					                <div class="datatable">
						                <table class="table table-bordered table-hover">
						                    <thead>
						                        <tr>
						                            <th>TV show name</th>
						                            <th>Release date</th>
						                            <th>Progress</th>
						                            <th>Actions</th>
						                        </tr>
						                    </thead>
						                    <tbody>
					                    	<%
					                    		for(TVShowData tsd : userProfile.getTVShowDatas()) {
	
					                    			if(tsd.getState() != 0) {
						                    			String stateString = (tsd.getState() == 1) ? "SEEN" : "TO SEE";

						                    			float episodeString = userProfile.countEpisodesAt(tsd.getTVShow(), tsd.getSeason(), tsd.getEpisode());
						                    			float episodeCountString = userProfile.countEpisodesAt(tsd.getTVShow(), tsd.getTVShow().getSeasons(), tsd.getTVShow().getEpisodes().get(tsd.getTVShow().getSeasons() - 1));
						                    			
						                    			float percentage = episodeString / episodeCountString * 100.f;
						                    			percentage = (tsd.getState() == 1) ? 100.f : percentage;
						                    			
						                    			String percentageString = String.format("%.02f", percentage);
						                    			
						                    			String PBType = (tsd.getState() == 1) ? "success" : "info";
						                    			String cellType = (tsd.getState() == 1) ? "success" : "warning";
								                    	%>
									                        <tr class="<%= cellType %>">
									                            <td><%= tsd.getTVShow().getTitle() %></td>
									                            <td><%= tsd.getTVShow().getDate() %></td>
									                            <td>
										                            <div class="progress progress-striped active">
																		<div class="progress-bar progress-bar-<%= PBType %>" role="progressbar" aria-valuenow="<%= episodeString %>" aria-valuemin="0" aria-valuemax="<%= episodeCountString %>" style="width: <%= percentage %>%;">
																			<%= percentageString %>%
																		</div>
																	</div>
																</td>
									                            <td>
									                            	<div class="text-center">
																		<a href="http://localhost:8080/TVManager/TVManager?action=viewTVShow&id=<%= tsd.getTVShow().getId() %>"><button type="button" class="btn btn-icon btn-primary"><i class="icon-file"></i></button></a>
																	</div>
									                            </td>
									                        </tr>
								                        <%
					                        		}
					                        	}
					                        %>
						                    </tbody>
						                </table>
					                </div>
						        </div>
						    </div>

		                	<!-- Animes -->
		                	<div class="tab-pane fade in" id="animes">
					            <div class="panel panel-default">
					                <div class="panel-heading"><h6 class="panel-title"><i class="icon-bookmark3"></i> ${user.getPseudonyme()}'s library</h6></div>
					                <div class="datatable">
						                <table class="table table-bordered table-hover">
						                    <thead>
						                        <tr>
						                            <th>Anime name</th>
						                            <th>Release date</th>
						                            <th>Progress</th>
						                            <th>Actions</th>
						                        </tr>
						                    </thead>
						                    <tbody>
					                    	<%
					                    		for(AnimeData ad : userProfile.getAnimeDatas()) {
	
					                    			if(ad.getState() != 0) {
						                    			String stateString = (ad.getState() == 1) ? "SEEN" : "TO SEE";

						                    			float episodeString = userProfile.countEpisodesAt(ad.getAnime(), ad.getSeason(), ad.getEpisode());
						                    			float episodeCountString = userProfile.countEpisodesAt(ad.getAnime(), ad.getAnime().getSeasons(), ad.getAnime().getEpisodes().get(ad.getAnime().getSeasons() - 1));
						                    			
						                    			float percentage = episodeString / episodeCountString * 100.f;
						                    			percentage = (ad.getState() == 1) ? 100.f : percentage;
						                    			
						                    			String percentageString = String.format("%.02f", percentage);
						                    			
						                    			String PBType = (ad.getState() == 1) ? "success" : "info";
						                    			String cellType = (ad.getState() == 1) ? "success" : "warning";
								                    	%>
									                        <tr class="<%= cellType %>">
									                            <td><%= ad.getAnime().getTitle() %></td>
									                            <td><%= ad.getAnime().getDate() %></td>
									                            <td>
										                            <div class="progress progress-striped active">
																		<div class="progress-bar progress-bar-<%= PBType %>" role="progressbar" aria-valuenow="<%= episodeString %>" aria-valuemin="0" aria-valuemax="<%= episodeCountString %>" style="width: <%= percentage %>%;">
																			<%= percentageString %>%
																		</div>
																	</div>
																</td>
									                            <td>
									                            	<div class="text-center">
																		<a href="http://localhost:8080/TVManager/TVManager?action=viewAnime&id=<%= ad.getAnime().getId() %>"><button type="button" class="btn btn-icon btn-primary"><i class="icon-file"></i></button></a>
																	</div>
									                            </td>
									                        </tr>
								                        <%
					                        		}
					                        	}
					                        %>
						                    </tbody>
						                </table>
					                </div>
						        </div>
						    </div>
						</div>
					</div>
	                <!-- /M&eacute;diath&egrave;que de l'utilisateur -->

				</div>
			</div>
			<!-- /Profil -->

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