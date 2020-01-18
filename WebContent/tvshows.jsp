<%@ include file="includes/inc_header_logged.jsp" %>

<%@ page import="java.util.List" %>
<%@ page import="tvmanager.TVShow" %>

<%
	List<TVShow> allTVShows = (List<TVShow>) request.getAttribute("allTVShows");
%>

			<!-- Médiathèque -->
            <div class="panel panel-default">
                <div class="panel-heading"><h6 class="panel-title"><i class="icon-tv"></i> TV Shows</h6></div>
                <div class="datatable">
	                <table class="table table-striped table-bordered table-hover">
	                    <thead>
	                        <tr>
	                            <th>TV show name</th>
	                            <th>Release date</th>
	                            <th>Episode duration</th>
	                            <th>Actions</th>
	                        </tr>
	                    </thead>
	                    <tbody>
	                    <%
	                    	for(TVShow tvs : allTVShows) {
	                    %>
	                        <tr>
	                            <td><%= tvs.getTitle() %></td>
	                            <td><%= tvs.getDate() %></td>
	                            <td><%= tvs.getDuration() %> minutes</td>
	                            <td>
	                            	<div class="text-center">
										<a href="http://localhost:8080/TVManager/TVManager?action=viewTVShow&id=<%= tvs.getId() %>"><button type="button" class="btn btn-icon btn-primary">TV show page</button></a></a>
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
			<!-- /Médiathèque -->

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