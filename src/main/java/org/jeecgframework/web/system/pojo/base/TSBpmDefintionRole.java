package org.jeecgframework.web.system.pojo.base;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.jeecgframework.core.common.entity.IdEntity;

/**
 * 
 * @ClassName: TSRoleBpmDefintion
 * @Description: TODO
 * @CreateDate 2016-7-28
 * @Author 赵宝坤
 * 
 */
@Entity
@Table(name = "t_s_bpm_defintion_role")
public class TSBpmDefintionRole extends IdEntity implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -1441338871783675206L;

	private BpmDefinition BpmDefinition;
	private TSRole TSRole;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "BPM_DEF_ID")
	public BpmDefinition getBpmDefinition() {
		return BpmDefinition;
	}

	public void setBpmDefinition(BpmDefinition bpmDefinition) {
		BpmDefinition = bpmDefinition;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "ROLE_ID")
	public TSRole getTSRole() {
		return TSRole;
	}

	public void setTSRole(TSRole tSRole) {
		TSRole = tSRole;
	}

}