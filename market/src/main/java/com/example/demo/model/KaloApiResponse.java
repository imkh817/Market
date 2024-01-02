package com.example.demo.model;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.List;

public class KaloApiResponse {

	@JsonProperty("id")
	private String id;

	@JsonProperty("model_version")
	private String modelVersion;

	@JsonProperty("images")
	private List<Image> images;

	public static class Image {
		@JsonProperty("id")
		private String id;

		@JsonProperty("seed")
		private Integer seed;

		@JsonProperty("image")
		private String image;

		@JsonProperty("nsfw_content_detected")
		private Boolean nsfwContentDetected;

		@JsonProperty("nsfw_score")
		private Double nsfwScore;
	}

}
