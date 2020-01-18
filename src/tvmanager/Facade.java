package tvmanager;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.ejb.Singleton;
import javax.ejb.Startup;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

@Startup
@Singleton
public class Facade {
	
	private final String SALT = "145129145@@@KgnDa92q-#~LeromUpsim3.1415";
	private final String BASE_PATH = "http://image.tmdb.org/t/p/w300";
	
	@PersistenceContext
	private EntityManager m_em;
	
	public boolean login(String mail, String password) {
		User foundUser = getUserByMail(mail);
		
		boolean successCondition = foundUser != null;
		
		successCondition &= !mail.equals("");
		successCondition &= !password.equals("");
		
		if(successCondition) {
			successCondition = foundUser.getPassword().equals(getPasswordHash(password));
		}
		
		return successCondition;
	}
	
	public boolean signUp(String mail, String password, String confirmation, String pseudonyme) {
		User foundMailUser = getUserByMail(mail);
		
		boolean successCondition = password.equals(confirmation);
		
		successCondition &= foundMailUser == null;
		
		successCondition &= !mail.equals("");
		successCondition &= !password.equals("");
		successCondition &= !pseudonyme.equals("");
		
		if(successCondition) {
			User newUser = new User();
			
			newUser.setMail(mail);
			newUser.setPassword(getPasswordHash(password));
			newUser.setPseudonyme(pseudonyme);
			newUser.setRank(getRankByName("Membre"));
			
			m_em.persist(newUser);
		}
		
		return successCondition;
	}
	
	public User getUserById(int id) {
		User foundUser = null;
		
		for(User u : getUsersList()) {
			if(u.getId() == id) {
				foundUser = u;
				break;
			}
		}
		
		return foundUser;
	}
	
	public User getUserByMail(String mail) {
		User foundUser = null;
		
		for(User u : getUsersList()) {
			if(u.getMail().equals(mail)) {
				foundUser = u;
				break;
			}
		}
		
		return foundUser;
	}
	
	public void updateUserRank(User user, Rank rank) {
		user.setRank(rank);
		
		if(m_em.find(User.class, user.getId()) != null) {
			m_em.merge(user);
		}
	}
	
	public Rank getRankByName(String name) {
		Rank foundRank = null;
		
		for(Rank r : getRanksList()) {
			if(r.getName().equals(name)) {
				foundRank = r;
				break;
			}
		}
		
		return foundRank;
	}
	
	public void createRank(String name, int level) {
		if(getRankByName(name) == null) {
			Rank newRank = new Rank();
			
			newRank.setLevel(level);
			newRank.setName(name);
			
			m_em.persist(newRank);
		}
	}
	
	public void createMovie(int id, String title, String date, String poster, int duration, String description, Double rating, Integer rating_count) {
		if(getMovieById(id) == null) {
			Movie newMovie = new Movie();
			
			newMovie.setId(id);
			newMovie.setDate(getNewDate(date));
			newMovie.setTitle(title);
			newMovie.setPoster(BASE_PATH + poster);
			newMovie.setDuration(duration);
			newMovie.setDescription(description);
			newMovie.setRating(rating);
			newMovie.setRating_count(rating_count);
			
			m_em.persist(newMovie);
		}
	}
	
	public void createTVShow(int id, String title, String date, String poster, int duration, String description, int seasons, List<Integer> episodes, Double rating, Integer rating_count) {
		if(getTVShowById(id) == null) {
			TVShow newTVShow = new TVShow();
			
			newTVShow.setId(id);
			newTVShow.setDate(getNewDate(date));
			newTVShow.setTitle(title);
			newTVShow.setPoster(BASE_PATH + poster);
			newTVShow.setDuration(duration);
			newTVShow.setDescription(description);
			newTVShow.setSeasons(seasons);
			newTVShow.setEpisodes(episodes);
			newTVShow.setRating(rating);
			newTVShow.setRating_count(rating_count);
			
			m_em.persist(newTVShow);
		}
	}
	
