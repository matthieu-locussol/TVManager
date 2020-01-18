package tvmanager;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

@Entity
public class User {
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	private int id;
	
	private String mail;
	private String password;
	private String pseudonyme;
	
	@ManyToOne
	private Rank rank;
	
	@OneToMany(fetch = FetchType.EAGER)
	private List<MovieComment> movieComments;
	
	@OneToMany(fetch = FetchType.EAGER, mappedBy="user")
	private List<MovieData> movieDatas;
	
	@OneToMany(fetch = FetchType.EAGER)
	private List<TVShowComment> tvshowComments;
	
	@OneToMany(fetch = FetchType.EAGER, mappedBy="user")
	private List<TVShowData> tvshowDatas;
	
	@OneToMany(fetch = FetchType.EAGER)
	private List<AnimeComment> animeComments;
	
	@OneToMany(fetch = FetchType.EAGER, mappedBy="user")
	private List<AnimeData> animeDatas;
	
	@OneToMany(fetch = FetchType.EAGER, mappedBy="sender")
	private List<Ticket> tickets;
	
	public User() {
		
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getMail() {
		return mail;
	}

	public void setMail(String mail) {
		this.mail = mail;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPseudonyme() {
		return pseudonyme;
	}

	public void setPseudonyme(String pseudonyme) {
		this.pseudonyme = pseudonyme;
	}
	
	public Rank getRank() {
		return rank;
	}
	
	public void setRank(Rank rank) {
		this.rank = rank;
	}
	
	public List<MovieComment> getMovieComments() {
		return movieComments;
	}
	
	public List<TVShowComment> getTVShowComments() {
		return tvshowComments;
	}
	
	public List<AnimeComment> getAnimeComments() {
		return animeComments;
	}
	
	public MovieData getMovieData(int idMovie) {
		MovieData movieData = null;
		
		for(MovieData md : movieDatas) {
			if(md.getMovie().getId() == idMovie) {
				movieData = md;
				break;
			}
		}
		
		return movieData;
	}
	
	public List<MovieData> getMovieDatas() {
		return movieDatas;
	}
	
	public TVShowData getTVShowData(int idTVShow) {
		TVShowData tvshowData = null;
		
		for(TVShowData tsd : tvshowDatas) {
			if(tsd.getTVShow().getId() == idTVShow) {
				tvshowData = tsd;
				break;
			}
		}
		
		return tvshowData;
	}
	
	public List<TVShowData> getTVShowDatas() {
		return tvshowDatas;
	}
	
	public AnimeData getAnimeData(int idAnime) {
		AnimeData animeData = null;
		
		for(AnimeData ad : animeDatas) {
			if(ad.getAnime().getId() == idAnime) {
				animeData = ad;
				break;
			}
		}
		
		return animeData;
	}
	
	public List<AnimeData> getAnimeDatas() {
		return animeDatas;
	}

	public String getHashMail() {
		return MD5.md5Hex(mail);
	}
	
	public int getMoviesSeen() {
		int moviesSeen = 0;
				
		for(MovieData md : movieDatas) {
			if(md.getState() == 1) {
				++moviesSeen;
			}
		}
				
		return moviesSeen;
	}
	
	public int getTVShowsSeen() {
		int tvshowsSeen = 0;
		
		for(TVShowData tsd : tvshowDatas) {
			if(tsd.getState() == 1) {
				++tvshowsSeen;
			}
		}
				
		return tvshowsSeen;
	}
	
	public int getAnimesSeen() {
		int animesSeen = 0;
		
		for(AnimeData ad : animeDatas) {
			if(ad.getState() == 1) {
				++animesSeen;
			}
		}
				
		return animesSeen;
	}
	
	public int getTVShowsEpisodesSeen() {
		int tvshowsEpisodesSeen = 0;
		
		for(TVShowData tsd : tvshowDatas) {
			if(tsd.getState() == 2) {
				tvshowsEpisodesSeen += countEpisodesAt(tsd.getTVShow(), tsd.getSeason(), tsd.getEpisode());
			} else if(tsd.getState() == 1) {
				tvshowsEpisodesSeen += countEpisodesAt(tsd.getTVShow(), tsd.getTVShow().getSeasons(), tsd.getTVShow().getEpisodes().get(tsd.getTVShow().getSeasons() - 1));
			}
		}
				
		return tvshowsEpisodesSeen;
	}
	
	public int getAnimesEpisodesSeen() {
		int animesEpisodesSeen = 0;
		
		for(AnimeData ad : animeDatas) {
			if(ad.getState() == 2) {
				animesEpisodesSeen += countEpisodesAt(ad.getAnime(), ad.getSeason(), ad.getEpisode());
			} else if(ad.getState() == 1) {
				animesEpisodesSeen += countEpisodesAt(ad.getAnime(), ad.getAnime().getSeasons(), ad.getAnime().getEpisodes().get(ad.getAnime().getSeasons() - 1));
			}
		}
				
		return animesEpisodesSeen;
	}
	
	public String getTimeSpent() {
		int minutesSpent = getTimeSpentMovies() + getTimeSpentTVShows() + getTimeSpentAnimes();
		
		float hoursSpent = minutesSpent / 60.f;
		
		return String.format("%.01f", hoursSpent);
	}
	
	public int getTimeSpentMovies() {
		int timeSpent = 0;
		
		for(MovieData md : movieDatas) {
			if(md.getState() == 1) {
				timeSpent += md.getMovie().getDuration();
			}
		}
		
		return timeSpent;
	}
	
	public int getTimeSpentTVShows() {
		int timeSpent = 0;
		
		for(TVShowData tsd : tvshowDatas) {
			if(tsd.getState() == 2) {
				timeSpent += countEpisodesAt(tsd.getTVShow(), tsd.getSeason(), tsd.getEpisode()) * tsd.getTVShow().getDuration();
			} else if(tsd.getState() == 1) {
				timeSpent += countEpisodesAt(tsd.getTVShow(), tsd.getTVShow().getSeasons(), tsd.getTVShow().getEpisodes().get(tsd.getTVShow().getSeasons() - 1)) * tsd.getTVShow().getDuration();
			}
		}
		
		return timeSpent;
	}
	
	public int getTimeSpentAnimes() {
		int timeSpent = 0;
		
		for(AnimeData ad : animeDatas) {
			if(ad.getState() == 2) {
				timeSpent += countEpisodesAt(ad.getAnime(), ad.getSeason(), ad.getEpisode()) * ad.getAnime().getDuration();
			} else if(ad.getState() == 1) {
				timeSpent += countEpisodesAt(ad.getAnime(), ad.getAnime().getSeasons(), ad.getAnime().getEpisodes().get(ad.getAnime().getSeasons() - 1)) * ad.getAnime().getDuration();
			}
		}
		
		return timeSpent;
	}
	
	public int countEpisodesAt(TVShow tvshow, int season, int episodes) {
		int count = 0;
		
		for(int i = 1 ; i <= season ; ++i) {
			int countEpisodes = tvshow.getEpisodes().get(i - 1);
			
			if(i == season) {
				count += episodes;
			} else {
				count += countEpisodes;
			}
		}
		
		return count;
	}
	
	public int countEpisodesAt(Anime anime, int season, int episodes) {
		int count = 0;
		
		for(int i = 1 ; i <= season ; ++i) {
			int countEpisodes = anime.getEpisodes().get(i - 1);
			
			if(i == season) {
				count += episodes;
			} else {
				count += countEpisodes;
			}
		}
		
		return count;
	}

}
