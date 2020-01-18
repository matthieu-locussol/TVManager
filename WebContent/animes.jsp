<%@ include file="includes/inc_header_logged.jsp" %>

<%@ page import="java.util.List" %>
<%@ page import="tvmanager.Anime" %>

<%
	List<Anime> allAnimes = (List<Anime>) request.getAttribute("allAnimes");
%>

			<!-- Médiathèque -->
            <div class="panel panel-default">
                <div class="panel-heading"><h6 class="panel-title"><i class="icon-movie2"></i> Animes</h6></div>
                <div class="datatable">
	                <table class="table table-striped table-bordered table-hover">
	                    <thead>
	                        <tr>
	                            <th>Anime name</th>
	                            <th>Release date</th>
	                            <th>Episode duration</th>
	                            <th>Actions</th>
	                        </tr>
	                    </thead>
	                    <tbody>
	                    <%
	                    	for(Anime a : allAnimes) {
	                    %>
	                        <tr>
	                            <td><%= a.getTitle() %></td>
	                            <td><%= a.getDate() %></td>
	                            <td><%= a.getDuration() %> minutes</td>
	                            <td>
	                            	<div class="text-center">
										<a href="http://localhost:8080/TVManager/TVManager?action=viewAnime&id=<%= a.getId() %>"><button type="button" class="btn btn-icon btn-primary">Anime page</button></a></a>
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