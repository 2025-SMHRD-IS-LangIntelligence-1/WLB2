package com.smhrd.web.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.smhrd.web.entity.TbReview;

@Mapper
public interface ReviewMapper {

	@Insert("insert into tb_review (target_type, review_content, created_at, user_id, target_idx) values (#{target_type}, #{review_content}, NOW(), 'syh8407', #{target_idx} )")
	void insert(TbReview review);

	@Select("SELECT * FROM tb_review ORDER BY created_at DESC")
	List<TbReview> getAllReviews();

}