	public void createMovieComment(int idMovie, User owner, String message) {
		Movie movie = getMovieById(idMovie);
		
		if(movie != null) {
			if(owner != null) {
				MovieComment mc = new MovieComment();
				
				mc.setUser(owner);
				
				DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
				Date date = new Date();
				String dateString = dateFormat.format(date).replaceAll(" ", " à ");
				
				mc.setDate(dateString);
				mc.setMovie(movie);
				mc.setMessage(message);
				
				movie.getComments().add(mc);
				
				m_em.persist(mc);
				m_em.merge(movie);
			}
		}
	}
	
	public void createTVShowComment(int idTVShow, User owner, String message) {
		TVShow tvshow = getTVShowById(idTVShow);
		
		if(tvshow != null) {
			if(owner != null) {
				TVShowComment tvsc = new TVShowComment();
				
				tvsc.setUser(owner);
				
				DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
				Date date = new Date();
				String dateString = dateFormat.format(date).replaceAll(" ", " à ");
				
				tvsc.setDate(dateString);
				tvsc.setTVShow(tvshow);
				tvsc.setMessage(message);
				
				tvshow.getComments().add(tvsc);
				
				m_em.persist(tvsc);
				m_em.merge(tvshow);
			}
		}
	}
	
	public Movie getMovieById(int id) {
		Movie foundMovie = null;
		
		for(Movie m : getMoviesList()) {
			if(m.getId() == id) {
				foundMovie = m;
				break;
			}
		}
		
		return foundMovie;
	}
	
	public TVShow getTVShowById(int id) {
		TVShow foundTVShow = null;
		
		for(TVShow tvs : getTVShowsList()) {
			if(tvs.getId() == id) {
				foundTVShow = tvs;
				break;
			}
		}
		
		return foundTVShow;
	}
	
	public List<Movie> getLastMoviesList() {
		List<Movie> allMovies = getMoviesList();
		
		List<Movie> lastMovies = allMovies.subList(Math.max(allMovies.size() - 3, 0), allMovies.size());
		
		return lastMovies;
	}
	
	public List<TVShow> getLastTVShowsList() {
		List<TVShow> allTVShows = getTVShowsList();
		
		List<TVShow> lastTVShows = allTVShows.subList(Math.max(allTVShows.size() - 3, 0), allTVShows.size());
		
		return lastTVShows;
	}

	public void updateMovieState(Integer id, Integer state, User user) {
		if(user != null) {
			Movie movie = getMovieById(id);
			
			if(movie != null) {
				MovieData md = user.getMovieData(id);
				
				if(md == null) {
					md = new MovieData();
					
					md.setUser(user);
					md.setMovie(getMovieById(id));
					
					user.getMovieDatas().add(md);
					movie.getMovieDatas().add(md);
					
					m_em.persist(md);
				}

				md.setState(state);
				m_em.merge(md);
			}
		}
	}

	public void updateTVShowState(Integer id, Integer state, User user) {
		if(user != null) {
			TVShow tvshow = getTVShowById(id);
			
			if(tvshow != null) {
				TVShowData tsd = user.getTVShowData(id);
				
				if(tsd == null) {
					tsd = new TVShowData();
					
					tsd.setUser(user);
					tsd.setSeason(1);
					tsd.setEpisode(1);
					tsd.setTVShow(getTVShowById(id));
					
					user.getTVShowDatas().add(tsd);
					tvshow.getTVShowDatas().add(tsd);
					
					m_em.persist(tsd);
				}

				tsd.setState(state);
				m_em.merge(tsd);
			}
		}
	}
	
	public void contact(String surname, String name, String content, User sender) {
		if(surname != null && name != null && content != null && sender != null) {
			if(!surname.equals("") && !name.equals("") && !content.equals("")) {
				Ticket ticket = new Ticket();
				
				ticket.setName(name);
				ticket.setSender(sender);
				ticket.setSurname(surname);
				ticket.setMessage(content);
				
				m_em.persist(ticket);
			}
		}
	}
	
