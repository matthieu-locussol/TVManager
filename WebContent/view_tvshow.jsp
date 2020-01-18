<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ include file="includes/inc_header_logged.jsp" %>

<%@ page import="java.util.List" %>
<%@ page import="tvmanager.TVShow" %>
<%@ page import="tvmanager.TVShowData" %>
<%@ page import="tvmanager.TVShowComment" %>

<%
	TVShow viewTVShow = (TVShow) request.getAttribute("viewTVShow");
%>

			<!-- Profil -->
			<div class="row">
				<div class="col-lg-2">

					<!-- Poster du film -->
				    <div class="block">

			    		<div class="block">
						    <div class="thumbnail">
						    	<div class="thumb">
									<img alt="" src="<%= viewTVShow.getPoster() %>">
							    </div>

							    <div class="caption text-center">
						    		<h6>Format : <%= viewTVShow.getDuration() %> minutes</h6>
						    	</div>
					    	</div>
					    </div>
					</div>
					<!-- /Poster du film -->

				</div>

				<div class="col-lg-8">

			        <!-- Informations du film -->

                	<!-- Films -->
		            <div class="panel panel-default">
		                <div class="panel-heading"><h6 class="panel-title"><i class="icon-tv"></i> TV show page</h6></div>
	                    <div class="panel-body">

	                        <h1 style="margin-top: 0;"><%= viewTVShow.getTitle() %></h1>
	                        <p><%= viewTVShow.getDescription() %></p>

	                    </div>
			        </div>
	                <!-- /Informations du film -->
	                
		            <div class="panel panel-default">
		                <div class="panel-heading"><h6 class="panel-title"><i class="icon-bubbles5"></i> Comments</h6></div>
	                    <div class="panel-body">
			                <div class="panel-collapse collapse in" id="lucy">
			                
		                       	<div class="chat">
									<div class="block">
									
				                    <%
				                    	List<TVShowComment> comments = viewTVShow.getComments();
				                    
										for(int i = comments.size() - 1 ; i >= 0 ; --i) {
											TVShowComment tvsc = comments.get(i);
											User owner = tvsc.getUser();
				                    %>
										<div class="media">
											<a class="pull-left" href="http://localhost:8080/TVManager/TVManager?action=profile&id=<%= owner.getId() %>">
												<img class="media-object" src="https://www.gravatar.com/avatar/<%= owner.getHashMail() %>?size=44" alt="">
											</a>
												<div class="media-body">
													<span class="media-heading"><%= owner.getPseudonyme() %></span>
													<ul class="headline-info">
														<li><%= tvsc.getDate() %></li>
													</ul>
							                        <%= tvsc.getMessage() %>
												</div>
										</div>
									<%
										}
									%>
										
									</div>
		                        </div>
		                        
	                        	<form method="POST" action="http://localhost:8080/TVManager/TVManager">
	                        		<input type="hidden" name="action" value="commentTVShow">
	                        		<input type="hidden" name="id" value="<%= viewTVShow.getId() %>">
		                            <textarea name="message" class="form-control" rows="3" cols="1" placeholder="Write a comment"></textarea>
		                            <div class="message-controls">
			                            <div class="pull-right">
			                                <button type="submit" class="btn btn-danger">Send</button>
			                            </div>
			                        </div>
			                    </form>
			                    
		                    </div>
		                </div>
		            </div>
		            

		            
				</div>

				<div class="col-lg-2">

					<!-- Poster du film -->
		            <div class="panel panel-default">
		                <div class="panel-heading"><h6 class="panel-title"><i class="stats2"></i> Stats</h6></div>
	                    <div class="panel-body">
							<ul class="list-group">
								<li class="list-group-item">
									<span class="label label-success"><%= viewTVShow.getViewersCount() %></span>
									Seen by
								</li>
								<li class="list-group-item">
									<span class="label label-success"><%= viewTVShow.getFollowersCount() %></span>
									Follows
								</li>
								<li class="list-group-item">
									<span class="label label-primary"><%= viewTVShow.getAverageNote() %></span>
								</li>
							</ul>
						</div>
					</div>
					<!-- /Poster du film -->

					<%
						User user = (User) request.getSession().getAttribute("user");
						TVShowData tsd = viewTVShow.getTVShowData(user.getId());

 						String seenActive = (tsd != null && tsd.getState() == 1) ? "active" : "";
 						Integer seenId = (tsd != null && tsd.getState() == 1) ? 0 : 1;
						String toSeeActive = (tsd != null && tsd.getState() == 2) ? "active" : "";
 						Integer toSeeId = (tsd != null && tsd.getState() == 2) ? 0 : 2;
					%>
					<!-- Poster du film -->
		            <div class="panel panel-default">
		                <div class="panel-heading"><h6 class="panel-title"><i class="stats2"></i> Progress</h6></div>
	                    <div class="panel-body">
	                    	<div class="block">
								<div class="form-group">
									<a href="http://localhost:8080/TVManager/TVManager?action=stateTVShow&id=<%= viewTVShow.getId() %>&state=<%= seenId %>" class="list-group-item list-group-item-success text-center <%= seenActive %>"><strong>FINISHED</strong></a>
									<a href="http://localhost:8080/TVManager/TVManager?action=stateTVShow&id=<%= viewTVShow.getId() %>&state=<%= toSeeId %>" class="list-group-item list-group-item-warning text-center <%= toSeeActive %>"><strong>ONGOING</strong></a>
								</div>

								<%
									if(tsd != null && tsd.getState() == 2) {
										int selectedSeason = tsd.getSeason();
										int selectedEpisode = tsd.getEpisode();
								%>
								
								<form action="http://localhost:8080/TVManager/TVManager" method="POST">
									<input type="hidden" name="action" value="progressTVShow">
									<input type="hidden" name="id" id="TVShowID" value="<%= viewTVShow.getId() %>">
								
									<div class="form-group">
										<div class="col-md-6">
											<select class="multi-select" name="season" id="seasons" tabindex="1" style="display: none;" onchange="">
			                                    <option value="1">Season</option>
												<%
													for(int i = 1 ; i <= tsd.getTVShow().getSeasons() ; ++i) {
												%>
				                                    <option value="<%= i %>" <% if(i == selectedSeason) { out.println("selected=\"selected\""); } %>>S<%= i %></option>
				                 				<%
													}
				                              	%>
			                                </select>
										</div>
		
										<div class="col-md-6">
											<select class="multi-select-right" name="episode" id="episodes" tabindex="2" style="display: none;">
			                                    <option value="1">Episode</option>
												<%
													for(int i = 1 ; i <= tsd.getTVShow().getEpisodes().get(selectedSeason - 1) ; ++i) {
												%>
			                                    	<option value="<%= i %>" <% if(i == selectedEpisode) { out.println("selected=\"selected\""); } %>>E<%= i %></option>
				                 				<%
													}
				                              	%>
			                                </select>
										</div>
									</div>
			                    
				                    <script>
					                    $(function() {
					                        $('#seasons').change(function() {
					                            this.form.submit();
					                        });
					                    });
					                    
					                    $(function() {
					                        $('#episodes').change(function() {
					                            this.form.submit();
					                        });
					                    });
				                    </script>
			                    </form>
			                    
								<%
									}
								%>
							</div>
						</div>
					</div>

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