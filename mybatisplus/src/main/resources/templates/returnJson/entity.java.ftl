package ${package.Entity};

<#list table.importPackages as pkg>
import ${pkg};
</#list>
<#--<#if swagger>-->
<#--import io.swagger.annotations.ApiModel;-->
<#--import io.swagger.annotations.ApiModelProperty;-->
<#--</#if>-->
<#if entityLombokModel>
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;
</#if>

/**
 * <p>
 * ${table.comment!}
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
<#if table.convert>
@TableName("${table.name}")
</#if>
public class ${entity} extends Model<${entity}> {

<#if entitySerialVersionUID>
    private static final long serialVersionUID = 1L;
</#if>
<#-- ----------  BEGIN 字段循环遍历  ---------->
<#list table.fields as field>
    <#if field.keyFlag>
        <#assign keyPropertyName="${field.propertyName}"/>
    </#if>

    <#if field.comment!?length gt 0>
    /**
     * ${field.comment}
     */
    </#if>
    <#if field.keyFlag>
        <#-- 主键 -->
<#--        <#if field.keyIdentityFlag>-->
<#--    @TableId(value = "${field.name}", type = IdType.AUTO)-->
<#--        <#elseif idType??>-->
<#--    @TableId(value = "${field.name}", type = IdType.${idType})-->
<#--        <#elseif field.convert>-->
<#--    @TableId("${field.name}")-->
<#--        </#if>-->
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
    private <#if (logicDeleteFieldName!"") == field.name >Integer<#elseif field.metaInfo.jdbcType='TINYINT'>Integer<#else>${field.propertyType}</#if> ${field.propertyName};
</#list>
}
