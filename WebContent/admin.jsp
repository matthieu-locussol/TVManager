<%@ include file="includes/inc_header_logged.jsp" %>

<%@ page import="java.util.List" %>
<%@ page import="tvmanager.Rank" %>
<%@ page import="tvmanager.Ticket" %>
<%@ page import="tvmanager.Suggest" %>

<%
	List<Ticket> allTickets = (List<Ticket>) request.getAttribute("tickets");
	List<Suggest> allSuggests = (List<Suggest>) request.getAttribute("suggests");
	List<User> allUsers = (List<User>) request.getAttribute("users");
	List<Rank> allRanks = (List<Rank>) request.getAttribute("ranks");
%>

			<div class="row">

				<div class="col-md-4">

					<!-- Ajout d'un film -->
					<form class="form-horizontal" action="http://localhost:8080/TVManager/TVManager" method="POST" role="form">
			            <div class="block">
			                <h6 class="heading-hr"><i class="icon-movie"></i> Add a movie</h6>

			                <input type="hidden" name="action" value="addMovie">

					        <div class="form-group">
					            <label class="col-sm-8 control-label">Movie IMDB ID :</label>
					            <div class="col-sm-4">
					            	<input type="text" class="form-control" name="idMovie">
					            </div>
					        </div>

		                    <div class="form-actions text-right">
		                    	<input type="submit" value="Add" class="btn btn-primary">
		                    </div>

						</div>
					</form>
					<!-- /Ajout d'un film -->

				</div>
				
				<div class="col-md-4">

					<!-- Ajout d'une s&eacute;rie TV -->
					<form class="form-horizontal" action="http://localhost:8080/TVManager/TVManager" method="POST" role="form">
			            <div class="block">
			                <h6 class="heading-hr"><i class="icon-tv"></i> Add a TV show</h6>

			                <input type="hidden" name="action" value="addTVShow">

					        <div class="form-group">
					            <label class="col-sm-8 control-label">TV show IMDB ID :</label>
					            <div class="col-sm-4">
					            	<input type="text" class="form-control" name="idTVShow">
					            </div>
					        </div>

		                    <div class="form-actions text-right">
		                    	<input type="submit" value="Add" class="btn btn-primary">
		                    </div>

						</div>
					</form>
					<!-- /Ajout d'une s&eacute;rie TV -->

				</div>
				
				<div class="col-md-4">

					<!-- Ajout d'un anime -->
					<form class="form-horizontal" action="http://localhost:8080/TVManager/TVManager" method="POST" role="form">
			            <div class="block">
			                <h6 class="heading-hr"><i class="icon-movie2"></i> Add an anime</h6>

			                <input type="hidden" name="action" value="addAnime">

					        <div class="form-group">
					            <label class="col-sm-8 control-label">Movie IMDB ID :</label>
					            <div class="col-sm-4">
					            	<input type="text" class="form-control" name="idAnime">
					            </div>
					        </div>

		                    <div class="form-actions text-right">
		                    	<input type="submit" value="Add" class="btn btn-primary">
		                    </div>

						</div>
					</form>
					<!-- /Ajout d'un anime -->

				</div>

			</div>
			
            <div class="panel panel-default">
                <div class="panel-heading"><h6 class="panel-title"><i class="icon-bubble-notification2"></i> Tickets</h6></div>
                <div class="datatable">
	                <table class="table table-striped table-bordered table-hover">
	                    <thead>
	                        <tr>
	                            <th>First name</th>
	                            <th>Last name</th>
	                            <th>E-Mail address</th>
	                            <th>Message</th>
	                            <th>Actions</th>
	                        </tr>
	                    </thead>
	                    <tbody>
	                    <%
	                    	for(Ticket t : allTickets) {
	                    %>
	                        <tr>
	                            <td><%= t.getSurname() %></td>
	                            <td><%= t.getName() %></td>
	                            <td><%= t.getSender().getMail() %></td>
	                            <td><%= t.getMessage() %></td>
	                            <td>
	                            	<div class="text-center">
										<a href="http://localhost:8080/TVManager/TVManager?action=deleteTicket&id=<%= t.getId() %>"><button type="button" class="btn btn-icon btn-primary"><i class="icon-cancel-circle"></i></button></a></a>
									</div>
	                            </td>
	                        </tr>
                        <%
	                    	}
                        %>
	                    </tbody>
	                </table>
                </div>
	        </div>
			
            <div class="panel panel-default">
                <div class="panel-heading"><h6 class="panel-title"><i class="icon-lamp3"></i> Suggestions</h6></div>
                <div class="datatable">
	                <table class="table table-striped table-bordered table-hover">
	                    <thead>
	                        <tr>
	                            <th>Name</th>
	                            <th>Type</th>
	                            <th>Actions</th>
	                        </tr>
	                    </thead>
	                    <tbody>
	                    <%
	                    	for(Suggest s : allSuggests) {
	                    %>
	                        <tr>
	                            <td><%= s.getName() %></td>
	                            <td><%= s.getType() %></td>
	                            <td>
	                            	<div class="text-center">
										<a href="http://localhost:8080/TVManager/TVManager?action=deleteSuggest&id=<%= s.getId() %>"><button type="button" class="btn btn-icon btn-primary"><i class="icon-cancel-circle"></i></button></a></a>
									</div>
	                            </td>
	                        </tr>
                        <%
	                    	}
                        %>
	                    </tbody>
	                </table>
                </div>
	        </div>
			

			<!-- Static control -->
			<form class="form-horizontal" action="http://localhost:8080/TVManager/TVManager" method="POST" role="form">
	            <div class="panel panel-default">
	                <div class="panel-heading"><h6 class="panel-title"><i class="icon-crown"></i> Ranks</h6></div>
	                <div class="panel-body">
	                
	                	<input type="hidden" name="action" value="createRank">

				        <div class="form-group">
				            <label class="col-sm-2 control-label text-right">Rank name :</label>
				            <div class="col-sm-10">
				            	<input type="text" name="name" class="form-control">
				            </div>
				        </div>
				        
				        <div class="form-group">
				            <label class="col-sm-2 control-label text-right">Rank level :</label>
				            <div class="col-sm-10">
								<select class="multi-select-right" name="level" tabindex="2" style="display: none;">
									<option value="1">Level 1 (member)</option>
									<option value="2">Level 2 (administrator)</option>
                                </select>
				            </div>
				        </div>

                        <div class="form-actions text-right">
                        	<input type="submit" value="Create rank" class="btn btn-primary">
                        </div>

				    </div>
				</div>
			</form>
			<!-- /static control -->
			
            <div class="panel panel-default">
                <div class="panel-heading"><h6 class="panel-title"><i class="icon-users"></i> Users</h6></div>
                <div class="datatable">
	                <table class="table table-striped table-bordered table-hover">
	                    <thead>
	                        <tr>
	                            <th>Username</th>
	                            <th>E-Mail address</th>
	                            <th>Rank</th>
	                        </tr>
	                    </thead>
	                    <tbody>
	                    <%
	                    	for(User u : allUsers) {
	                    %>
	                        <tr>
	                            <td><%= u.getPseudonyme() %></td>
	                            <td><%= u.getMail() %></td>
	                            <td>
	                            	<form action="http://localhost:8080/TVManager/TVManager" method="POST" id="form<%= u.getPseudonyme() %>">
	                            		<input type="hidden" name="action" value="editRank">
	                            		<input type="hidden" name="id" value="<%= u.getId() %>">
	                            	
										<select class="multi-select" name="rank" tabindex="1" style="display: none;" onchange="document.getElementById('form<%= u.getPseudonyme() %>').submit();">
											<%
												for(Rank r : allRanks) {
											%>
		                                    	<option value="<%= r.getName() %>" <% if(u.getRank().getId() == r.getId()) { out.println("selected=\"selected\""); } %>><%= r.getName() %></option>
			                 				<%
												}
			                              	%>
		                                </select>
	                                </form>
	                            </td>
	                        </tr>
                        <%
	                    	}
                        %>
	                    </tbody>
	                </table>
                </div>
	        </div>

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