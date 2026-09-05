package vn.iotstar.entity;

import java.io.Serializable;
import jakarta.persistence.*;

@Entity
@Table(name="users") 
@NamedQuery(name="User.findAll", query="SELECT u FROM User u")
public class User implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="id")
	private int id;

	@Column(name="username", columnDefinition ="VARCHAR(255) NULL")
	private String userName;

	@Column(name="password", columnDefinition ="VARCHAR(255) NULL")
	private String passWord;

	@Column(name="email", columnDefinition ="VARCHAR(255) NULL")
	private String email;

	@Column(name="fullname", columnDefinition ="NVARCHAR(255) NULL")
	private String fullName;

	@Column(name="roleid")
	private Integer roleid = 3;

	@Column(name="phone", columnDefinition ="VARCHAR(20) NULL")
	private String phone;

	@Column(name="status")
	private Integer status = 1; // 1: Active, 0: Pending activation

	@Column(name="code", columnDefinition ="VARCHAR(50) NULL")
	private String code; // OTP code

	@Column(name="images", columnDefinition ="VARCHAR(255) NULL")
	private String images;

	public User() {
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPassWord() {
		return passWord;
	}

	public void setPassWord(String passWord) {
		this.passWord = passWord;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getFullName() {
		return fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
	}

	public int getRoleid() {
		return roleid != null ? roleid : 3;
	}

	public void setRoleid(Integer roleid) {
		this.roleid = roleid != null ? roleid : 3;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public int getStatus() {
		return status != null ? status : 1;
	}

	public void setStatus(Integer status) {
		this.status = status != null ? status : 1;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getImages() {
		return images;
	}

	public void setImages(String images) {
		this.images = images;
	}
}