<%@ include file="includes/inc_header_logged.jsp" %>

			<!-- Suggestion -->
			<form class="form-horizontal" action="http://localhost:8080/TVManager/TVManager" method="POST" role="form">
	            <div class="block">
	                <h6 class="heading-hr"><i class="icon-lamp3"></i> Suggestion</h6>

	                <input type="hidden" name="action" value="suggest">

	                <div class="form-group">
						<label class="col-sm-2 control-label">Media name : </label>
						<div class="col-sm-10">
							<div class="row">
								<div class="col-sm-6">
			            			<input type="text" class="form-control" placeholder="Media name" name="name">
                                </div>

                                <div class="col-sm-6">
									<select class="multi-select" name="type" tabindex="2" style="display: none;">
	                                    <option value="Movie">Movie</option>
	                                    <option value="TV show">TV show</option>
	                                    <option value="Anime">Anime</option>
	                                </select>
                                </div>

                            </div>
						</div>
					</div>

                    <div class="form-actions text-right">
                    	<input type="submit" value="Suggest" class="btn btn-primary">
                    </div>

				</div>
			</form>
			<!-- /Suggestion -->

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