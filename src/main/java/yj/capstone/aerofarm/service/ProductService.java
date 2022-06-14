package yj.capstone.aerofarm.service;

import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import yj.capstone.aerofarm.domain.member.Member;
import yj.capstone.aerofarm.domain.product.ProductCategory;
import yj.capstone.aerofarm.domain.product.ProductReview;
import yj.capstone.aerofarm.dto.ProductReviewDto;
import yj.capstone.aerofarm.dto.ProductStoreInfoDto;
import yj.capstone.aerofarm.dto.StoreReviewDto;
import yj.capstone.aerofarm.form.SaveProductForm;
import yj.capstone.aerofarm.domain.product.Product;
import yj.capstone.aerofarm.repository.ProductRepository;

import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional
public class ProductService {

    private final ProductRepository productRepository;
    private final S3Service s3Service;

    public Product save(SaveProductForm saveProductForm) {
        Product product = Product.builder()
                .saveProductForm(saveProductForm)
                .build();

        String imageUrl = s3Service.uploadImage(saveProductForm.getImage(), 400, 500, true);
        product.changeImage(imageUrl);

        return productRepository.save(product);
    }

    public Product findProductById(Long productId) {
        return productRepository.findById(productId).orElseThrow(() -> new IllegalArgumentException("해당 상품이 없습니다."));
    }

    public List<Product> findAll() {
        return productRepository.findAll();
    }

    public Page<ProductStoreInfoDto> findProductInfo(ProductCategory category, String order, Integer page) {
        // Page가 0부터 시작하기 때문에 -1 해줌
        PageRequest pageRequest = PageRequest.of(page - 1, 10);
        return productRepository.findProductInfo(category, order, pageRequest);
    }

    public Page<StoreReviewDto> findProductReviews(Long productId, Integer page) {
        PageRequest pageRequest = PageRequest.of(page - 1, 10);
        return productRepository.findStoreReview(pageRequest, productId);
    }

    public void deleteProduct(Long productId) {
        Product product = findProductById(productId);
        s3Service.deleteFile(product.getImageUrl());
        productRepository.delete(product);
    }

    public void createReview(List<ProductReviewDto> reviews, Member member) {
        for (ProductReviewDto review : reviews) {
            Long productId = review.getProductId();
            Product product = findProductById(productId);
            ProductReview.builder()
                    .review(review.getReview())
                    .product(product)
                    .score(review.getScore())
                    .member(member)
                    .build();
//            productRepository.save(pro)
        }
    }
}