	public void suggest(String name, String type) {
		if(name != null && type != null) {
			if(!name.equals("") && !type.equals("")) {
				Suggest suggest = new Suggest();
				
				suggest.setName(name);
				suggest.setType(type);
				
				m_em.persist(suggest);
			}
		}
	}
	
	public void progressTVShow(int idTVShow, User user, int season, int episode) {
		TVShow tvshow = getTVShowById(idTVShow);
		
		if(tvshow != null) {
			if(user != null) {
				if(season > 0 && season <= tvshow.getSeasons()) {
					if(!(episode > 0 && episode <= tvshow.getEpisodes().get(season - 1))) {
						episode = 1;
					}
					
					if(season == tvshow.getSeasons() && episode == tvshow.getEpisodes().get(season - 1)) {
						updateTVShowState(idTVShow, 1, user);
					} else {
						TVShowData tsd = tvshow.getTVShowData(user.getId());
						
						tsd.setSeason(season);
						tsd.setEpisode(episode);
						
						m_em.merge(tsd);
						
						tsd = user.getTVShowData(idTVShow);
						
						tsd.setSeason(season);
						tsd.setEpisode(episode);
						
						m_em.merge(tsd);
					}
				}
			}
		}
	}
	
	public List<User> getUsersList() {
		return m_em.createQuery("from User", User.class).getResultList();
	}
	
	public List<Rank> getRanksList() {
		return m_em.createQuery("from Rank", Rank.class).getResultList();
	}
	
	public List<Movie> getMoviesList() {
		return m_em.createQuery("from Movie", Movie.class).getResultList();
	}
	
	public List<TVShow> getTVShowsList() {
		return m_em.createQuery("from TVShow", TVShow.class).getResultList();
	}
	
	public List<Ticket> getTickets() {
		return m_em.createQuery("from Ticket", Ticket.class).getResultList();
	}
	
	public List<Suggest> getSuggests() {
		return m_em.createQuery("from Suggest", Suggest.class).getResultList();
	}
	
	public void deleteTicket(int idTicket) {
		for(Ticket t : getTickets()) {
			if(t.getId() == idTicket) {
				m_em.remove(t);
				break;
			}
		}
	}
	
	public void deleteSuggest(int idSuggest) {
		for(Suggest s : getSuggests()) {
			if(s.getId() == idSuggest) {
				m_em.remove(s);
				break;
			}
		}
	}
	
	public void updatePassword(User user, String newPassword, String confirmation, String password) {
		if(getPasswordHash(password).equals(user.getPassword())) {
			if(newPassword.equals(confirmation)) {
				user.setPassword(getPasswordHash(newPassword));
				
				m_em.merge(user);
			}
		}
	}
	
	public void updateMail(User user, String mail, String password) {
		if(getPasswordHash(password).equals(user.getPassword())) {
			if(mail != null && !mail.equals("")) {
				user.setMail(mail);
				
				m_em.merge(user);
			}
		}
	}
	
	private String getPasswordHash(String rawPassword) {
		String hashPassword = null;
		
		hashPassword = MD5.md5Hex(SALT + rawPassword + SALT);
		
		return hashPassword;
	}

	public void editRank(Integer id, String rank, User user) {
		if(user != null && user.getRank().getLevel() == 2) {
			User toEdit = getUserById(id);
			
			if(toEdit != null) {
				Rank newRank = getRankByName(rank);
				
				if(newRank != null) {
					updateUserRank(toEdit, newRank);
				}
			}
		}
	}

	public void createRank(User user, String name, Integer level) {
		if(user != null && user.getRank().getLevel() == 2) {
			Rank foundRank = getRankByName(name);
			
			if(foundRank == null) {
				Rank newRank = new Rank();
				
				newRank.setName(name);
				newRank.setLevel(level);
				
				m_em.persist(newRank);
			}
		}
	}

	public List<Anime> getAnimesList() {
		return m_em.createQuery("from Anime", Anime.class).getResultList();
	}

