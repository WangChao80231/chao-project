<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${package.Mapper}.${table.mapperName}">

    <#if enableCache>
        <!-- 开启二级缓存 -->
        <cache type="org.mybatis.caches.ehcache.LoggingEhcache"/>

    </#if>
<#if baseResultMap>
    <!-- 通用查询映射结果 -->
    <resultMap id="BaseResultMap" type="${package.Entity}.${entity}">
    <#list table.fields as field>
        <#if field.keyFlag><#--生成主键排在第一位-->
        <id column="${field.name}" property="${field.propertyName}"/>
        </#if>
    </#list>
    <#list table.commonFields as field><#--生成公共字段 -->
        <result column="${field.name}" property="${field.propertyName}"/>
    </#list>
    <#list table.fields as field>
        <#if !field.keyFlag><#--生成普通字段 -->
        <result column="${field.name}" property="${field.propertyName}"/>
        </#if>
    </#list>
    </resultMap>

    </#if>
    <#if baseColumnList>
    <!-- 通用查询结果列 -->
    <sql id="Base_Column_List">
        <#list table.commonFields as field>
            ${field.name},
        </#list>
        ${table.fieldNames}
    </sql>

    </#if>

    <select id="getListPage"  resultType="${package.Entity}.vo.${entityVo}">
        select
        <include refid="BaseResultMap"/>
        from  ${table.name}
        where deleted = 0
    <#list table.commonFields as field><#--生成公共字段-->
        <if test="${field.propertyName}!=null and ${field.propertyName}!=''">
            AND ${field.name} = ${r"#{"}${field.propertyName}${r"}"}
        </if>
    </#list>
        <#list table.fields as field>
       <#if !field.keyFlag && field.propertyName != "id" && field.propertyName != "deleted" && field.propertyName != "createTime"
        && field.propertyName != "updateTime" &&field.propertyName != "createBy" && field.propertyName != "updateBy"><#--生成普通字段 -->
         <#if field.propertyType == 'String'>
        <if test="${field.propertyName}!=null and ${field.propertyName}!=''">
            AND ${field.name} = ${r"#{"}${field.propertyName}${r"}"}
        </if>
         <#else>
        <if test="${field.propertyName}!=null">
            AND ${field.name} = ${r"#{"}${field.propertyName}${r"}"}
        </if>
        </#if>
      </#if>
        </#list>
        <if test="page == null or page &lt; 1 ">
            LIMIT 0,${r"#{"}size${r"}"}
        </if>
        <if test="page != null and page &gt; 0 ">
            LIMIT ${r"${"}(page-1) * size${r"}"},${r"#{"}size${r"}"}
        </if>
    </select>

    <select id="getListPageCount"  resultType="int">
        select count(1)
        from  ${table.name}
        where deleted = 0
        <#list table.commonFields as field><#--生成公共字段-->
        <if test="${field.propertyName}!=null and ${field.propertyName}!=''">
            AND ${field.name} = ${r"#{"}${field.propertyName}${r"}"}
        </if>
        </#list>
        <#list table.fields as field>
    <#if !field.keyFlag && field.propertyName != "id" && field.propertyName != "deleted" && field.propertyName != "createTime"
    && field.propertyName != "updateTime" &&field.propertyName != "createBy" && field.propertyName != "updateBy"><#--生成普通字段 -->
        <#if field.propertyType == 'String'>
        <if test="${field.propertyName}!=null and ${field.propertyName}!=''">
            AND ${field.name} = ${r"#{"}${field.propertyName}${r"}"}
        </if>
        <#else>
        <if test="${field.propertyName}!=null">
            AND ${field.name} = ${r"#{"}${field.propertyName}${r"}"}
        </if>
        </#if>
    </#if>
        </#list>
    </select>
</mapper>
