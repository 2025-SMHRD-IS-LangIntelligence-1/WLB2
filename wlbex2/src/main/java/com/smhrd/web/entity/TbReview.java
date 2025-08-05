package com.smhrd.web.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class TbReview {
    private int review_idx;
    private String target_type="snack"; // ENUM('movie', 'snack')
    private int target_idx=1;
    private String review_content;
    private String created_at; // Timestamp로 써도 OK
    private String user_id="testUser";
}
