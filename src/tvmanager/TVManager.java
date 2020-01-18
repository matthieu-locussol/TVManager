package tvmanager;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

import org.json.JSONArray;
import org.json.JSONObject;

@WebServlet("/TVManager")
public class TVManager extends HttpServlet {
	
	private static final long serialVersionUID = 1385834583495L;
	
	private static final String IMDB_API_KEY = "4356ebf07c781a64968480c9068f9f36";
	
	@EJB
	private Facade m_facade;
	
	private boolean m_initialized = true;
       
    public TVManager() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(m_initialized) {
			initialize();
			
			m_initialized = false;
		}
		
		String action = request.getParameter("action");
		
		if(action != null) {
			handleAction(action, request, response);
		} else {
			request.getRequestDispatcher("login.jsp").forward(request, response);
		}
	}
	
	private void handleAction(String action, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(action.equals("login")) {
			actionLogin(request, response);
		} else if(action.equals("signUp")) {
			actionSignUp(request, response);
		} else if(action.equals("profile")) {
			actionProfile(request, response);
		} else if(action.equals("addMovie")) {
			actionAddMovie(request, response);
		} else if(action.equals("addTVShow")) {
			actionAddTVShow(request, response);
		} else if(action.equals("home")) {
			actionHome(request, response);
		} else if(action.equals("contact")) {
			actionContact(request, response);
		} else if(action.equals("movies")) {
			actionMovies(request, response);
		} else if(action.equals("tvshows")) {
			actionTVShows(request, response);
		} else if(action.equals("viewMovie")) {
			actionViewMovie(request, response);
		} else if(action.equals("viewTVShow")) {
			actionViewTVShow(request, response);
		} else if(action.equals("commentMovie")) {
			actionCommentMovie(request, response);
		} else if(action.equals("commentTVShow")) {
			actionCommentTVShow(request, response);
		} else if(action.equals("stateMovie")) {
			actionStateMovie(request, response);
		} else if(action.equals("stateTVShow")) {
			actionStateTVShow(request, response);
		} else if(action.equals("deleteMovie")) {
			actionDeleteMovie(request, response);
		} else if(action.equals("deleteTVShow")) {
			actionDeleteTVShow(request, response);
		} else if(action.equals("progressTVShow")) {
			actionProgressTVShow(request, response);
		} else if(action.equals("admin")) {
			actionAdmin(request, response);
		} else if(action.equals("deleteTicket")) {
			actionDeleteTicket(request, response);
		} else if(action.equals("suggest")) {
			actionSuggest(request, response);
		} else if(action.equals("deleteSuggest")) {
			actionDeleteSuggest(request, response);
		} else if(action.equals("changeMail")) {
			actionChangeMail(request, response);
		} else if(action.equals("changePassword")) {
			actionChangePassword(request, response);
		} else if(action.equals("editRank")) {
			actionEditRank(request, response);
		} else if(action.equals("createRank")) {
			actionCreateRank(request, response);
		} else if(action.equals("animes")) {
			actionAnimes(request, response);
		} else if(action.equals("viewAnime")) {
			actionViewAnime(request, response);
		} else if(action.equals("commentAnime")) {
			actionCommentAnime(request, response);
		} else if(action.equals("stateAnime")) {
			actionStateAnime(request, response);
		} else if(action.equals("deleteAnime")) {
			actionDeleteAnime(request, response);
		} else if(action.equals("progressAnime")) {
			actionProgressAnime(request, response);
		} else if(action.equals("addAnime")) {
			actionAddAnime(request, response);
		}
	}
	
	private void actionAnimes(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<Anime> allAnimes = m_facade.getAnimesList();
		
		request.setAttribute("allAnimes", allAnimes);
		request.getRequestDispatcher("animes.jsp").forward(request, response);
	}
	
	private void actionViewAnime(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Integer id = Integer.parseInt(request.getParameter("id"));
		
		Anime anime = m_facade.getAnimeById(id);
		
		if(anime != null) {
			request.setAttribute("viewAnime", anime);
			request.getRequestDispatcher("view_anime.jsp").forward(request, response);
		} else {
			actionAnimes(request, response);
		}
	}
	
	private void actionCommentAnime(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Integer id = Integer.parseInt(request.getParameter("id"));
		User commentOwner = (User) request.getSession().getAttribute("user");
		String message = request.getParameter("message");
		
		m_facade.createAnimeComment(id, commentOwner, message);
		
		response.sendRedirect("http://localhost:8080/TVManager/TVManager?action=viewAnime&id=" + id);
	}
	
	private void actionStateAnime(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Integer id = Integer.parseInt(request.getParameter("id"));
		Integer state = Integer.parseInt(request.getParameter("state"));
		User user = (User) request.getSession().getAttribute("user");
		
		m_facade.updateAnimeState(id, state, user);
		
		response.sendRedirect("http://localhost:8080/TVManager/TVManager?action=viewAnime&id=" + id);
	}
	
	private void actionDeleteAnime(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Integer id = Integer.parseInt(request.getParameter("id"));
		User user = (User) request.getSession().getAttribute("user");
		
		m_facade.updateAnimeState(id, 0, user);
		
		request.getRequestDispatcher("library.jsp").forward(request, response);
	}
	
	private void actionProgressAnime(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Integer id = Integer.parseInt(request.getParameter("id"));
		User user = (User) request.getSession().getAttribute("user");
		Integer season = Integer.parseInt(request.getParameter("season"));
		Integer episode = Integer.parseInt(request.getParameter("episode"));
		
		m_facade.progressAnime(id, user, season, episode);
		
		response.sendRedirect("http://localhost:8080/TVManager/TVManager?action=viewAnime&id=" + id);
	}
	
	private void actionAddAnime(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("idAnime");
		
		User user = (User) request.getSession().getAttribute("user");
		
		// Si on est administrateur et qu'on a rentré un ID valide
		if(user.getRank().getLevel() == 2 && id != null) {
			Integer idAnime = Integer.parseInt(id);
			
			// Contacte l'API IMDB
			
			OkHttpClient client = new OkHttpClient();
	
			Request httpRequest = new Request.Builder()
			  .url("https://api.themoviedb.org/3/tv/" + idAnime + "?api_key=" + IMDB_API_KEY)
			  .get()
			  .build();
	
			Response httpResponse = client.newCall(httpRequest).execute();
			
			// Parse le JSON résultat
			
			JSONObject tvshowObject = new JSONObject(httpResponse.body().string());
			
			// Si le film existe côté IMDB
			if(tvshowObject.has("name")) {
				JSONArray runtimes = tvshowObject.getJSONArray("episode_run_time");
				
				Integer duration = runtimes.getInt(0);
				
				String title = tvshowObject.getString("name");
				String date = tvshowObject.getString("first_air_date");
				String poster = tvshowObject.getString("poster_path");
				String description = tvshowObject.getString("overview");
				
				Double rating = tvshowObject.getDouble("vote_average");
				Integer rating_count = tvshowObject.getInt("vote_count");
				
				int seasons = tvshowObject.getInt("number_of_seasons");
				
				List<Integer> episodes = new ArrayList<>();
				
				JSONArray seasonsArray = tvshowObject.getJSONArray("seasons");
				
				for(int i = 0 ; i < seasonsArray.length() ; ++i) {
					JSONObject seasonObject = seasonsArray.getJSONObject(i);
					
					if(seasonObject.getInt("season_number") > 0) {
						episodes.add(seasonObject.getInt("episode_count"));
					}
				}

				System.out.println("Seasons : " + seasons);
				System.out.println("Episodes : " + episodes);
				
				// On ajoute le film à la base de données
				
				m_facade.createAnime(idAnime, title, date, poster, duration, description, seasons, episodes, rating, rating_count);
			}
			
			// On redirige l'administrateur vers la page de gestion
			
			actionAdmin(request, response);
		}
	}

	private void actionChangePassword(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String password = request.getParameter("password");
		String newPassword = request.getParameter("newPassword");
		String confirmation = request.getParameter("confirmation");
		
		User user = (User) request.getSession().getAttribute("user");
		
		m_facade.updatePassword(user, newPassword, confirmation, password);
		
		request.getRequestDispatcher("settings.jsp").forward(request, response);
	}

	private void actionChangeMail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mail = request.getParameter("mail");
		String password = request.getParameter("password");
		
		User user = (User) request.getSession().getAttribute("user");
		
		m_facade.updateMail(user, mail, password);
		
		request.getRequestDispatcher("settings.jsp").forward(request, response);
	}

	private void actionLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mail = request.getParameter("mail");
		String password = request.getParameter("password");
		
		if(m_facade.login(mail, password)) {
			request.getSession().setAttribute("user", m_facade.getUserByMail(mail));
			actionHome(request, response);
		} else {
			request.getRequestDispatcher("login.jsp").forward(request, response);
		}
	}
	
	private void actionSignUp(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mail = request.getParameter("mail");
		String password = request.getParameter("password");
		String confirmation = request.getParameter("confirmation");
		String pseudonyme = request.getParameter("pseudonyme");
		
		if(m_facade.signUp(mail, password, confirmation, pseudonyme)) {
			request.getSession().setAttribute("user", m_facade.getUserByMail(mail));
			actionHome(request, response);
		} else {
			request.getRequestDispatcher("sign_up.jsp").forward(request, response);
		}
	}
	
	private void actionProfile(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Integer id = Integer.parseInt(request.getParameter("id"));
		
		User user = m_facade.getUserById(id);
		
		if(user != null) {
			request.setAttribute("userProfile", user);
			request.getRequestDispatcher("profile.jsp").forward(request, response);
		} else {
			actionHome(request, response);
		}
	}
	
	private void actionAddMovie(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("idMovie");
		
		User user = (User) request.getSession().getAttribute("user");
		
		// Si on est administrateur et qu'on a rentré un ID valide
		if(user.getRank().getLevel() == 2 && id != null) {
			Integer idMovie = Integer.parseInt(id);
			
			// Contacte l'API IMDB
			
			OkHttpClient client = new OkHttpClient();
	
			Request httpRequest = new Request.Builder()
			  .url("https://api.themoviedb.org/3/movie/" + idMovie + "?api_key=" + IMDB_API_KEY)
			  .get()
			  .build();
	
			Response httpResponse = client.newCall(httpRequest).execute();
			
			// Parse le JSON résultat
			
			JSONObject movieObject = new JSONObject(httpResponse.body().string());
			
			// Si le film existe côté IMDB
			if(movieObject.has("title")) {
				Integer duration = movieObject.getInt("runtime");
				
				String title = movieObject.getString("title");
				String date = movieObject.getString("release_date");
				String poster = movieObject.getString("poster_path");
				String description = movieObject.getString("overview");
				
				Double rating = movieObject.getDouble("vote_average");
				Integer rating_count = movieObject.getInt("vote_count");
				
				// On ajoute le film à la base de données
				
				m_facade.createMovie(idMovie, title, date, poster, duration, description, rating, rating_count);
			}
			
			// On redirige l'administrateur vers la page de gestion
			
			actionAdmin(request, response);
		}
	}
	
	private void actionAddTVShow(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("idTVShow");
		
		User user = (User) request.getSession().getAttribute("user");
		
		// Si on est administrateur et qu'on a rentré un ID valide
		if(user.getRank().getLevel() == 2 && id != null) {
			Integer idTVShow = Integer.parseInt(id);
			
			// Contacte l'API IMDB
			
			OkHttpClient client = new OkHttpClient();
	
			Request httpRequest = new Request.Builder()
			  .url("https://api.themoviedb.org/3/tv/" + idTVShow + "?api_key=" + IMDB_API_KEY)
			  .get()
			  .build();
	
			Response httpResponse = client.newCall(httpRequest).execute();
			
			// Parse le JSON résultat
			
			JSONObject tvshowObject = new JSONObject(httpResponse.body().string());
			
			// Si le film existe côté IMDB
			if(tvshowObject.has("name")) {
				JSONArray runtimes = tvshowObject.getJSONArray("episode_run_time");
				
				Integer duration = runtimes.getInt(0);
				
				String title = tvshowObject.getString("name");
				String date = tvshowObject.getString("first_air_date");
				String poster = tvshowObject.getString("poster_path");
				String description = tvshowObject.getString("overview");
				
				Double rating = tvshowObject.getDouble("vote_average");
				Integer rating_count = tvshowObject.getInt("vote_count");
				
				int seasons = tvshowObject.getInt("number_of_seasons");
				
				List<Integer> episodes = new ArrayList<>();
				
				JSONArray seasonsArray = tvshowObject.getJSONArray("seasons");
				
				for(int i = 0 ; i < seasonsArray.length() ; ++i) {
					JSONObject seasonObject = seasonsArray.getJSONObject(i);
					
					if(seasonObject.getInt("season_number") > 0) {
						episodes.add(seasonObject.getInt("episode_count"));
					}
				}

				System.out.println("Seasons : " + seasons);
				System.out.println("Episodes : " + episodes);
				
				// On ajoute le film à la base de données
				
				m_facade.createTVShow(idTVShow, title, date, poster, duration, description, seasons, episodes, rating, rating_count);
			}
			
			// On redirige l'administrateur vers la page de gestion
			
			actionAdmin(request, response);
		}
	}
	
	private void actionHome(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("PASS 0");
		
		List<Movie> lastMovies = m_facade.getLastMoviesList();
		List<TVShow> lastTVShows = m_facade.getLastTVShowsList();
		List<Anime> lastAnimes = m_facade.getLastAnimesList();

		System.out.println("PASS 1");
		
		request.setAttribute("lastMovies", lastMovies);
		request.setAttribute("lastTVShows", lastTVShows);
		request.setAttribute("lastAnimes", lastAnimes);

		System.out.println("PASS 2");
		
		request.getRequestDispatcher("home.jsp").forward(request, response);

		System.out.println("PASS 3");
	}
	
	private void actionMovies(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<Movie> allMovies = m_facade.getMoviesList();
		
		request.setAttribute("allMovies", allMovies);
		request.getRequestDispatcher("movies.jsp").forward(request, response);
	}
	
	private void actionTVShows(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<TVShow> allTVShows = m_facade.getTVShowsList();
		
		request.setAttribute("allTVShows", allTVShows);
		request.getRequestDispatcher("tvshows.jsp").forward(request, response);
	}
	
	private void actionViewMovie(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Integer id = Integer.parseInt(request.getParameter("id"));
		
		Movie movie = m_facade.getMovieById(id);
		
		if(movie != null) {
			request.setAttribute("viewMovie", movie);
			request.getRequestDispatcher("view_movie.jsp").forward(request, response);
		} else {
			actionMovies(request, response);
		}
	}
	
	private void actionViewTVShow(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Integer id = Integer.parseInt(request.getParameter("id"));
		
		TVShow tvshow = m_facade.getTVShowById(id);
		
		if(tvshow != null) {
			request.setAttribute("viewTVShow", tvshow);
			request.getRequestDispatcher("view_tvshow.jsp").forward(request, response);
		} else {
			actionTVShows(request, response);
		}
	}
	
	private void actionCommentMovie(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Integer id = Integer.parseInt(request.getParameter("id"));
		User commentOwner = (User) request.getSession().getAttribute("user");
		String message = request.getParameter("message");
		
		m_facade.createMovieComment(id, commentOwner, message);
		
		response.sendRedirect("http://localhost:8080/TVManager/TVManager?action=viewMovie&id=" + id);
	}
	
	private void actionProgressTVShow(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Integer id = Integer.parseInt(request.getParameter("id"));
		User user = (User) request.getSession().getAttribute("user");
		Integer season = Integer.parseInt(request.getParameter("season"));
		Integer episode = Integer.parseInt(request.getParameter("episode"));
		
		m_facade.progressTVShow(id, user, season, episode);
		
		response.sendRedirect("http://localhost:8080/TVManager/TVManager?action=viewTVShow&id=" + id);
	}
	
	private void actionCommentTVShow(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Integer id = Integer.parseInt(request.getParameter("id"));
		User commentOwner = (User) request.getSession().getAttribute("user");
		String message = request.getParameter("message");
		
		m_facade.createTVShowComment(id, commentOwner, message);
		
		response.sendRedirect("http://localhost:8080/TVManager/TVManager?action=viewTVShow&id=" + id);
	}
	
	private void actionStateMovie(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Integer id = Integer.parseInt(request.getParameter("id"));
		Integer state = Integer.parseInt(request.getParameter("state"));
		User user = (User) request.getSession().getAttribute("user");
		
		m_facade.updateMovieState(id, state, user);
		
		response.sendRedirect("http://localhost:8080/TVManager/TVManager?action=viewMovie&id=" + id);
	}
	
	private void actionStateTVShow(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Integer id = Integer.parseInt(request.getParameter("id"));
		Integer state = Integer.parseInt(request.getParameter("state"));
		User user = (User) request.getSession().getAttribute("user");
		
		m_facade.updateTVShowState(id, state, user);
		
		response.sendRedirect("http://localhost:8080/TVManager/TVManager?action=viewTVShow&id=" + id);
	}
	
	private void actionDeleteMovie(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Integer id = Integer.parseInt(request.getParameter("id"));
		User user = (User) request.getSession().getAttribute("user");
		
		m_facade.updateMovieState(id, 0, user);
		
		request.getRequestDispatcher("library.jsp").forward(request, response);
	}
	
	private void actionDeleteTVShow(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Integer id = Integer.parseInt(request.getParameter("id"));
		User user = (User) request.getSession().getAttribute("user");
		
		m_facade.updateTVShowState(id, 0, user);
		
		request.getRequestDispatcher("library.jsp").forward(request, response);
	}
	
	private void actionContact(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String surname = request.getParameter("surname");
		String name = request.getParameter("name");
		String message = request.getParameter("message");
		User sender = (User) request.getSession().getAttribute("user");
		
		m_facade.contact(surname, name, message, sender);

		request.getRequestDispatcher("contact.jsp").forward(request, response);
	}
	
	private void actionAdmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<Ticket> tickets = m_facade.getTickets();
		request.setAttribute("tickets", tickets);
		List<Suggest> suggests = m_facade.getSuggests();
		request.setAttribute("suggests", suggests);
		
		List<User> users = m_facade.getUsersList();
		request.setAttribute("users", users);
		List<Rank> ranks = m_facade.getRanksList();
		request.setAttribute("ranks", ranks);
		
		request.getRequestDispatcher("admin.jsp").forward(request, response);
	}
	
	private void actionDeleteTicket(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Integer id = Integer.parseInt(request.getParameter("id"));
		
		m_facade.deleteTicket(id);
		
		actionAdmin(request, response);
	}
	
	private void actionSuggest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = request.getParameter("name");
		String type = request.getParameter("type");
		
		m_facade.suggest(name, type);

		request.getRequestDispatcher("suggest.jsp").forward(request, response);
	}
	
	private void actionDeleteSuggest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Integer id = Integer.parseInt(request.getParameter("id"));
		
		m_facade.deleteSuggest(id);
		
		actionAdmin(request, response);
	}
	
	private void actionEditRank(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Integer id = Integer.parseInt(request.getParameter("id"));
		String rank = request.getParameter("rank");
		User user = (User) request.getSession().getAttribute("user");
		
		m_facade.editRank(id, rank, user);
		
		actionAdmin(request, response);
	}
	
	private void actionCreateRank(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = request.getParameter("name");
		Integer level = Integer.parseInt(request.getParameter("level"));
		User user = (User) request.getSession().getAttribute("user");
		
		m_facade.createRank(user, name, level);
		
		actionAdmin(request, response);
	}
	
	private void initialize() {
		// On crée deux rangs de base : Membre & Administrateur
        m_facade.createRank("Membre", 1);
        m_facade.createRank("Administrateur", 2);
        
        // On crée un compte administrateur par défaut
        m_facade.signUp("dev.matthieu.locussol@gmail.com", "ojgfjwxs", "ojgfjwxs", "Jeckhys");
        
        User adminUser = m_facade.getUserByMail("dev.matthieu.locussol@gmail.com");
        Rank adminRank = m_facade.getRankByName("Administrateur");
        
        m_facade.updateUserRank(adminUser, adminRank);
	}

}
