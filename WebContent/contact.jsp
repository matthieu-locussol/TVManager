<%@ include file="includes/inc_header_logged.jsp" %>

			<!-- Contact -->
			<form class="form-horizontal" action="http://localhost:8080/TVManager/TVManager" method="POST" role="form">
	            <div class="block">
	                <h6 class="heading-hr"><i class="icon-mail2"></i> Contact us</h6>

	                <input type="hidden" name="action" value="contact">

			        <div class="form-group">
			            <label class="col-sm-2 control-label">First name :</label>
			            <div class="col-sm-10">
			            	<input type="text" class="form-control" placeholder="First name" name="surname">
			            </div>
			        </div>

			        <div class="form-group">
			            <label class="col-sm-2 control-label">Last name :</label>
			            <div class="col-sm-10">
			            	<input type="text" class="form-control" placeholder="Last name" name="name">
			            </div>
			        </div>

					<div class="form-group">
						<label class="col-sm-2 control-label">Message :</label>
						<div class="col-sm-10">
							<textarea rows="5" cols="5" class="form-control" placeholder="Your message..." name="message"></textarea>
						</div>
					</div>

                    <div class="form-actions text-right">
                    	<input type="submit" value="Send" class="btn btn-primary">
                    </div>

				</div>
			</form>
			<!-- /Contact -->

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