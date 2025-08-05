package com.smhrd.web.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class TbMember {

  
	private String user_id;      
    private String user_pw;     
    private String user_nick;   
    private String user_birthdate; 
    private String user_gender;  
    private String joined_at;   
    
    
    // user_id와 user_pw만 받는 생성자 추가
    public TbMember(String user_id, String user_pw) {
        this.user_id = user_id;
        this.user_pw = user_pw;
    }
}


