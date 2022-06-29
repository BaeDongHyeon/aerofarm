package yj.capstone.aerofarm.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import yj.capstone.aerofarm.domain.board.PostFilter;
import yj.capstone.aerofarm.dto.PostDto;
import yj.capstone.aerofarm.domain.board.PostCategory;

import java.util.List;

public interface PostRepositoryCustom {
    Page<PostDto> findPostInfo(PostCategory category, String searchCategory, String keyword, PostFilter postFilter, Pageable pageable);
    List<PostDto> findAnswerPostInfo(PostCategory category, String searchCategory, String keyword, PostFilter postFilter);
    Integer findMaxGroupIdInfo();
}