package com.smhrd.web.model;

import lombok.Data;

@Data
public class ReviewVO {
    private int review_idx;
    private int snack_idx;  // 필요 없다면 빼도 됩니다.
    private String review_content;
    private String user_id;
    private String created_at;
}
