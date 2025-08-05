package com.smhrd.web.mapper;

import com.smhrd.web.entity.TbMember;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface MemberMapper {

    // 회원가입 시 데이터 삽입
    @Insert("INSERT INTO tb_member (user_id, user_pw, user_nick, user_birthdate, user_gender, joined_at) " +
            "VALUES (#{user_id}, #{user_pw}, #{user_nick}, #{user_birthdate}, #{user_gender}, NOW())")
    void insert(TbMember member);
    @Select("SELECT * FROM tb_member WHERE user_id = #{user_id}")
    TbMember selectById(String user_id);

	@Select("SELECT * FROM tb_member WHERE user_id=#{user_id} AND user_pw = #{user_pw}")
	TbMember login(TbMember mem);
}
