<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ include file="includes/inc_header_logged.jsp" %>

<%@ page import="java.util.List" %>
<%@ page import="tvmanager.Movie" %>
<%@ page import="tvmanager.MovieData" %>
<%@ page import="tvmanager.MovieComment" %>

<%
	Movie viewMovie = (Movie) request.getAttribute("viewMovie");
%>

			<!-- Profil -->
			<div class="row">
				<div class="col-lg-2">

					<!-- Poster du film -->
				    <div class="block">

			    		<div class="block">
						    <div class="thumbnail">
						    	<div class="thumb">
									<img alt="" src="<%= viewMovie.getPoster() %>">
							    </div>

							    <div class="caption text-center">
						    		<h6><%= viewMovie.getDuration() %> minutes</h6>
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
		                <div class="panel-heading"><h6 class="panel-title"><i class="icon-movie"></i> Movie page</h6></div>
	                    <div class="panel-body">

	                        <h1 style="margin-top: 0;"><%= viewMovie.getTitle() %></h1>
	                        <p><%= viewMovie.getDescription() %></p>

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
				                    	List<MovieComment> comments = viewMovie.getComments();
				                    
										for(int i = comments.size() - 1 ; i >= 0 ; --i) {
											MovieComment mc = comments.get(i);
											User owner = mc.getUser();
				                    %>
										<div class="media">
											<a class="pull-left" href="http://localhost:8080/TVManager/TVManager?action=profile&id=<%= owner.getId() %>">
												<img class="media-object" src="https://www.gravatar.com/avatar/<%= owner.getHashMail() %>?size=44" alt="">
											</a>
												<div class="media-body">
													<span class="media-heading"><%= owner.getPseudonyme() %></span>
													<ul class="headline-info">
														<li><%= mc.getDate() %></li>
													</ul>
							                        <%= mc.getMessage() %>
												</div>
										</div>
									<%
										}
									%>
										
									</div>
		                        </div>
		                        
	                        	<form method="POST" action="http://localhost:8080/TVManager/TVManager">
	                        		<input type="hidden" name="action" value="commentMovie">
	                        		<input type="hidden" name="id" value="<%= viewMovie.getId() %>">
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
									<span class="label label-success"><%= viewMovie.getViewersCount() %></span>
									Seen by
								</li>
								<li class="list-group-item">
									<span class="label label-success"><%= viewMovie.getFollowersCount() %></span>
									Follows
								</li>
								<li class="list-group-item">
									<span class="label label-primary"><%= viewMovie.getAverageNote() %></span>
								</li>
							</ul>
						</div>
					</div>
					<!-- /Poster du film -->

					<%
						User user = (User) request.getSession().getAttribute("user");
						MovieData md = user.getMovieData(viewMovie.getId());

 						String seenActive = (md != null && md.getState() == 1) ? "active" : "";
 						Integer seenId = (md != null && md.getState() == 1) ? 0 : 1;
						String toSeeActive = (md != null && md.getState() == 2) ? "active" : "";
 						Integer toSeeId = (md != null && md.getState() == 2) ? 0 : 2;
					%>
					<!-- Poster du film -->
		            <div class="panel panel-default">
		                <div class="panel-heading"><h6 class="panel-title"><i class="stats2"></i> Progress</h6></div>
	                    <div class="panel-body">
							<div class="list-group">
								<a href="http://localhost:8080/TVManager/TVManager?action=stateMovie&id=<%= viewMovie.getId() %>&state=<%= seenId %>" class="list-group-item list-group-item-success text-center <%= seenActive %>"><strong>FINISHED</strong></a>
								<a href="http://localhost:8080/TVManager/TVManager?action=stateMovie&id=<%= viewMovie.getId() %>&state=<%= toSeeId %>" class="list-group-item list-group-item-warning text-center <%= toSeeActive %>"><strong>ONGOING</strong></a>
							</div>
						</div>
					</div>
					<!-- /Poster du film -->

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