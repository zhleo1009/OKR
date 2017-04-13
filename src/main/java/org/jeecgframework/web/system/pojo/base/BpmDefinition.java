package org.jeecgframework.web.system.pojo.base;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.HashSet;
import java.util.Set;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * BpmDefinition entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "bpm_definition")
public class BpmDefinition implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 2328582622859773L;
	private Long defid;
	private Long typeid;
	private String subject;
	private String defkey;
	private String tasknamerule;
	private String descp;
	private BigDecimal status;
	private String defxml;
	private Long actdeployid;
	private String actdefkey;
	private String actdefid;
	private Timestamp createtime;
	private Timestamp updatetime;
	private Long createby;
	private Long updateby;
	private String reason;
	private BigDecimal versionno;
	private Long parentdefid;
	private BigDecimal ismain;
	private Boolean tofirstnode;
	private Boolean needstartform;
	private BigDecimal showfirstassignee;
	private String startfirstnode;
	private String canchoicepath;
	private BigDecimal isuseoutform;
	private String formdetailurl;
	private String taskEntryUrl;
	private Set<TSBpmDefintionRole> TBpmDefintionRoles = new HashSet<TSBpmDefintionRole>(0);

	// Constructors

	/** default constructor */
	public BpmDefinition() {
	}

	/** minimal constructor */
	public BpmDefinition(Long defid, String subject, String defkey) {
		this.defid = defid;
		this.subject = subject;
		this.defkey = defkey;
	}

	/** full constructor */
	public BpmDefinition(Long defid, Long typeid, String subject, String defkey, String tasknamerule, String descp, BigDecimal status, String defxml,
			Long actdeployid, String actdefkey, String actdefid, Timestamp createtime, Timestamp updatetime, Long createby, Long updateby,
			String reason, BigDecimal versionno, Long parentdefid, BigDecimal ismain, Boolean tofirstnode, Boolean needstartform,
			BigDecimal showfirstassignee, String startfirstnode, String canchoicepath, BigDecimal isuseoutform, String formdetailurl,
			String taskEntryUrl, Set<TSBpmDefintionRole> TBpmDefintionRoles) {
		this.defid = defid;
		this.typeid = typeid;
		this.subject = subject;
		this.defkey = defkey;
		this.tasknamerule = tasknamerule;
		this.descp = descp;
		this.status = status;
		this.defxml = defxml;
		this.actdeployid = actdeployid;
		this.actdefkey = actdefkey;
		this.actdefid = actdefid;
		this.createtime = createtime;
		this.updatetime = updatetime;
		this.createby = createby;
		this.updateby = updateby;
		this.reason = reason;
		this.versionno = versionno;
		this.parentdefid = parentdefid;
		this.ismain = ismain;
		this.tofirstnode = tofirstnode;
		this.needstartform = needstartform;
		this.showfirstassignee = showfirstassignee;
		this.startfirstnode = startfirstnode;
		this.canchoicepath = canchoicepath;
		this.isuseoutform = isuseoutform;
		this.formdetailurl = formdetailurl;
		this.taskEntryUrl = taskEntryUrl;
		this.TBpmDefintionRoles = TBpmDefintionRoles;
	}

	// Property accessors
	@Id
	@Column(name = "DEFID", unique = true, nullable = false, precision = 18, scale = 0)
	public Long getDefid() {
		return this.defid;
	}

	public void setDefid(Long defid) {
		this.defid = defid;
	}

	@Column(name = "TYPEID", precision = 18, scale = 0)
	public Long getTypeid() {
		return this.typeid;
	}

	public void setTypeid(Long typeid) {
		this.typeid = typeid;
	}

	@Column(name = "SUBJECT", nullable = false, length = 65535)
	public String getSubject() {
		return this.subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	@Column(name = "DEFKEY", nullable = false, length = 128)
	public String getDefkey() {
		return this.defkey;
	}

	public void setDefkey(String defkey) {
		this.defkey = defkey;
	}

	@Column(name = "TASKNAMERULE", length = 65535)
	public String getTasknamerule() {
		return this.tasknamerule;
	}

	public void setTasknamerule(String tasknamerule) {
		this.tasknamerule = tasknamerule;
	}

	@Column(name = "DESCP", length = 65535)
	public String getDescp() {
		return this.descp;
	}

	public void setDescp(String descp) {
		this.descp = descp;
	}

	@Column(name = "STATUS", precision = 22, scale = 0)
	public BigDecimal getStatus() {
		return this.status;
	}

	public void setStatus(BigDecimal status) {
		this.status = status;
	}

	@Column(name = "DEFXML")
	public String getDefxml() {
		return this.defxml;
	}

	public void setDefxml(String defxml) {
		this.defxml = defxml;
	}

	@Column(name = "ACTDEPLOYID", precision = 18, scale = 0)
	public Long getActdeployid() {
		return this.actdeployid;
	}

	public void setActdeployid(Long actdeployid) {
		this.actdeployid = actdeployid;
	}

	@Column(name = "ACTDEFKEY")
	public String getActdefkey() {
		return this.actdefkey;
	}

	public void setActdefkey(String actdefkey) {
		this.actdefkey = actdefkey;
	}

	@Column(name = "ACTDEFID", length = 128)
	public String getActdefid() {
		return this.actdefid;
	}

	public void setActdefid(String actdefid) {
		this.actdefid = actdefid;
	}

	@Column(name = "CREATETIME", length = 19)
	public Timestamp getCreatetime() {
		return this.createtime;
	}

	public void setCreatetime(Timestamp createtime) {
		this.createtime = createtime;
	}

	@Column(name = "UPDATETIME", length = 19)
	public Timestamp getUpdatetime() {
		return this.updatetime;
	}

	public void setUpdatetime(Timestamp updatetime) {
		this.updatetime = updatetime;
	}

	@Column(name = "CREATEBY", precision = 18, scale = 0)
	public Long getCreateby() {
		return this.createby;
	}

	public void setCreateby(Long createby) {
		this.createby = createby;
	}

	@Column(name = "UPDATEBY", precision = 18, scale = 0)
	public Long getUpdateby() {
		return this.updateby;
	}

	public void setUpdateby(Long updateby) {
		this.updateby = updateby;
	}

	@Column(name = "REASON", length = 65535)
	public String getReason() {
		return this.reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	@Column(name = "VERSIONNO", precision = 22, scale = 0)
	public BigDecimal getVersionno() {
		return this.versionno;
	}

	public void setVersionno(BigDecimal versionno) {
		this.versionno = versionno;
	}

	@Column(name = "PARENTDEFID", precision = 18, scale = 0)
	public Long getParentdefid() {
		return this.parentdefid;
	}

	public void setParentdefid(Long parentdefid) {
		this.parentdefid = parentdefid;
	}

	@Column(name = "ISMAIN", precision = 22, scale = 0)
	public BigDecimal getIsmain() {
		return this.ismain;
	}

	public void setIsmain(BigDecimal ismain) {
		this.ismain = ismain;
	}

	@Column(name = "TOFIRSTNODE", precision = 1, scale = 0)
	public Boolean getTofirstnode() {
		return this.tofirstnode;
	}

	public void setTofirstnode(Boolean tofirstnode) {
		this.tofirstnode = tofirstnode;
	}

	@Column(name = "NEEDSTARTFORM", precision = 1, scale = 0)
	public Boolean getNeedstartform() {
		return this.needstartform;
	}

	public void setNeedstartform(Boolean needstartform) {
		this.needstartform = needstartform;
	}

	@Column(name = "SHOWFIRSTASSIGNEE", precision = 22, scale = 0)
	public BigDecimal getShowfirstassignee() {
		return this.showfirstassignee;
	}

	public void setShowfirstassignee(BigDecimal showfirstassignee) {
		this.showfirstassignee = showfirstassignee;
	}

	@Column(name = "STARTFIRSTNODE", length = 200)
	public String getStartfirstnode() {
		return this.startfirstnode;
	}

	public void setStartfirstnode(String startfirstnode) {
		this.startfirstnode = startfirstnode;
	}

	@Column(name = "CANCHOICEPATH", length = 65535)
	public String getCanchoicepath() {
		return this.canchoicepath;
	}

	public void setCanchoicepath(String canchoicepath) {
		this.canchoicepath = canchoicepath;
	}

	@Column(name = "ISUSEOUTFORM", precision = 22, scale = 0)
	public BigDecimal getIsuseoutform() {
		return this.isuseoutform;
	}

	public void setIsuseoutform(BigDecimal isuseoutform) {
		this.isuseoutform = isuseoutform;
	}

	@Column(name = "FORMDETAILURL", length = 65535)
	public String getFormdetailurl() {
		return this.formdetailurl;
	}

	public void setFormdetailurl(String formdetailurl) {
		this.formdetailurl = formdetailurl;
	}

	@Column(name = "TASK_ENTRY_URL", length = 256)
	public String getTaskEntryUrl() {
		return this.taskEntryUrl;
	}

	public void setTaskEntryUrl(String taskEntryUrl) {
		this.taskEntryUrl = taskEntryUrl;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "bpmDefinition")
	public Set<TSBpmDefintionRole> getTBpmDefintionRoles() {
		return TBpmDefintionRoles;
	}

	public void setTBpmDefintionRoles(Set<TSBpmDefintionRole> tBpmDefintionRoles) {
		TBpmDefintionRoles = tBpmDefintionRoles;
	}

	
	

}