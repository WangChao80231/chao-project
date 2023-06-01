package ${package.Entity}.dto;

<#list table.importPackages as pkg>
     <#if pkg != "com.baomidou.mybatisplus.annotation.FieldFill" &&
     pkg != "com.baomidou.mybatisplus.annotation.TableField" &&
     pkg != "com.baomidou.mybatisplus.annotation.TableLogic" &&
     pkg != "com.baomidou.mybatisplus.annotation.TableName" &&
     pkg != "com.baomidou.mybatisplus.extension.activerecord.Model">
import ${pkg};
     </#if>
</#list>
<#if swagger>
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
</#if>
import javax.validation.constraints.NotNull;
import javax.validation.constraints.NotBlank;
<#if entityLombokModel>
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;
import com.fasterxml.jackson.annotation.JsonFormat;
</#if>

/**
 * <p>
 * ${table.comment!}新增Dto类
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
@ApiModel(value="${entitySaveDto}对象", description="${table.comment!}新增Dto")
</#if>
public class ${entitySaveDto} implements Serializable {

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
                <#if !field.metaInfo.nullable>
                    <#if field.metaInfo.jdbcType='VARCHAR' || field.metaInfo.jdbcType='CHAR'>
    @NotBlank(message = "${field.comment}不能为空")
    @ApiModelProperty(value = "${field.comment}", required = true)
                    <#else>
    @NotNull(message = "${field.comment}不能为空")
    @ApiModelProperty(value = "${field.comment}", required = true)
                    </#if>
                <#else>
    @ApiModelProperty(value = "${field.comment}")
                </#if>
            <#else>
            /**
            * ${field.comment}
            */
             </#if>
        </#if>
    <#if field.keyFlag>
        <#-- 普通字段 -->
    <#elseif field.fill??>
    <#-- -----   存在字段填充设置   ----->
        <#if field.convert>
    @TableField(value = "${field.name}", fill = FieldFill.${field.fill})
        <#else>
    @TableField(fill = FieldFill.${field.fill})
        </#if>
    <#elseif field.convert>
    @TableField("${field.name}")
    </#if>
    <#-- 乐观锁注解 -->
    <#if (versionFieldName!"") == field.name>
    @Version
    </#if>
    <#-- 逻辑删除注解 -->
    <#if (logicDeleteFieldName!"") == field.name>
    @TableLogic
    </#if>
    <#if field.propertyType == "LocalDateTime" >
    @JsonFormat(timezone = "GMT+8", pattern = "yyyy-MM-dd HH:mm:ss")
    </#if>
    <#if field.propertyType == "LocalDate" >
    @JsonFormat(timezone = "GMT+8", pattern = "yyyy-MM-dd")
    </#if>
    private <#if (logicDeleteFieldName!"") == field.name >Integer<#elseif field.metaInfo.jdbcType='TINYINT'>Integer<#else>${field.propertyType}</#if> ${field.propertyName};
    </#if>
</#list>
}
