package tvmanager;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.ElementCollection;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

@Entity
public class Anime {
	
	@Id
	private int id;

	private int duration;
	
	private String date;
	private String title;
	private String poster;
	
	private Double rating;
	private Integer rating_count;
	
	private int seasons;
	
	@ElementCollection(fetch = FetchType.EAGER)
	private List<Integer> episodes = new ArrayList<Integer>();
	
	@Column(columnDefinition = "LONGTEXT")
	private String description;
	
	@OneToMany(fetch = FetchType.EAGER, mappedBy="anime")
	private Set<AnimeData> animeDatas;
	
	@OneToMany(fetch = FetchType.EAGER)
	private Set<AnimeComment> comments;
	
	public Anime() {
		
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getDuration() {
		return duration;
	}

	public void setDuration(int duration) {
		this.duration = duration;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getPoster() {
		return poster;
	}

	public void setPoster(String poster) {
		this.poster = poster;
	}

	public int getSeasons() {
		return seasons;
	}

	public void setSeasons(int seasons) {
		this.seasons = seasons;
	}

	public List<Integer> getEpisodes() {
		return episodes;
	}

	public void setEpisodes(List<Integer> episodes) {
		this.episodes = episodes;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
	public Double getRating() {
		return rating;
	}

	public void setRating(Double rating) {
		this.rating = rating;
	}

	public Integer getRating_count() {
		return rating_count;
	}

	public void setRating_count(Integer rating_count) {
		this.rating_count = rating_count;
	}

	public Set<AnimeComment> getComments() {
		return comments;
	}
	
	public String getAverageNote() {
		return getRating() + " (" + getRating_count() + " votes)";
	}
	
	public int getViewersCount() {
		int viewers = 0;
		
		for(AnimeData ad : animeDatas) {
			if(ad.getState() == 1) {
				++viewers;
			}
		}
		
		return viewers;
	}
	
	public Set<AnimeData> getAnimesDatas() {
		return animeDatas;
	}
	
	public AnimeData getAnimeData(int idUser) {
		AnimeData animeData = null;
		
		for(AnimeData ad : animeDatas) {
			if(ad.getUser().getId() == idUser) {
				animeData = ad;
				break;
			}
		}
		
		return animeData;
	}
	
	public int getFollowersCount() {
		int followers = 0;
		
		for(AnimeData ad : animeDatas) {
			if(ad.getState() != 0) {
				++followers;
			}
		}
		
		return followers;
	}
	
}
