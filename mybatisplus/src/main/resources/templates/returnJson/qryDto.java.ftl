package ${package.Entity}.dto;

<#list table.importPackages as pkg>
import ${pkg};
</#list>
<#if swagger>

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
</#if>
<#if entityLombokModel>
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;
import com.fasterxml.jackson.annotation.JsonFormat;
import java.time.LocalDateTime;
</#if>

/**
 * <p>
 * ${table.comment!}查询Dto类
 * </p>
 *
 * @author ${author}
 * @since ${date}
 */
<#if entityLombokModel>
@Data
    <#if superEntityClass??>
@EqualsAndHashCode(callSuper = true)
    <#else>
@EqualsAndHashCode(callSuper = false)
    </#if>
@Accessors(chain = true)
</#if>
<#if swagger>
@ApiModel(value="${entityQryDto}对象", description="${table.comment!}查询Dto")
</#if>
public class ${entityQryDto} implements Serializable {

<#if entitySerialVersionUID>
    private static final long serialVersionUID = 1L;
</#if>
<#-- ----------  BEGIN 字段循环遍历  ---------->
<#list table.fields as field>
    <#if field.name != "id" && field.name != "deleted" && field.name != "create_time" && field.name != "update_time" &&
    field.name != "create_by" && field.name != "update_by" && field.name != "update_user" && field.name != "create_user" &&  field.name != "modify_user" && field.name != "modify_time">
    <#if field.keyFlag>
        <#assign keyPropertyName="${field.propertyName}"/>
    </#if>

    <#if field.comment!?length gt 0>
        <#if swagger>
    @ApiModelProperty(value = "${field.comment}")
        <#else>
    /**
     * ${field.comment}
     */
        </#if>
    </#if>
    private <#if (logicDeleteFieldName!"") == field.name >Integer<#elseif field.metaInfo.jdbcType='TINYINT'>Integer<#else>${field.propertyType}</#if> ${field.propertyName};
  </#if>
</#list>

    @ApiModelProperty(value = "开始时间")
    @JsonFormat(timezone = "GMT+8", pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime startTime;

    @ApiModelProperty(value = "结束时间")
    @JsonFormat(timezone = "GMT+8", pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime endTime;
}
