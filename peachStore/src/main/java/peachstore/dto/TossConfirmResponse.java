package peachstore.dto;

import java.time.OffsetDateTime;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Getter;
import lombok.Setter;

// 토스 Confirm API 응답용 DTO

@Getter @Setter
@JsonIgnoreProperties(ignoreUnknown = true)
public class TossConfirmResponse {
    private String method;
    private String status;

    // OffsetDateTime 타입으로 받음
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ssXXX")
    private OffsetDateTime requestedAt;

    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ssXXX")
    private OffsetDateTime approvedAt;
}