	public Anime getAnimeById(Integer id) {
		Anime foundAnime = null;
		
		for(Anime a : getAnimesList()) {
			if(a.getId() == id) {
				foundAnime = a;
				break;
			}
		}
		
		return foundAnime;
	}

	public void createAnimeComment(Integer idAnime, User owner, String message) {
		Anime anime = getAnimeById(idAnime);
		
		if(anime != null) {
			if(owner != null) {
				AnimeComment ac = new AnimeComment();
				
				ac.setUser(owner);
				
				DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
				Date date = new Date();
				String dateString = dateFormat.format(date).replaceAll(" ", " à ");
				
				ac.setDate(dateString);
				ac.setAnime(anime);
				ac.setMessage(message);
				
				anime.getComments().add(ac);
				
				m_em.persist(ac);
				m_em.merge(anime);
			}
		}
	}

	public void updateAnimeState(Integer id, Integer state, User user) {
		if(user != null) {
			Anime anime = getAnimeById(id);
			
			if(anime != null) {
				AnimeData tsd = user.getAnimeData(id);
				
				if(tsd == null) {
					tsd = new AnimeData();
					
					tsd.setUser(user);
					tsd.setSeason(1);
					tsd.setEpisode(1);
					tsd.setAnime(getAnimeById(id));
					
					user.getAnimeDatas().add(tsd);
					anime.getAnimesDatas().add(tsd);
					
					m_em.persist(tsd);
				}

				tsd.setState(state);
				m_em.merge(tsd);
			}
		}
	}

	public void progressAnime(Integer idAnime, User user, Integer season,
			Integer episode) {
		Anime anime = getAnimeById(idAnime);
		
		if(anime != null) {
			if(user != null) {
				if(season > 0 && season <= anime.getSeasons()) {
					if(!(episode > 0 && episode <= anime.getEpisodes().get(season - 1))) {
						episode = 1;
					}
					
					if(season == anime.getSeasons() && episode == anime.getEpisodes().get(season - 1)) {
						updateAnimeState(idAnime, 1, user);
					} else {
						AnimeData ad = anime.getAnimeData(user.getId());
						
						ad.setSeason(season);
						ad.setEpisode(episode);
						
						m_em.merge(ad);
						
						ad = user.getAnimeData(idAnime);
						
						ad.setSeason(season);
						ad.setEpisode(episode);
						
						m_em.merge(ad);
					}
				}
			}
		}
	}

	public void createAnime(Integer idAnime, String title, String date,
			String poster, Integer duration, String description, int seasons,
			List<Integer> episodes, Double rating, Integer rating_count) {
		if(getAnimeById(idAnime) == null) {
			Anime newAnime = new Anime();
			
			newAnime.setId(idAnime);
			newAnime.setDate(getNewDate(date));
			newAnime.setTitle(title);
			newAnime.setPoster(BASE_PATH + poster);
			newAnime.setDuration(duration);
			newAnime.setDescription(description);
			newAnime.setSeasons(seasons);
			newAnime.setEpisodes(episodes);
			newAnime.setRating(rating);
			newAnime.setRating_count(rating_count);
			
			m_em.persist(newAnime);
		}
	}

	public List<Anime> getLastAnimesList() {
		List<Anime> allAnimes = getAnimesList();
		
		List<Anime> lastAnimes = allAnimes.subList(Math.max(allAnimes.size() - 3, 0), allAnimes.size());
		
		return lastAnimes;
	}
	
	public String getNewDate(String originalDate) {
	    int y = Integer.parseInt(originalDate.split("-")[0]);
	    int M = Integer.parseInt(originalDate.split("-")[1]);
	    int d = Integer.parseInt(originalDate.split("-")[2]);
	    String zerod = (d < 10) ? "0" : "";
	    String zeroM = (M < 10) ? "0" : "";
	    
	    String newDate = zerod + d + "/" + zeroM + M + "/" + y;
	    
	    return newDate;
	}

}
