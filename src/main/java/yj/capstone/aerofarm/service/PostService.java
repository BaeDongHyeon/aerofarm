package yj.capstone.aerofarm.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import yj.capstone.aerofarm.controller.form.PostForm;
import yj.capstone.aerofarm.domain.board.Post;
import yj.capstone.aerofarm.domain.member.Member;
import yj.capstone.aerofarm.repository.PostRepository;

import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional
public class PostService {

    private final PostRepository postRepository;

    // 게시글 등록
    public Post createPost(Member writer, PostForm postForm) {

        Post post = Post.postBuilder()
                .postForm(postForm)
                .writer(writer)
                .build();

        postRepository.save(post);
        return post;
    }
    
//    // 게시글 상세 등록
//    public PostDetail createPostDetail(PostDetail postDetail) {
//
//        PostDetail resultPostDetail = postDetailRepository.save(postDetail);
//        return resultPostDetail;
//    }

    // 게시글 목록 조회
    public List<Post> findPosts() {
        return postRepository.findAll();
    }

    //게시글 필터링

}
