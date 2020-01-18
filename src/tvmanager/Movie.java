package tvmanager;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

@Entity
public class Movie {
	
	@Id
	private int id;

	private int duration;
	
	private String date;
	private String title;
	private String poster;
	
	private double rating;
	private int rating_count;
	
	@Column(columnDefinition = "LONGTEXT")
	private String description;
	
	@OneToMany(fetch = FetchType.EAGER, mappedBy="movie")
	private List<MovieData> movieDatas;
	
	@OneToMany(fetch = FetchType.EAGER)
	private List<MovieComment> comments;
	
	public Movie() {
		
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

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
	public double getRating() {
		return rating;
	}

	public void setRating(double rating) {
		this.rating = rating;
	}

	public int getRating_count() {
		return rating_count;
	}

	public void setRating_count(int rating_count) {
		this.rating_count = rating_count;
	}

	public List<MovieComment> getComments() {
		return comments;
	}
	
	public String getAverageNote() {
		return getRating() + " (" + getRating_count() + " votes)";
	}
	
	public int getViewersCount() {
		int viewers = 0;
		
		for(MovieData md : movieDatas) {
			if(md.getState() == 1) {
				++viewers;
			}
		}
		
		return viewers;
	}
	
	public List<MovieData> getMovieDatas() {
		return movieDatas;
	}
	
	public MovieData getMovieData(int idUser) {
		MovieData movieData = null;
		
		for(MovieData md : movieDatas) {
			if(md.getUser().getId() == idUser) {
				movieData = md;
				break;
			}
		}
		
		return movieData;
	}
	
	public int getFollowersCount() {
		int followers = 0;
		
		for(MovieData md : movieDatas) {
			if(md.getState() != 0) {
				++followers;
			}
		}
		
		return followers;
	}

}
