package org.jeecgframework.web.system.pojo.base;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "sys_gl_type")
public class PESysGlType implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = -6235083974312719647L;
	private Long typeid;
	private String typename;
	private String nodepath;
	private Double depth;
	// private Long parentid;
	private PESysGlType PESysGlType;// 父类
	private String catkey;
	private String nodekey;
	private Long sn;
	private Long userid;
	private Long depid;
	private Double type;
	private Double isleaf;
	private String nodecode;
	private Double nodecodetype;
	private List<PESysGlType> PESysGlTypes = new ArrayList<PESysGlType>();

	// Constructors

	/** default constructor */
	public PESysGlType() {
	}

	/** minimal constructor */
	public PESysGlType(Long typeid, String typename, Double depth, String nodekey, Long sn) {
		this.typeid = typeid;
		this.typename = typename;
		this.depth = depth;
		this.nodekey = nodekey;
		this.sn = sn;
	}

	/** full constructor */
	public PESysGlType(Long typeid, String typename, String nodepath, Double depth, Long parentid, String catkey, String nodekey, Long sn,
			Long userid, Long depid, Double type, Double isleaf, String nodecode, Double nodecodetype) {
		this.typeid = typeid;
		this.typename = typename;
		this.nodepath = nodepath;
		this.depth = depth;
		this.catkey = catkey;
		this.nodekey = nodekey;
		this.sn = sn;
		this.userid = userid;
		this.depid = depid;
		this.type = type;
		this.isleaf = isleaf;
		this.nodecode = nodecode;
		this.nodecodetype = nodecodetype;
	}

	// Property accessors
	@Id
	@Column(name = "TYPEID", unique = true, nullable = false, precision = 18, scale = 0)
	public Long getTypeid() {
		return this.typeid;
	}

	public void setTypeid(Long typeid) {
		this.typeid = typeid;
	}

	@Column(name = "TYPENAME", nullable = false, length = 128)
	public String getTypename() {
		return this.typename;
	}

	public void setTypename(String typename) {
		this.typename = typename;
	}

	@Column(name = "NODEPATH", length = 200)
	public String getNodepath() {
		return this.nodepath;
	}

	public void setNodepath(String nodepath) {
		this.nodepath = nodepath;
	}

	@Column(name = "DEPTH", nullable = false, precision = 22, scale = 0)
	public Double getDepth() {
		return this.depth;
	}

	public void setDepth(Double depth) {
		this.depth = depth;
	}

	@Column(name = "CATKEY", length = 64)
	public String getCatkey() {
		return this.catkey;
	}

	public void setCatkey(String catkey) {
		this.catkey = catkey;
	}

	@Column(name = "NODEKEY", nullable = false, length = 64)
	public String getNodekey() {
		return this.nodekey;
	}

	public void setNodekey(String nodekey) {
		this.nodekey = nodekey;
	}

	@Column(name = "SN", nullable = false, precision = 18, scale = 0)
	public Long getSn() {
		return this.sn;
	}

	public void setSn(Long sn) {
		this.sn = sn;
	}

	@Column(name = "USERID", precision = 18, scale = 0)
	public Long getUserid() {
		return this.userid;
	}

	public void setUserid(Long userid) {
		this.userid = userid;
	}

	@Column(name = "DEPID", precision = 18, scale = 0)
	public Long getDepid() {
		return this.depid;
	}

	public void setDepid(Long depid) {
		this.depid = depid;
	}

	@Column(name = "TYPE", precision = 22, scale = 0)
	public Double getType() {
		return this.type;
	}

	public void setType(Double type) {
		this.type = type;
	}

	@Column(name = "ISLEAF", precision = 22, scale = 0)
	public Double getIsleaf() {
		return this.isleaf;
	}

	public void setIsleaf(Double isleaf) {
		this.isleaf = isleaf;
	}

	@Column(name = "NODECODE", length = 10)
	public String getNodecode() {
		return this.nodecode;
	}

	public void setNodecode(String nodecode) {
		this.nodecode = nodecode;
	}

	@Column(name = "NODECODETYPE", precision = 22, scale = 0)
	public Double getNodecodetype() {
		return this.nodecodetype;
	}

	public void setNodecodetype(Double nodecodetype) {
		this.nodecodetype = nodecodetype;
	}

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "PARENTID")
	public PESysGlType getPESysGlType() {
		return PESysGlType;
	}

	public void setPESysGlType(PESysGlType pESysGlType) {
		PESysGlType = pESysGlType;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "PESysGlType")
	public List<PESysGlType> getPESysGlTypes() {
		return PESysGlTypes;
	}

	public void setPESysGlTypes(List<PESysGlType> pESysGlTypes) {
		PESysGlTypes = pESysGlTypes;
	}

}