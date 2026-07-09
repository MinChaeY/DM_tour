package common;


public class ShopInfo {
    private int no;
    private String name;
    private String image;
    private String contents;
    private String kind;
    private String open;
    private String close;
    private String break_time;
    private String day_off;
    private int distance;
    private String weather;
    private String naver;
    private String google;
    private String kakao;
    private int view;
    
    public ShopInfo(int no, String name, String image, String contents, String kind, String open, String close,
			String break_time, String day_off, int distance, String weather, String naver, String google, String kakao,
			int view) {
		super();
		this.no=no;
		this.name = name;
		this.image = image;
		this.contents = contents;
		this.kind = kind;
		this.open = open;
		this.close = close;
		this.break_time = break_time;
		this.day_off = day_off;
		this.distance = distance;
		this.weather = weather;
		this.naver = naver;
		this.google = google;
		this.kakao = kakao;
		this.view = view;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public String getKind() {
		return kind;
	}

	public void setKind(String kind) {
		this.kind = kind;
	}

	public String getOpen() {
		return open;
	}

	public void setOpen(String open) {
		this.open = open;
	}

	public String getClose() {
		return close;
	}

	public void setClose(String close) {
		this.close = close;
	}

	public String getBreak_time() {
		return break_time;
	}

	public void setBreak_time(String break_time) {
		this.break_time = break_time;
	}

	public String getDay_off() {
		return day_off;
	}

	public void setDay_off(String day_off) {
		this.day_off = day_off;
	}

	public int getDistance() {
		return distance;
	}

	public void setDistance(int distance) {
		this.distance = distance;
	}

	public String getWeather() {
		return weather;
	}

	public void setWeather(String weather) {
		this.weather = weather;
	}

	public String getNaver() {
		return naver;
	}

	public void setNaver(String naver) {
		this.naver = naver;
	}

	public String getGoogle() {
		return google;
	}

	public void setGoogle(String google) {
		this.google = google;
	}

	public String getKakao() {
		return kakao;
	}

	public void setKakao(String kakao) {
		this.kakao = kakao;
	}

	public int getView() {
		return view;
	}

	public void setView(int view) {
		this.view = view;
	}
}
