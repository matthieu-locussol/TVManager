<%@ include file="includes/inc_header_logged.jsp" %>

<%
	User user = (User) request.getSession().getAttribute("user");
%>

			<!-- Changer e-mail -->
			<form class="form-horizontal" action="http://localhost:8080/TVManager/TVManager" method="POST" role="form">
	            <div class="block">
	                <h6 class="heading-hr"><i class="icon-user"></i> Change e-mail address <small>(<%= user.getMail() %>)</small></h6>

	                <input type="hidden" name="action" value="changeMail">

			        <div class="form-group">
			            <label class="col-sm-2 control-label">New e-mail address :</label>
			            <div class="col-sm-10">
			            	<input type="text" class="form-control" name="mail">
			            </div>
			        </div>

			        <div class="form-group">
			            <label class="col-sm-2 control-label">Enter your new password :</label>
			            <div class="col-sm-10">
			            	<input type="password" class="form-control" name="password">
			            </div>
			        </div>

                    <div class="form-actions text-right">
                    	<input type="submit" value="Change my e-mail address" class="btn btn-primary">
                    </div>

				</div>
			</form>
			<!-- /Changer e-mail -->

			<!-- Changer mot de passe -->
			<form class="form-horizontal" action="http://localhost:8080/TVManager/TVManager" method="POST" role="form">
	            <div class="block">
	                <h6 class="heading-hr"><i class="icon-key"></i> Change my password</h6>

	                <input type="hidden" name="action" value="changePassword">

			        <div class="form-group">
			            <label class="col-sm-2 control-label">Current password :</label>
			            <div class="col-sm-10">
			            	<input type="password" class="form-control" name="password">
			            </div>
			        </div>

			        <div class="form-group">
			            <label class="col-sm-2 control-label">New password :</label>
			            <div class="col-sm-10">
			            	<input type="password" class="form-control" name="newPassword">
			            </div>
			        </div>

			        <div class="form-group">
			            <label class="col-sm-2 control-label">New password confirmation :</label>
			            <div class="col-sm-10">
			            	<input type="password" class="form-control" name="confirmation">
			            </div>
			        </div>

                    <div class="form-actions text-right">
                    	<input type="submit" value="Change my password" class="btn btn-primary">
                    </div>

				</div>
			</form>
			<!-- /Changer mot de passe -->

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