package vn.iotstar.entity;

import java.io.Serializable;
import java.util.Date;
import jakarta.persistence.*;

@Entity
@Table(name="products")
@NamedQuery(name="Product.findAll", query="SELECT p FROM Product p")
public class Product implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="productId")
    private int productId;

    @Column(name="productName", columnDefinition ="NVARCHAR(255) NOT NULL")
    private String productName;

    @Column(name="price")
    private double price;

    @Column(name="quantity")
    private int quantity;

    @Column(name="description", columnDefinition ="NVARCHAR(MAX) NULL")
    private String description;

    @Column(name="images", columnDefinition ="NVARCHAR(255) NULL")
    private String images;

    @Column(name="status")
    private int status = 1;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="createdDate")
    private Date createdDate = new Date();

    
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name="categoryId")
    private Category category;

    public Product() {
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImages() {
        return images;
    }

    public void setImages(String images) {
        this.images = images;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    
    public int getId() {
        return productId;
    }

    public String getName() {
        return productName;
    }

    public String getImage() {
        return images;
    }
}
